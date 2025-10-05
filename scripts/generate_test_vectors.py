#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate comprehensive test vectors for Vivado simulation
Creates input stimuli and golden reference outputs from trained CNN model
"""

import numpy as np
import tensorflow as tf
from tensorflow import keras
import h5py
import os
import sys
from pathlib import Path

def load_and_prepare_model(model_path):
    """Load Keras model and prepare for inference"""
    print(f"Loading model from: {model_path}")
    model = keras.models.load_model(model_path, compile=False)
    print("Model loaded successfully")
    model.summary()
    return model

def generate_test_patterns(reference_data_path, num_vectors=1000):
    """Generate diverse test patterns based on reference data"""
    print(f"Loading reference data from: {reference_data_path}")

    # Load reference seismic data
    ref_data = np.load(reference_data_path)
    print(f"Reference data shape: {ref_data.shape}")

    test_vectors = []
    vector_types = []

    # 1. Original reference data
    if ref_data.ndim == 2:
        ref_data = ref_data[..., None]  # Add channel dimension
    test_vectors.append(ref_data)
    vector_types.append("reference")

    # 2. Zero input (baseline test)
    zero_input = np.zeros_like(ref_data)
    test_vectors.append(zero_input)
    vector_types.append("zeros")

    # 3. Small amplitude noise
    for i in range(20):
        noise = np.random.normal(0, 0.001, ref_data.shape).astype(np.float32)
        test_vectors.append(noise)
        vector_types.append(f"noise_small_{i}")

    # 4. Scaled versions of reference data
    scales = [0.1, 0.25, 0.5, 0.75, 1.25, 1.5, 2.0]
    for scale in scales:
        scaled = ref_data * scale
        test_vectors.append(scaled)
        vector_types.append(f"scaled_{scale}")

    # 5. Random seismic-like patterns
    for i in range(50):
        # Generate random waveforms with similar characteristics to seismic data
        random_data = np.random.normal(0, ref_data.std(), ref_data.shape).astype(np.float32)
        # Apply some smoothing to make it more seismic-like
        from scipy.ndimage import gaussian_filter1d
        for ch in range(random_data.shape[0]):
            random_data[ch, :, 0] = gaussian_filter1d(random_data[ch, :, 0], sigma=2.0)
        test_vectors.append(random_data)
        vector_types.append(f"random_seismic_{i}")

    # 6. Edge cases - saturation values
    sat_positive = np.full_like(ref_data, 0.5)  # Positive saturation
    sat_negative = np.full_like(ref_data, -0.5)  # Negative saturation
    test_vectors.append(sat_positive)
    test_vectors.append(sat_negative)
    vector_types.append("saturation_positive")
    vector_types.append("saturation_negative")

    # 7. Impulse responses
    for i in range(10):
        impulse = np.zeros_like(ref_data)
        ch = np.random.randint(0, ref_data.shape[0])
        pos = np.random.randint(10, ref_data.shape[1]-10)
        impulse[ch, pos, 0] = np.random.uniform(-0.2, 0.2)
        test_vectors.append(impulse)
        vector_types.append(f"impulse_{i}")

    # 8. Real variations of reference data (add noise, shift, etc.)
    for i in range(100):
        variation = ref_data.copy()
        # Add small amount of noise
        variation += np.random.normal(0, ref_data.std() * 0.1, ref_data.shape)
        # Random amplitude scaling
        variation *= np.random.uniform(0.8, 1.2)
        # Small time shift simulation
        shift = np.random.randint(-5, 6)
        if shift != 0:
            variation = np.roll(variation, shift, axis=1)
        test_vectors.append(variation.astype(np.float32))
        vector_types.append(f"variation_{i}")

    # Trim to requested number if we have too many
    if len(test_vectors) > num_vectors:
        indices = np.random.choice(len(test_vectors), num_vectors, replace=False)
        test_vectors = [test_vectors[i] for i in indices]
        vector_types = [vector_types[i] for i in indices]

    # Add more random vectors if we need them
    while len(test_vectors) < num_vectors:
        random_data = np.random.normal(0, ref_data.std(), ref_data.shape).astype(np.float32)
        test_vectors.append(random_data)
        vector_types.append(f"random_{len(test_vectors)}")

    print(f"Generated {len(test_vectors)} test vectors")
    return test_vectors, vector_types

def generate_golden_outputs(model, test_vectors):
    """Generate golden reference outputs using Keras model"""
    print("Generating golden reference outputs...")

    golden_outputs = []
    for i, test_input in enumerate(test_vectors):
        if i % 100 == 0:
            print(f"Processing vector {i}/{len(test_vectors)}")

        # Prepare input for Keras model
        input_batch = test_input[None, ...].astype(np.float32)  # Add batch dimension

        # Get model prediction
        prediction = model.predict(input_batch, verbose=0)
        golden_outputs.append(prediction.squeeze())

    print(f"Generated {len(golden_outputs)} golden reference outputs")
    return np.array(golden_outputs)

def save_vivado_stimulus_files(test_vectors, golden_outputs, vector_types, output_dir):
    """Save test vectors in Vivado-compatible format"""
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    print(f"Saving stimulus files to: {output_dir}")

    # Save input vectors (flatten 4x256x1 to 1024 values per vector)
    input_file = output_dir / "tb_input_features.dat"
    with open(input_file, 'w') as f:
        for i, vec in enumerate(test_vectors):
            # Flatten the input vector (4, 256, 1) -> 1024 values
            flattened = vec.flatten()
            line = ' '.join([f"{val:.8f}" for val in flattened])
            f.write(line + '\n')

    # Save golden reference outputs
    output_file = output_dir / "tb_output_predictions.dat"
    with open(output_file, 'w') as f:
        for output in golden_outputs:
            f.write(f"{output:.8f}\n")

    # Save vector metadata
    metadata_file = output_dir / "test_vector_metadata.txt"
    with open(metadata_file, 'w') as f:
        f.write("# Test Vector Metadata\n")
        f.write(f"# Total vectors: {len(test_vectors)}\n")
        f.write(f"# Input shape per vector: {test_vectors[0].shape}\n")
        f.write(f"# Output values per vector: 1\n")
        f.write("# Format: vector_index, vector_type, expected_output\n")
        for i, (vec_type, output) in enumerate(zip(vector_types, golden_outputs)):
            f.write(f"{i}, {vec_type}, {output:.8f}\n")

    # Save summary statistics
    stats_file = output_dir / "test_statistics.txt"
    with open(stats_file, 'w') as f:
        f.write("# Test Vector Statistics\n")
        f.write(f"Total test vectors: {len(test_vectors)}\n")
        f.write(f"Input data range: [{np.min(test_vectors):.6f}, {np.max(test_vectors):.6f}]\n")
        f.write(f"Input data mean: {np.mean(test_vectors):.6f}\n")
        f.write(f"Input data std: {np.std(test_vectors):.6f}\n")
        f.write(f"Output range: [{np.min(golden_outputs):.6f}, {np.max(golden_outputs):.6f}]\n")
        f.write(f"Output mean: {np.mean(golden_outputs):.6f}\n")
        f.write(f"Output std: {np.std(golden_outputs):.6f}\n")

        # Vector type distribution
        from collections import Counter
        type_counts = Counter([vt.split('_')[0] for vt in vector_types])
        f.write("\nVector type distribution:\n")
        for vtype, count in type_counts.items():
            f.write(f"  {vtype}: {count}\n")

    print(f"Saved files:")
    print(f"  - Input vectors: {input_file}")
    print(f"  - Golden outputs: {output_file}")
    print(f"  - Metadata: {metadata_file}")
    print(f"  - Statistics: {stats_file}")

def main():
    # Configuration
    CONFIG = {
        "model_path": "models/09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5",
        "reference_data": "data/Event2016_Stn14_1454540191.0_Chi0.66_SNR5.57.npy",
        "output_dir": "hls_cnn_conv2d/tb_data",
        "num_vectors": 1000
    }

    print("=== Test Vector Generation for Vivado Simulation ===")
    print(f"Configuration: {CONFIG}")

    # Load model
    model = load_and_prepare_model(CONFIG["model_path"])

    # Generate test patterns
    test_vectors, vector_types = generate_test_patterns(
        CONFIG["reference_data"],
        CONFIG["num_vectors"]
    )

    # Generate golden reference outputs
    golden_outputs = generate_golden_outputs(model, test_vectors)

    # Save stimulus files
    save_vivado_stimulus_files(test_vectors, golden_outputs, vector_types, CONFIG["output_dir"])

    print("\n=== Test Vector Generation Complete ===")
    print(f"Generated {len(test_vectors)} test vectors")
    print(f"Output range: [{np.min(golden_outputs):.6f}, {np.max(golden_outputs):.6f}]")
    print("Files ready for Vivado simulation")

if __name__ == "__main__":
    main()