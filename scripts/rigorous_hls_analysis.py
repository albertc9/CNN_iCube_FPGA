#!/usr/bin/env python3
"""
Rigorous HLS quantization analysis matching hardware behavior exactly.
Implements layer-wise quantization, saturation tracking, and comprehensive metrics.
"""

import numpy as np
import json
import hashlib
import yaml
import os
from pathlib import Path
from typing import Dict, List, Tuple, Any
from tensorflow.keras.models import load_model
import tensorflow as tf

# Set seeds for reproducibility
np.random.seed(42)
tf.random.set_seed(42)

class HardwareQuantizer:
    """Hardware-accurate fixed-point quantizer with saturation and rounding"""

    def __init__(self, total_bits: int, int_bits: int, signed: bool = True):
        self.total_bits = total_bits
        self.int_bits = int_bits
        self.frac_bits = total_bits - int_bits
        self.signed = signed

        if signed:
            self.max_val = (2 ** (total_bits - 1)) - 1
            self.min_val = -(2 ** (total_bits - 1))
        else:
            self.max_val = (2 ** total_bits) - 1
            self.min_val = 0

        self.scale = 2 ** self.frac_bits
        self.saturation_count = 0
        self.total_count = 0

    def quantize(self, x: np.ndarray) -> np.ndarray:
        """Quantize with hardware-accurate rounding and saturation tracking"""
        self.total_count += x.size

        # Scale to fixed-point
        x_scaled = x * self.scale

        # Round to nearest integer (hardware behavior)
        x_rounded = np.round(x_scaled).astype(np.int64)

        # Track saturation before clipping
        saturated = (x_rounded < self.min_val) | (x_rounded > self.max_val)
        self.saturation_count += np.sum(saturated)

        # Saturate (clip) to valid range
        x_clipped = np.clip(x_rounded, self.min_val, self.max_val)

        # Convert back to float
        return (x_clipped / self.scale).astype(np.float32)

    def get_saturation_rate(self) -> float:
        return self.saturation_count / max(1, self.total_count)

    def reset_stats(self):
        self.saturation_count = 0
        self.total_count = 0

class LayerWiseQuantizedModel:
    """Model that applies layer-wise quantization matching HLS behavior"""

    def __init__(self, keras_model, layer_configs: Dict[str, Dict]):
        self.keras_model = keras_model
        self.layer_configs = layer_configs
        self.quantizers = {}
        self.layer_outputs = {}  # For debugging
        self.saturation_stats = {}

        # Create quantizers for each layer
        for layer_name, config in layer_configs.items():
            precision = config.get('precision', 'ap_fixed<16,6>')
            total_bits, int_bits = self._parse_precision(precision)

            self.quantizers[layer_name] = {
                'weight': HardwareQuantizer(total_bits, int_bits),
                'bias': HardwareQuantizer(total_bits, int_bits),
                'activation': HardwareQuantizer(total_bits, int_bits)
            }

    def _parse_precision(self, precision_str: str) -> Tuple[int, int]:
        """Parse ap_fixed<total,int> format"""
        import re
        match = re.match(r'ap_fixed<(\d+),(\d+)>', precision_str)
        if match:
            return int(match.group(1)), int(match.group(2))
        else:
            # Default fallback
            return 16, 6

    def _quantize_layer_weights(self, layer, layer_name: str):
        """Quantize layer weights and biases"""
        if layer_name not in self.quantizers:
            return  # Skip if no config

        weights = layer.get_weights()
        if not weights:
            return

        # Quantize weights
        if len(weights) > 0:
            quantized_weights = self.quantizers[layer_name]['weight'].quantize(weights[0])
            weights[0] = quantized_weights

        # Quantize bias if present
        if len(weights) > 1:
            quantized_bias = self.quantizers[layer_name]['bias'].quantize(weights[1])
            weights[1] = quantized_bias

        layer.set_weights(weights)

    def predict_with_quantization(self, x: np.ndarray,
                                  weights_only: bool = False,
                                  activations_only: bool = False) -> Tuple[np.ndarray, Dict]:
        """Run inference with layer-wise quantization"""

        # Reset saturation stats
        for layer_name in self.quantizers:
            for q_type in self.quantizers[layer_name]:
                self.quantizers[layer_name][q_type].reset_stats()

        # Create a copy of the model to avoid modifying original
        import tensorflow.keras.models as models
        temp_model = models.clone_model(self.keras_model)
        temp_model.set_weights(self.keras_model.get_weights())

        # Quantize weights if requested
        if not activations_only:
            for i, layer in enumerate(temp_model.layers):
                layer_name = layer.name
                self._quantize_layer_weights(layer, layer_name)

        # Run inference with activation quantization
        if not weights_only:
            # Create intermediate model for layer-by-layer processing
            current_input = x

            for i, layer in enumerate(temp_model.layers):
                layer_name = layer.name

                # Create partial model up to this layer
                if i == 0:
                    partial_output = layer(current_input)
                else:
                    partial_output = layer(current_input)

                # Store unquantized output for debugging
                self.layer_outputs[f"{layer_name}_float"] = partial_output.numpy() if hasattr(partial_output, 'numpy') else partial_output

                # Quantize activation output
                if layer_name in self.quantizers and not (layer.__class__.__name__ in ['InputLayer', 'Dropout']):
                    if hasattr(partial_output, 'numpy'):
                        quantized_output = self.quantizers[layer_name]['activation'].quantize(partial_output.numpy())
                        partial_output = tf.constant(quantized_output)
                    else:
                        quantized_output = self.quantizers[layer_name]['activation'].quantize(partial_output)
                        partial_output = quantized_output

                    # Store quantized output
                    self.layer_outputs[f"{layer_name}_quantized"] = quantized_output

                current_input = partial_output

            final_output = current_input
        else:
            # Just run with quantized weights
            final_output = temp_model.predict(x, verbose=0)

        # Collect saturation statistics
        saturation_stats = {}
        for layer_name in self.quantizers:
            saturation_stats[layer_name] = {
                'weight_saturation': self.quantizers[layer_name]['weight'].get_saturation_rate(),
                'bias_saturation': self.quantizers[layer_name]['bias'].get_saturation_rate(),
                'activation_saturation': self.quantizers[layer_name]['activation'].get_saturation_rate()
            }

        return final_output, saturation_stats

