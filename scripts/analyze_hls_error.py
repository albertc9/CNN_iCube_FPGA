#!/usr/bin/env python3
import argparse, os, json, numpy as np
from tensorflow.keras.models import load_model

def main():
    p = argparse.ArgumentParser(description="Compare Keras vs HLS (hls4ml) predictions")
    p.add_argument("--model", default="models/09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5")
    p.add_argument("--sample", default="data/Event2016_Stn14_1454540191.0_Chi0.66_SNR5.57.npy")
    p.add_argument("--precision", default="ap_fixed<16,6>", help="hls4ml default_precision, e.g. ap_fixed<16,6>")
    p.add_argument("--out", default="hls_error_report.json")
    p.add_argument("--verbose", action="store_true")
    args = p.parse_args()

    # 1) Load model + sample
    model = load_model(args.model)
    x = np.load(args.sample)

    # Reshape data to match model input: (4,256) -> (1,4,256,1)
    if x.shape == (4, 256):
        x = x[None, ..., None]  # Add batch and channel dimensions
    elif x.ndim == 1:
        x = x[None, ...]        # Add batch dim if needed

    print(f"Input shape: {x.shape}, Model expects: {model.input_shape}")
    y_keras = model.predict(x, verbose=0)

    # 2) Create HLS model using the working approach
    import hls4ml
    import sys
    import os
    sys.path.append('scripts')

    # Import the working functions from convert_cnn_hls4ml.py
    try:
        from convert_cnn_hls4ml import load_keras_model, make_hls_config
    except ImportError:
        print("Error: Could not import from convert_cnn_hls4ml.py")
        print("Make sure convert_cnn_hls4ml.py is in the scripts/ directory")
        return

    print("Converting model to HLS format...")
    functional_model = load_keras_model(args.model, strip_dropout=True)
    hls_cfg = make_hls_config(functional_model, default_precision=args.precision, reuse=1)

    print("Creating HLS model...")
    hls_model = hls4ml.converters.convert_from_keras_model(
        functional_model,
        hls_config=hls_cfg,
        output_dir="temp_hls_analysis",
        io_type='io_stream'
    )

    print("Compiling HLS model...")
    hls_model.compile()
    print("Running HLS prediction...")
    y_hls = hls_model.predict(x)

    # 3) Metrics
    def safe_softmax(a, axis=-1):
        a = a - np.max(a, axis=axis, keepdims=True)
        e = np.exp(a)
        return e / np.sum(e, axis=axis, keepdims=True)

    mae = float(np.mean(np.abs(y_keras - y_hls)))
    rmse = float(np.sqrt(np.mean((y_keras - y_hls) ** 2)))
    max_abs = float(np.max(np.abs(y_keras - y_hls)))
    # cosine similarity over flattened vectors (averaged over batch)
    def cos(a, b):
        a = a.reshape(a.shape[0], -1); b = b.reshape(b.shape[0], -1)
        num = np.sum(a*b, axis=1)
        den = np.linalg.norm(a, axis=1) * np.linalg.norm(b, axis=1)
        return float(np.mean(num / (den + 1e-12)))
    cosine = cos(y_keras, y_hls)

    # If this is a classifier, estimate label disagreements and KL
    label_flip_rate = None
    kl_div = None
    if y_keras.ndim == 2 and y_keras.shape[1] > 1:
        k_lab = np.argmax(y_keras, axis=1)
        h_lab = np.argmax(y_hls, axis=1)
        label_flip_rate = float(np.mean(k_lab != h_lab))
        pk = safe_softmax(y_keras, axis=1)
        qk = safe_softmax(y_hls, axis=1)
        kl_div = float(np.mean(np.sum(pk * (np.log(pk + 1e-12) - np.log(qk + 1e-12)), axis=1)))

    report = {
        "paths": {"model": args.model, "sample": args.sample},
        "hls_precision": args.precision,
        "metrics": {
            "mean_absolute_error": mae,
            "rmse": rmse,
            "max_absolute_error": max_abs,
            "cosine_similarity": cosine,
            "label_flip_rate": label_flip_rate,
            "avg_KL_divergence_softmax": kl_div
        },
        "shapes": {
            "x": list(x.shape),
            "y_keras": list(y_keras.shape),
            "y_hls": list(y_hls.shape)
        }
    }

    with open(args.out, "w") as f:
        json.dump(report, f, indent=2)
    print(json.dumps(report, indent=2))

    if args.verbose:
        # show a short per-sample summary
        for i in range(min(5, x.shape[0])):
            d = np.abs(y_keras[i] - y_hls[i]).flatten()
            print(f"[sample {i}] mae={d.mean():.6g}, max={d.max():.6g}, rmse={(np.sqrt((d**2).mean())):.6g}")

if __name__ == "__main__":
    main()
