#!/bin/bash

# Complete verification script for CNN FPGA implementation
# Runs simulation, timing analysis, and power estimation

set -e  # Exit on any error

echo "=============================================="
echo "CNN FPGA Complete Verification Script"
echo "=============================================="

# Configuration
PROJECT_DIR="$(pwd)"
VIVADO_VERSION="2023.2"
LOG_DIR="verification_logs"

# Create log directory
mkdir -p $LOG_DIR

echo "Step 1: Checking environment..."

# Check if Vivado is available
if ! command -v vivado &> /dev/null; then
    echo "ERROR: Vivado not found in PATH"
    echo "Please source Vivado settings: source /path/to/Vivado/$VIVADO_VERSION/settings64.sh"
    exit 1
fi

echo "Vivado found: $(which vivado)"

# Check if test vectors exist
if [ ! -f "hls_cnn_conv2d/tb_data/tb_input_features.dat" ]; then
    echo "ERROR: Test vectors not found. Please run generate_test_vectors.py first"
    exit 1
fi

echo "Test vectors found: $(wc -l < hls_cnn_conv2d/tb_data/tb_input_features.dat) vectors"

echo "Step 2: Running behavioral simulation..."

# Run simulation in batch mode
vivado -mode batch -source scripts/run_vivado_simulation.tcl -log $LOG_DIR/simulation.log -journal $LOG_DIR/simulation.jou

if [ $? -eq 0 ]; then
    echo "✅ Simulation completed successfully"
else
    echo "❌ Simulation failed - check $LOG_DIR/simulation.log"
    exit 1
fi

echo "Step 3: Analyzing simulation results..."

# Check if simulation results exist
if [ -f "simulation_results.log" ]; then
    echo "Simulation results found - parsing..."

    # Extract key metrics (simplified parsing)
    VECTORS_PROCESSED=$(grep -c "Vector" simulation_results.log || echo "0")
    echo "Vectors processed: $VECTORS_PROCESSED"

    if [ -f "performance_results.log" ]; then
        echo "Performance results:"
        cat performance_results.log
    fi

    if [ -f "error_analysis.log" ]; then
        MAX_ERROR=$(awk -F',' 'NR>1 {if($4>max) max=$4} END {print max}' error_analysis.log || echo "N/A")
        MEAN_ERROR=$(awk -F',' 'NR>1 {sum+=$4; count++} END {print sum/count}' error_analysis.log || echo "N/A")
        echo "Accuracy analysis:"
        echo "  Mean error: $MEAN_ERROR"
        echo "  Max error: $MAX_ERROR"
    fi
else
    echo "❌ Simulation results not found"
    exit 1
fi

echo "Step 4: Running timing analysis..."

# Run timing analysis if synthesis exists
if [ -f "CNN_iCube_FPGA/CNN_iCube_FPGA.runs/synth_1/myproject.dcp" ]; then
    echo "Synthesized design found - running timing analysis..."

    vivado -mode batch -source scripts/timing_analysis.tcl -log $LOG_DIR/timing.log -journal $LOG_DIR/timing.jou

    if [ -f "timing_analysis.rpt" ]; then
        echo "✅ Timing analysis completed"

        # Extract timing slack
        SLACK=$(grep -A5 "Worst Negative Slack" timing_analysis.rpt | grep "WNS" | awk '{print $2}' || echo "N/A")
        echo "Worst Negative Slack: $SLACK ns"

        if [[ "$SLACK" != "N/A" && $(echo "$SLACK > 0" | bc -l) -eq 1 ]]; then
            echo "✅ Timing constraints met"
        else
            echo "⚠️  Timing constraints not met - design may not run at target frequency"
        fi
    fi
else
    echo "⚠️  Synthesized design not found - skipping timing analysis"
    echo "Run synthesis first: vivado -mode batch -source CNN_iCube_FPGA/CNN_iCube_FPGA.runs/synth_1/runme.sh"
fi

echo "Step 5: Running power analysis..."