def load_hls_config(config_path: str) -> Dict:
    """Load HLS configuration from YAML file"""
    if os.path.exists(config_path):
        try:
            with open(config_path, 'r') as f:
                content = f.read()

            # Extract only the configuration parts we need, skip model objects
            config_lines = []
            skip_mode = False

            for line in content.split('\n'):
                # Skip lines with TensorFlow/Keras objects
                if any(keyword in line for keyword in ['python/object', 'tf_keras', 'keras', 'bytecode']):
                    skip_mode = True
                    continue

                # Reset skip mode on new top-level keys
                if line and not line.startswith(' ') and not line.startswith('\t'):
                    skip_mode = False

                if not skip_mode:
                    config_lines.append(line)

            # Try to parse the cleaned content
            cleaned_content = '\n'.join(config_lines)
            try:
                return yaml.safe_load(cleaned_content)
            except:
                # If still fails, extract key info manually
                return extract_config_manually(content)

        except Exception as e:
            print(f"Warning: Could not parse HLS config file: {e}")
            return create_default_config()
    else:
        return create_default_config()

def extract_config_manually(content: str) -> Dict:
    """Extract configuration manually from YAML content"""
    config = create_default_config()

    lines = content.split('\n')
    current_section = None

    for line in lines:
        line = line.strip()
        if line.startswith('Model:'):
            current_section = 'Model'
        elif line.startswith('LayerName:'):
            current_section = 'LayerName'
        elif line.startswith('Precision:') and current_section == 'Model':
            # Extract precision value
            if ':' in line:
                precision = line.split(':', 1)[1].strip().strip('"\'')
                config['Model']['Precision'] = precision
        elif line.startswith('ReuseFactor:') and current_section == 'Model':
            # Extract reuse factor
            if ':' in line:
                try:
                    reuse = int(line.split(':', 1)[1].strip())
                    config['Model']['ReuseFactor'] = reuse
                except:
                    pass

    return config

def create_default_config() -> Dict:
    """Create default HLS configuration"""
    return {
        'Model': {'Precision': 'ap_fixed<16,6>', 'ReuseFactor': 1},
        'LayerName': {}
    }

