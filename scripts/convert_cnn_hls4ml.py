#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Minimal-but-complete Keras→hls4ml converter for your 2D-CNN (4×256×1 input).
Tested with: TensorFlow/Keras 2.11–2.13 + hls4ml 0.8.x.

Usage examples:
  python convert_cnn_hls4ml.py
  python convert_cnn_hls4ml.py --model 09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5 --part xc7z020clg400-1
  python convert_cnn_hls4ml.py --io io_parallel --precision ap_fixed<12,4> --reuse 4
  python convert_cnn_hls4ml.py --build        # (requires Vivado/Vitis HLS in PATH)

Notes:
- Dropout is stripped by default (has no effect in inference). Use --keep-dropout to keep it.
- The script compares Keras vs HLS predictions on random inputs and (if provided) a .npy sample.
"""

import argparse
import json
import os
import sys
from pathlib import Path

import numpy as np

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


def parse_args():
    p = argparse.ArgumentParser(description="Keras CNN → hls4ml converter")
    p.add_argument("--model", default="09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5",
                   help="Path to Keras .h5 model file")
    p.add_argument("--outdir", default="hls_cnn_conv2d",
                   help="Output directory for HLS project")
    p.add_argument("--part", default="xc7z020clg400-1",
                   help="FPGA part (Vivado/Vitis), e.g., xc7z020clg400-1; CHANGE to your device")
    p.add_argument("--backend", default="Vivado", choices=["Vivado", "Vitis"],
                   help="HLS backend")
    p.add_argument("--io", default="io_stream", choices=["io_stream", "io_parallel"],
                   help="HLS I/O style")
    p.add_argument("--precision", default="ap_fixed<16,6>",
                   help="Default fixed-point precision for activations/results (e.g., ap_fixed<16,6>)")
    p.add_argument("--reuse", type=int, default=1,
                   help="Global ReuseFactor (increase to reduce resources; 1 = low latency)")
    p.add_argument("--keep-dropout", action="store_true",
                   help="Keep Dropout layer(s). By default they are stripped.")
    p.add_argument("--build", action="store_true",
                   help="Run hls_model.build(csim=True, synth=True, export=True) (requires HLS tools)")
    p.add_argument("--sample", default="Event2016_Stn14_1454540191.0_Chi0.66_SNR5.57.npy",
                   help="Optional .npy sample to test shape and predictions")
    p.add_argument("--batch", type=int, default=8,
                   help="Batch size for quick numerical test")
    return p.parse_args()


def load_keras_model(path, keep_dropout=False):
    model = keras.models.load_model(path, compile=False)

    if keep_dropout:
        return model

    # Strip Dropout layers (no effect in inference)
    from tensorflow.keras import Sequential
    new_layers = []
    for lyr in model.layers:
        if lyr.__class__.__name__ == "Dropout":
            continue
        new_layers.append(lyr)
    nm = Sequential(new_layers, name=(model.name or "model") + "_nodrop")
    nm.build(model.input_shape)
    # Copy weights for kept layers (best-effort)
    kept = [l for l in model.layers if l.__class__.__name__ != "Dropout"]
    for l_old, l_new in zip(kept, nm.layers):
        try:
            l_new.set_weights(l_old.get_weights())
        except Exception:
            pass
    return nm


def make_hls_config(model, default_precision="ap_fixed<16,6>", reuse=1):
    cfg = hls4ml.utils.config_from_keras_model(model, granularity='name')
    cfg['Model']['Precision'] = default_precision
    cfg['Model']['ReuseFactor'] = int(reuse)
    cfg['Model']['Strategy'] = 'Latency'

    # Per-layer override for common layers
    for layer in model.layers:
        name = getattr(layer, 'name', None)
        cls = layer.__class__.__name__
        if name is None:
            continue
        if cls in ("Conv2D", "Dense"):
            cfg['LayerName'].setdefault(name, {})
            cfg['LayerName'][name]['Precision'] = {
                'result': default_precision,
                'weight': default_precision,
                'bias':   default_precision
            }
    return cfg


def print_model_summary(model):
    print("\n=== Keras Model Summary ===")
    model.summary()
    # Also print key params for Conv/Dense
    print("\n=== Layer Details (Conv2D/Dense) ===")
    for layer in model.layers:
        if layer.__class__.__name__ == "Conv2D":
            cfg = layer.get_config()
            print(f"[Conv2D] name={layer.name} filters={cfg.get('filters')} "
                  f"kernel={cfg.get('kernel_size')} stride={cfg.get('strides')} "
                  f"padding={cfg.get('padding')} activation={cfg.get('activation')} "
                  f"data_format={cfg.get('data_format')}")
        elif layer.__class__.__name__ == "Dense":
            cfg = layer.get_config()
            print(f"[Dense ] name={layer.name} units={cfg.get('units')} activation={cfg.get('activation')}")


def quick_numeric_check(hls_model, keras_model, batch=8, npy_sample=None):
    """Compare Keras vs HLS predictions on random data (and optional .npy sample)."""
    # Your model expects (batch, 4, 256, 1)
    shape = (batch, 4, 256, 1)
    x = np.random.randn(*shape).astype(np.float32)
    yk = keras_model.predict(x, verbose=0)
    yh = hls_model.predict(x)
    diff = np.abs(yk - yh).flatten()
    print("\n>>> Quick random-input check:")
    print("Keras preds (first 5):", [float(v) for v in yk[:5].flatten()])
    print("HLS   preds (first 5):", [float(v) for v in yh[:5].flatten()])
    print(f"Mean abs diff: {diff.mean():.6g} | Max abs diff: {diff.max():.6g}")

    # Optional single-event .npy (shape should be (4,256) or (4,256,1))
    if npy_sample and Path(npy_sample).exists():
        arr = np.load(npy_sample, allow_pickle=True)
        if arr.ndim == 2:
            arr = arr[..., None]          # (4,256,1)
        if arr.shape != (4,256,1):
            print(f"[WARN] Sample {npy_sample} has shape {arr.shape}, expected (4,256,1). Skipping sample check.")
            return
        xs = arr[None, ...].astype(np.float32)  # batch=1
        yk2 = keras_model.predict(xs, verbose=0)
        yh2 = hls_model.predict(xs)
        print("\n>>> Single .npy sample check:")
        print("Keras:", float(yk2.squeeze()), " | HLS:", float(yh2.squeeze()))


def main():
    args = parse_args()
    print(f"[Info] TF version: {tf.__version__}")
    print(f"[Info] hls4ml version: {getattr(hls4ml, '__version__', 'unknown')}")

    # Load model
    model = load_keras_model(args.model, keep_dropout=args.keep_dropout)
    print_model_summary(model)

    # Build HLS config
    hls_cfg = make_hls_config(model, default_precision=args.precision, reuse=args.reuse)
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
        output_dir=args.outdir,
        part=args.part,
        io_type=args.io,
        backend=args.backend
    )
    print("[OK] Conversion done. Project at:", args.outdir)

    # Compile C-sim model and compare numerics
    print("\n[Step] Compiling HLS C-simulation model ...")
    hls_model.compile()
    print("[OK] C-sim compile done.")
    quick_numeric_check(hls_model, model, batch=args.batch, npy_sample=args.sample)

    # Optional: run HLS synthesis/export (needs Vivado/Vitis in PATH)
    if args.build:
        print("\n[Step] Building (csim/synth/export) ... this needs HLS tools ready in PATH")
        hls_model.build(csim=True, synth=True, export=True)
        print("[OK] Build finished. See reports in:", args.outdir)


if __name__ == "__main__":
    main()
