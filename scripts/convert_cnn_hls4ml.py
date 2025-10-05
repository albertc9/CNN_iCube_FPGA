#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Keras→hls4ml converter (no CLI).
Edit the CONFIG below; run:  python convert_cnn_hls4ml.py
"""

import json, sys
from pathlib import Path
import numpy as np

# ====== EDIT HERE: all your parameters in one place ======
CONFIG = {
    # Paths
    "model": "models/09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5",
    "outdir": "hls_cnn_conv2d",
    "sample": "data/Event2016_Stn14_1454540191.0_Chi0.66_SNR5.57.npy",

    # HLS tool/flow
    "part": "xcku5p-ffvb676-2-e",
    "backend": "Vitis",            # "Vivado" or "Vitis"
    "io": "io_stream",              # "io_stream" or "io_parallel"

    # Quantization / scheduling
    "precision": "ap_fixed<16,6>",
    "reuse": 4,                     # Force resource sharing for internal storage
    "strip_dropout": False,

    # Build / test
    "do_build": True,              # True to run HLS synth/export (needs toolchain)
    "test_batch": 8,                # random test batch size
}
# =========================================================

# ---- TensorFlow / Keras & hls4ml ----
try:
    import tensorflow as tf
    from tensorflow import keras
except Exception as e:
    print("[FATAL] TensorFlow/Keras not available:", e)
    sys.exit(1)

try:
    import hls4ml
except Exception as e:
    print("[FATAL] hls4ml not available:", e)
    sys.exit(1)


def load_keras_model(path, strip_dropout=True):
    # Load original model
    model = keras.models.load_model(path, compile=False)

    # Convert Sequential to Functional manually for hls4ml compatibility
    # Build layer by layer to ensure proper architecture
    input_shape = model.input_shape[1:]
    inputs = keras.Input(shape=input_shape, name='input_1')

    x = inputs
    layer_count = 0

    for layer in model.layers:
        if strip_dropout and layer.__class__.__name__ == "Dropout":
            continue

        # Get layer configuration and weights
        config = layer.get_config()
        weights = layer.get_weights()

        # Remove problematic configs
        config.pop('input_shape', None)
        config.pop('batch_input_shape', None)

        # Create new layer with unique name
        if 'name' in config:
            config['name'] = f"{config['name']}_{layer_count}"

        # Recreate layer
        layer_class = type(layer)
        new_layer = layer_class(**config)

        # Apply layer to build the model
        x = new_layer(x)

        # Set weights after building
        if weights:
            new_layer.set_weights(weights)

        layer_count += 1

    # Create functional model
    return keras.Model(inputs=inputs, outputs=x, name="converted_model")


def make_hls_config(model, default_precision="ap_fixed<16,6>", reuse=1):
    # Create config manually instead of using config_from_keras_model to avoid parsing issues
    cfg = {
        'Model': {
            'Precision': default_precision,
            'ReuseFactor': int(reuse),
            'Strategy': 'Resource',     # Force internal storage
            'BramFactor': 4,           # Increase internal BRAM usage
            'PipelineStyle': 'dataflow',
            'ClockPeriod': 5,
            'IOType': 'io_stream'
        },
        'LayerName': {},
        'LayerType': {}
    }

    # Configure layers manually
    for layer in model.layers:
        name = getattr(layer, 'name', None)
        cls = layer.__class__.__name__
        if name:
            if cls in ("Conv2D", "Dense"):
                cfg['LayerName'][name] = {
                    'Precision': {
                        'result': default_precision,
                        'weight': default_precision,
                        'bias': default_precision
                    },
                    'ReuseFactor': int(reuse)
                }
            elif cls == "Activation":
                cfg['LayerName'][name] = {
                    'Precision': default_precision
                }

    # Force all weights/biases to internal ROM/BRAM storage
    for layer in model.layers:
        name = getattr(layer, 'name', None)
        cls = layer.__class__.__name__
        if name and cls in ("Conv2D", "Dense"):
            if name not in cfg['LayerName']:
                cfg['LayerName'][name] = {}
            cfg['LayerName'][name].update({
                'ram_style': 'block',       # Use BRAM
                'rom_style': 'block',       # Use BRAM for ROM
                'weight_rom': True,         # Weights as internal ROM
                'bias_rom': True            # Biases as internal ROM
            })

    return cfg


def print_model_summary(model):
    print("\n=== Keras Model Summary ===")
    model.summary()
    print("\n=== Layer Details (Conv2D/Dense) ===")
    for layer in model.layers:
        if layer.__class__.__name__ == "Conv2D":
            c = layer.get_config()
            print(f"[Conv2D] name={layer.name} filters={c.get('filters')} "
                  f"kernel={c.get('kernel_size')} stride={c.get('strides')} "
                  f"padding={c.get('padding')} activation={c.get('activation')} "
                  f"data_format={c.get('data_format')}")
        elif layer.__class__.__name__ == "Dense":
            c = layer.get_config()
            print(f"[Dense ] name={layer.name} units={c.get('units')} activation={c.get('activation')}")


def quick_numeric_check(hls_model, keras_model, batch=8, npy_sample=None):
    # Expected input: (batch, 4, 256, 1)
    x = np.random.randn(batch, 4, 256, 1).astype(np.float32)
    yk = keras_model.predict(x, verbose=0)
    yh = hls_model.predict(x)
    diff = np.abs(yk - yh).flatten()
    print("\n>>> Quick random-input check:")
    print("Keras preds (first 5):", [float(v) for v in yk[:5].flatten()])
    print("HLS   preds (first 5):", [float(v) for v in yh[:5].flatten()])
    print(f"Mean abs diff: {diff.mean():.6g} | Max abs diff: {diff.max():.6g}")

    if npy_sample and Path(npy_sample).exists():
        arr = np.load(npy_sample, allow_pickle=True)
        if arr.ndim == 2:  # (4,256)
            arr = arr[..., None]
        if arr.shape != (4,256,1):
            print(f"[WARN] {npy_sample} shape={arr.shape}, expected (4,256,1). Skip sample check.")
            return
        xs = arr[None, ...].astype(np.float32)
        yk2 = keras_model.predict(xs, verbose=0)
        yh2 = hls_model.predict(xs)
        print("\n>>> Single .npy sample check:")
        print("Keras:", float(yk2.squeeze()), " | HLS:", float(yh2.squeeze()))


def main(C):
    print(f"[Info] TF version: {tf.__version__}")
    print(f"[Info] hls4ml version: {getattr(hls4ml, '__version__', 'unknown')}")
    print("[Info] Using config:", json.dumps(C, indent=2))

    # Load model (already converted to Functional in load_keras_model)
    model = load_keras_model(C["model"], strip_dropout=C["strip_dropout"])

    print_model_summary(model)

    # Build HLS config
    hls_cfg = make_hls_config(model, default_precision=C["precision"], reuse=C["reuse"])
    print("\n=== HLS Config (compact) ===")
    print(json.dumps({
        'Model': hls_cfg['Model'],
        'LayerName': {k: v for k, v in hls_cfg['LayerName'].items()
                      if any(x in v for x in ['Precision', 'ReuseFactor'])}
    }, indent=2))

    # Convert
    print("\n[Step] Converting Keras model → HLS project ...")
    hls_model = hls4ml.converters.convert_from_keras_model(
        model,
        hls_config=hls_cfg,
        output_dir=C["outdir"],
        part=C["part"],
        io_type=C["io"],
        backend=C["backend"]
    )
    print("[OK] Conversion done. Project at:", C["outdir"])

    # Compile C-sim and check numerics
    print("\n[Step] Compiling HLS C-simulation model ...")
    hls_model.compile()
    print("[OK] C-sim compile done.")
    quick_numeric_check(hls_model, model, batch=C["test_batch"], npy_sample=C["sample"])

    # Optional build (synth/export)
    if C["do_build"]:
        print("\n[Step] Building (csim/synth/export) ... requires HLS tools in PATH")
        hls_model.build(csim=True, synth=True, export=True)
        print("[OK] Build finished. See reports in:", C["outdir"])


if __name__ == "__main__":
    main(CONFIG)