def compute_comprehensive_metrics(y_true: np.ndarray, y_pred: np.ndarray) -> Dict[str, float]:
    """Compute comprehensive error metrics"""

    # Convert TensorFlow tensors to numpy if needed
    if hasattr(y_true, 'numpy'):
        y_true = y_true.numpy()
    if hasattr(y_pred, 'numpy'):
        y_pred = y_pred.numpy()

    # Ensure both are numpy arrays
    y_true = np.array(y_true)
    y_pred = np.array(y_pred)

    # Basic error metrics
    mae = float(np.mean(np.abs(y_true - y_pred)))
    rmse = float(np.sqrt(np.mean((y_true - y_pred) ** 2)))
    max_abs = float(np.max(np.abs(y_true - y_pred)))

    # Cosine similarity
    y_true_flat = y_true.flatten()
    y_pred_flat = y_pred.flatten()

    dot_product = np.dot(y_true_flat, y_pred_flat)
    norm_true = np.linalg.norm(y_true_flat)
    norm_pred = np.linalg.norm(y_pred_flat)
    cosine_sim = float(dot_product / (norm_true * norm_pred + 1e-12))

    metrics = {
        'mean_absolute_error': mae,
        'root_mean_square_error': rmse,
        'max_absolute_error': max_abs,
        'cosine_similarity': cosine_sim
    }

    # Classification metrics if applicable
    if y_true.ndim == 2 and y_true.shape[1] > 1:
        # Multi-class classification
        true_labels = np.argmax(y_true, axis=1)
        pred_labels = np.argmax(y_pred, axis=1)
        label_flip_rate = float(np.mean(true_labels != pred_labels))

        # KL divergence with softmax
        def safe_softmax(x):
            x_shifted = x - np.max(x, axis=1, keepdims=True)
            exp_x = np.exp(x_shifted)
            return exp_x / np.sum(exp_x, axis=1, keepdims=True)

        p_true = safe_softmax(y_true)
        p_pred = safe_softmax(y_pred)
        kl_div = float(np.mean(np.sum(p_true * (np.log(p_true + 1e-12) - np.log(p_pred + 1e-12)), axis=1)))

        metrics.update({
            'label_flip_rate': label_flip_rate,
            'kl_divergence_softmax': kl_div
        })

    return metrics

def run_precision_sweep(model, sample_data: np.ndarray, precisions: List[Tuple[int, int]]) -> Dict:
    """Run precision sweep analysis"""

    # Get baseline predictions
    y_baseline = model.predict(sample_data, verbose=0)

    results = {}

    for total_bits, int_bits in precisions:
        precision_str = f"ap_fixed<{total_bits},{int_bits}>"

        # Create layer config for this precision
        layer_configs = {}
        for layer in model.layers:
            if layer.__class__.__name__ in ['Conv2D', 'Dense']:
                layer_configs[layer.name] = {'precision': precision_str}

        # Create quantized model
        quant_model = LayerWiseQuantizedModel(model, layer_configs)

        # Test different quantization strategies
        strategies = {
            'weights_only': {'weights_only': True, 'activations_only': False},
            'activations_only': {'weights_only': False, 'activations_only': True},
            'full_quantization': {'weights_only': False, 'activations_only': False}
        }

        precision_results = {}

        for strategy_name, kwargs in strategies.items():
            y_quant, sat_stats = quant_model.predict_with_quantization(sample_data, **kwargs)

            metrics = compute_comprehensive_metrics(y_baseline, y_quant)
            metrics['saturation_stats'] = sat_stats

            precision_results[strategy_name] = metrics

        results[precision_str] = precision_results

    return results

def generate_model_checksum(model_path: str) -> str:
    """Generate checksum for model file"""
    hasher = hashlib.sha256()
    with open(model_path, 'rb') as f:
        hasher.update(f.read())
    return hasher.hexdigest()[:16]