# Run power analysis if implementation exists
if [ -f "CNN_iCube_FPGA/CNN_iCube_FPGA.runs/impl_1/myproject_routed.dcp" ]; then
    echo "Implemented design found - running power analysis..."

    vivado -mode batch -source scripts/power_analysis.tcl -log $LOG_DIR/power.log -journal $LOG_DIR/power.jou

    if [ -f "detailed_power_analysis.rpt" ]; then
        echo "✅ Power analysis completed"

        # Extract power metrics
        TOTAL_POWER=$(grep "Total On-Chip Power" detailed_power_analysis.rpt | awk '{print $5}' || echo "N/A")
        DYNAMIC_POWER=$(grep "Dynamic (W)" detailed_power_analysis.rpt | awk '{print $3}' || echo "N/A")
        JUNCTION_TEMP=$(grep "Junction Temperature" detailed_power_analysis.rpt | awk '{print $4}' || echo "N/A")

        echo "Power analysis results:"
        echo "  Total power: $TOTAL_POWER W"
        echo "  Dynamic power: $DYNAMIC_POWER W"
        echo "  Junction temperature: $JUNCTION_TEMP °C"
    fi
else
    echo "⚠️  Implemented design not found - skipping power analysis"
    echo "Run implementation first: vivado CNN_iCube_FPGA/CNN_iCube_FPGA.xpr (then run implementation)"
fi

echo "Step 6: Generating comprehensive report..."

# Create comprehensive verification report
REPORT_FILE="verification_report_$(date +%Y%m%d_%H%M%S).md"

cat > $REPORT_FILE << EOF
# CNN FPGA Verification Report

**Generated:** $(date)
**Project:** CNN_iCube_FPGA
**Target:** 200MHz operation on xcku5p-ffvb676-2-e

## Executive Summary

This report summarizes the simulation-based verification of the CNN FPGA implementation for seismic signal processing.

## Test Configuration

- **Test vectors:** $VECTORS_PROCESSED vectors
- **Input format:** 4-channel waveforms (4×256×1)
- **Target frequency:** 200MHz (5ns period)
- **Precision:** ap_fixed<16,6>

## Functional Verification Results

EOF

if [ -f "performance_results.log" ]; then
    echo "### Performance Metrics" >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
    cat performance_results.log >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
fi

if [ -f "error_analysis.log" ]; then
    echo "### Accuracy Analysis" >> $REPORT_FILE
    echo "- Mean absolute error: $MEAN_ERROR" >> $REPORT_FILE
    echo "- Maximum error: $MAX_ERROR" >> $REPORT_FILE
    echo "- Accuracy: $(echo "scale=2; (1 - $MAX_ERROR) * 100" | bc -l)%" >> $REPORT_FILE
fi

cat >> $REPORT_FILE << EOF

## Timing Analysis

- Worst Negative Slack: $SLACK ns
- Status: $(if [[ "$SLACK" != "N/A" && $(echo "$SLACK > 0" | bc -l) -eq 1 ]]; then echo "PASS"; else echo "FAIL"; fi)

## Power Analysis

- Total power: $TOTAL_POWER W
- Dynamic power: $DYNAMIC_POWER W
- Junction temperature: $JUNCTION_TEMP °C

## Files Generated

- \`simulation_results.log\` - Detailed simulation results
- \`performance_results.log\` - Performance metrics
- \`error_analysis.log\` - Accuracy analysis
- \`timing_analysis.rpt\` - Timing analysis (if available)
- \`detailed_power_analysis.rpt\` - Power analysis (if available)
- \`simulation.saif\` - Switching activity for power analysis

## Verification Status

EOF

# Overall status
OVERALL_STATUS="PASS"
if [ "$VECTORS_PROCESSED" -lt 900 ]; then
    OVERALL_STATUS="FAIL"
fi

if [[ "$SLACK" != "N/A" && $(echo "$SLACK <= 0" | bc -l) -eq 1 ]]; then
    OVERALL_STATUS="CONDITIONAL"
fi

echo "**Overall Status:** $OVERALL_STATUS" >> $REPORT_FILE

echo "=============================================="
echo "Verification Complete!"
echo "=============================================="
echo "Overall Status: $OVERALL_STATUS"
echo "Report generated: $REPORT_FILE"
echo ""
echo "Key results:"
echo "  - Functional: $VECTORS_PROCESSED vectors processed"
echo "  - Accuracy: Mean error $MEAN_ERROR, Max error $MAX_ERROR"
echo "  - Timing: WNS $SLACK ns"
echo "  - Power: $TOTAL_POWER W total"
echo ""
echo "Check detailed results in:"
echo "  - $REPORT_FILE (comprehensive report)"
echo "  - $LOG_DIR/ (simulation logs)"
echo "  - *.rpt files (detailed analysis reports)"