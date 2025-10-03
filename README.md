# CNN Converter for IceCube
=========================
Albert Cheung, UC Irvine.
albert.cheung@cern.ch


## Overview

This repository contains:

* A trained **2D CNN model** for classifying RCR vs Backlobe events from waveform traces (`.h5` format).
* Example waveform data (`.npy`) with shape `(4, 256)` used for inference testing.
* A Python script to **convert the Keras model into an FPGA-deployable HLS project** using [hls4ml](https://fastmachinelearning.org/hls4ml/).

The repository is intended for researchers and engineers working on machine learning inference on FPGAs, especially in the context of signal classification.

---

## Repository Structure

```
CNN_iCube_FPGA/
│
├── models/
│   └── 09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5
│
├── data/
│   └── Event2016_Stn14_1454540191.0_Chi0.66_SNR5.57.npy
│
├── scripts/
│   └── convert_cnn_hls4ml.py
│
├── notebooks/
│   └── CNNConversionToFPGA.ipynb
│
├── README.md
└── requirements.txt
```

---

## Usage

1. **Install environment**
   listed in `requirements.txt`. It is recommended to use a virtual environment.

   ```bash
   python -m venv venv && pip install -r requirements.txt
   ```

   or directly install to your environment:

    ```bash
    pip install -r requirements.txt
    ```

2. **Run conversion script**

   ```bash
   cd scripts
   python convert_cnn_hls4ml.py \
       --model ../models/09.24.25_14-33_all_amps_1D_CNN_model_2Layer.h5 \
       --part <your_fpga_part> \
       --backend Vivado \
       --io io_stream
   ```

3. **Check results**
   The script compares Keras vs HLS predictions on random input and (optionally) the example `.npy` waveform.
   HLS project files are generated in `hls_cnn_conv2d/`.

4. **Optional FPGA synthesis/export**
   Add `--build` if Vivado/Vitis HLS is installed and accessible in `$PATH`.

---

## Notes

* Dropout layers are stripped during conversion (no effect at inference).
* Default fixed-point precision is `ap_fixed<16,6>`; adjust in the script for resource/latency trade-offs.
* Update `--part` to match your FPGA device.
