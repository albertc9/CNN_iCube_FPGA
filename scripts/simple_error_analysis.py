#!/usr/bin/env python3
"""
Simple error analysis comparing Keras predictions with manual fixed-point simulation
to understand the impact of quantization without needing hls4ml conversion.
"""

import numpy as np
import json
from tensorflow.keras.models import load_model

def float_to_fixed(x, total_bits=16, int_bits=6):
    """Convert float to fixed-point simulation"""
    # Calculate scaling factor
    frac_bits = total_bits - int_bits
    scale = 2 ** frac_bits

    # Convert to fixed-point integer, then back to float
    x_fixed = np.round(x * scale).astype(np.int32)

    # Handle overflow/underflow
    max_val = (2 ** (total_bits - 1)) - 1
    min_val = -(2 ** (total_bits - 1))
    x_fixed = np.clip(x_fixed, min_val, max_val)

    # Convert back to float
    return x_fixed.astype(np.float32) / scale

def simulate_quantized_layer(x, weights, bias, activation='relu', precision=(16, 6)):
    """Simulate a layer with quantization"""
    total_bits, int_bits = precision

    # Quantize weights and bias
    w_quant = float_to_fixed(weights, total_bits, int_bits)
    b_quant = float_to_fixed(bias, total_bits, int_bits) if bias is not None else None

    # Compute layer output
    if len(weights.shape) == 4:  # Conv2D
        from tensorflow.nn import conv2d
        output = conv2d(x, w_quant, strides=[1, 1, 1, 1], padding='VALID')
        if b_quant is not None:
            output = output + b_quant
    elif len(weights.shape) == 2:  # Dense
        output = np.dot(x, w_quant)
        if b_quant is not None:
            output = output + b_quant
    else:
        raise ValueError(f"Unsupported weight shape: {weights.shape}")

    # Quantize intermediate result
    output = float_to_fixed(output, total_bits, int_bits)

    # Apply activation
    if activation == 'relu':
        output = np.maximum(0, output)
    elif activation == 'sigmoid':
        output = 1.0 / (1.0 + np.exp(-output))

    # Quantize final result
    output = float_to_fixed(output, total_bits, int_bits)

    return output

def analyze_model_sensitivity(model_path, sample_path, precisions=None):
    """Analyze model sensitivity to different quantization levels"""

    if precisions is None:
        precisions = [
            (32, 16),  # High precision baseline
            (24, 8),   # High precision
            (16, 6),   # Default hls4ml
            (12, 4),   # Medium precision
            (8, 3),    # Low precision
        ]

    # Load model and data
    model = load_model(model_path)
    sample = np.load(sample_path)

    # Reshape sample data
    if sample.shape == (4, 256):
        x = sample[None, ..., None].astype(np.float32)  # (1, 4, 256, 1)
    else:
        x = sample.astype(np.float32)

    print(f"Input shape: {x.shape}")

    # Get original Keras prediction
    y_original = model.predict(x, verbose=0)
    print(f"Original Keras prediction: {y_original[0][0]:.6f}")

    # Test with different input magnitudes
    test_inputs = [
        ("original", x),
        ("scaled_0.1", x * 0.1),
        ("scaled_10", x * 10.0),
        ("random_normal", np.random.randn(*x.shape).astype(np.float32) * 0.1),
        ("random_uniform", np.random.uniform(-1, 1, x.shape).astype(np.float32)),
    ]

    results = {}

    for test_name, test_x in test_inputs:
        print(f"\n=== Testing with {test_name} input ===")
        y_orig = model.predict(test_x, verbose=0)

        test_results = {
            "original_prediction": float(y_orig[0][0]),
            "quantization_results": {}
        }

        for total_bits, int_bits in precisions:
            # Simple quantization simulation
            x_quant = float_to_fixed(test_x, total_bits, int_bits)
            y_quant = model.predict(x_quant, verbose=0)

            mae = float(np.mean(np.abs(y_orig - y_quant)))
            max_error = float(np.max(np.abs(y_orig - y_quant)))
            relative_error = mae / (abs(float(y_orig[0][0])) + 1e-8)

            precision_key = f"ap_fixed<{total_bits},{int_bits}>"
            test_results["quantization_results"][precision_key] = {
                "quantized_prediction": float(y_quant[0][0]),
                "mean_absolute_error": mae,
                "max_absolute_error": max_error,
                "relative_error": relative_error,
                "prediction_difference": float(y_quant[0][0] - y_orig[0][0])
            }

            print(f"  {precision_key:15s}: orig={y_orig[0][0]:.6f}, quant={y_quant[0][0]:.6f}, "
                  f"diff={y_quant[0][0] - y_orig[0][0]:+.6f}, rel_err={relative_error:.4f}")

        results[test_name] = test_results

    # Generate batch statistics
    print(f"\n=== Batch Analysis (100 random samples) ===")
    batch_x = np.random.randn(100, *x.shape[1:]).astype(np.float32) * 0.1
    batch_y_orig = model.predict(batch_x, verbose=0)

    batch_results = {}
    for total_bits, int_bits in precisions:
        batch_x_quant = float_to_fixed(batch_x, total_bits, int_bits)
        batch_y_quant = model.predict(batch_x_quant, verbose=0)

        mae = float(np.mean(np.abs(batch_y_orig - batch_y_quant)))
        rmse = float(np.sqrt(np.mean((batch_y_orig - batch_y_quant) ** 2)))
        max_error = float(np.max(np.abs(batch_y_orig - batch_y_quant)))

        precision_key = f"ap_fixed<{total_bits},{int_bits}>"
        batch_results[precision_key] = {
            "mean_absolute_error": mae,
            "root_mean_square_error": rmse,
            "max_absolute_error": max_error,
            "std_dev_error": float(np.std(batch_y_orig - batch_y_quant))
        }

        print(f"  {precision_key:15s}: MAE={mae:.6f}, RMSE={rmse:.6f}, Max={max_error:.6f}")

    results["batch_statistics"] = batch_results

    # Summary assessment
    print(f"\n=== Impact Assessment ===")
    default_precision = "ap_fixed<16,6>"
    if default_precision in batch_results:
        mae = batch_results[default_precision]["mean_absolute_error"]
        if mae < 0.01:
            impact = "LOW"
        elif mae < 0.1:
            impact = "MEDIUM"
        else:
            impact = "HIGH"

        print(f"Overall quantization impact with {default_precision}: {impact}")
        print(f"Mean prediction error: {mae:.6f}")
        print(f"For reference: original predictions range from {batch_y_orig.min():.6f} to {batch_y_orig.max():.6f}")

    return results

def main():
    model_path = "models/09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5"
    sample_path = "data/Event2016_Stn14_1454540191.0_Chi0.66_SNR5.57.npy"

    print("=== CNN Quantization Impact Analysis ===")
    print(f"Model: {model_path}")
    print(f"Sample: {sample_path}")

    results = analyze_model_sensitivity(model_path, sample_path)

    # Save results
    output_file = "quantization_impact_report.json"
    with open(output_file, 'w') as f:
        json.dump(results, f, indent=2)

    print(f"\nDetailed results saved to: {output_file}")

if __name__ == "__main__":
    main()