def main():
    """Main analysis function"""

    # Configuration
    model_path = "models/09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5"
    sample_path = "data/Event2016_Stn14_1454540191.0_Chi0.66_SNR5.57.npy"
    hls_config_path = "hls_cnn_conv2d/hls4ml_config.yml"
    output_path = "rigorous_hls_analysis_report.json"

    print("=== Rigorous HLS Quantization Analysis ===")
    print(f"Model: {model_path}")
    print(f"Sample: {sample_path}")

    # Load model and data
    model = load_model(model_path)
    sample = np.load(sample_path)

    # Reshape sample data
    if sample.shape == (4, 256):
        x = sample[None, ..., None].astype(np.float32)  # (1, 4, 256, 1)
    else:
        x = sample.astype(np.float32)

    # Load HLS configuration
    hls_config = load_hls_config(hls_config_path)

    print(f"Input shape: {x.shape}")
    print(f"Model checksum: {generate_model_checksum(model_path)}")

    # Create comprehensive test dataset
    print("\n=== Creating test dataset ===")
    test_samples = [
        ("original_sample", x),
        ("random_normal_100", np.random.randn(100, *x.shape[1:]).astype(np.float32) * 0.1),
        ("random_uniform_100", np.random.uniform(-1, 1, (100, *x.shape[1:])).astype(np.float32)),
        ("scaled_samples", np.concatenate([x * scale for scale in [0.1, 0.5, 1.0, 2.0, 10.0]], axis=0))
    ]

    # Precision sweep configurations
    precisions = [
        (32, 16), (24, 8), (20, 8), (16, 6), (12, 4), (10, 3), (8, 3)
    ]

    # Main analysis results
    analysis_results = {
        'metadata': {
            'model_path': model_path,
            'model_checksum': generate_model_checksum(model_path),
            'sample_path': sample_path,
            'tensorflow_version': tf.__version__,
            'numpy_version': np.__version__,
            'random_seed': 42,
            'hls_config': hls_config
        },
        'precision_sweep': {},
        'per_dataset_analysis': {},
        'layer_analysis': {}
    }

    # Run precision sweep on each dataset
    for dataset_name, dataset in test_samples:
        print(f"\n=== Analyzing {dataset_name} ===")

        sweep_results = run_precision_sweep(model, dataset, precisions)
        analysis_results['precision_sweep'][dataset_name] = sweep_results

        # Detailed analysis for original sample
        if dataset_name == "original_sample":
            print("=== Per-layer error analysis ===")

            # Extract layer-specific configurations from HLS config
            layer_configs = {}
            default_precision = hls_config.get('Model', {}).get('Precision', 'ap_fixed<16,6>')

            for layer in model.layers:
                if layer.__class__.__name__ in ['Conv2D', 'Dense']:
                    layer_name = layer.name
                    layer_specific = hls_config.get('LayerName', {}).get(layer_name, {})
                    precision = layer_specific.get('Precision', {}).get('result', default_precision)
                    layer_configs[layer_name] = {'precision': precision}

            # Create quantized model with HLS-specific config
            quant_model = LayerWiseQuantizedModel(model, layer_configs)
            y_float = model.predict(dataset, verbose=0)
            y_quant, sat_stats = quant_model.predict_with_quantization(dataset)

            # Store layer outputs for analysis
            layer_analysis = {
                'float_vs_quantized_outputs': {},
                'saturation_analysis': sat_stats,
                'layer_configs': layer_configs
            }

            # Per-layer error analysis
            for layer_name in quant_model.layer_outputs:
                if '_float' in layer_name:
                    base_name = layer_name.replace('_float', '')
                    quant_name = f"{base_name}_quantized"

                    if quant_name in quant_model.layer_outputs:
                        float_out = quant_model.layer_outputs[layer_name]
                        quant_out = quant_model.layer_outputs[quant_name]

                        layer_metrics = compute_comprehensive_metrics(float_out, quant_out)
                        layer_analysis['float_vs_quantized_outputs'][base_name] = layer_metrics

                        print(f"  {base_name}: MAE={layer_metrics['mean_absolute_error']:.6f}, "
                              f"Max={layer_metrics['max_absolute_error']:.6f}")

            analysis_results['layer_analysis'] = layer_analysis

    # Save comprehensive report
    print(f"\n=== Saving results to {output_path} ===")
    with open(output_path, 'w') as f:
        json.dump(analysis_results, f, indent=2, default=str)

    # Print summary
    print("\n=== SUMMARY ===")
    original_results = analysis_results['precision_sweep']['original_sample']

    if 'ap_fixed<16,6>' in original_results:
        metrics_16_6 = original_results['ap_fixed<16,6>']['full_quantization']
        print(f"ap_fixed<16,6> full quantization:")
        print(f"  MAE: {metrics_16_6['mean_absolute_error']:.6f}")
        print(f"  RMSE: {metrics_16_6['root_mean_square_error']:.6f}")
        print(f"  Max Error: {metrics_16_6['max_absolute_error']:.6f}")
        print(f"  Cosine Similarity: {metrics_16_6['cosine_similarity']:.6f}")

        # Check for high saturation rates
        for layer_name, sat_info in metrics_16_6['saturation_stats'].items():
            for sat_type, rate in sat_info.items():
                if rate > 0.01:  # > 1% saturation
                    print(f"  WARNING: High saturation in {layer_name}.{sat_type}: {rate:.3%}")

    print(f"\nDetailed analysis saved to: {output_path}")

if __name__ == "__main__":
    main()