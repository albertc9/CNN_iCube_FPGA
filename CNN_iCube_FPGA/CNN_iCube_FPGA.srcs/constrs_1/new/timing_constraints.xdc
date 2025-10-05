# Timing constraints for CNN FPGA implementation
# Target: 200MHz operation for real-time seismic processing

# Primary clock constraint - 200MHz (5ns period)
create_clock -period 5.000 -name ap_clk -waveform {0.000 2.500} [get_ports ap_clk]

# Clock uncertainty (jitter + skew)
set_clock_uncertainty -setup 0.200 [get_clocks ap_clk]
set_clock_uncertainty -hold 0.100 [get_clocks ap_clk]

# Input delay constraints
# AXI-Stream input interface
set_input_delay -clock ap_clk -min 0.500 [get_ports {input_1_TDATA[*] input_1_TVALID}]
set_input_delay -clock ap_clk -max 1.500 [get_ports {input_1_TDATA[*] input_1_TVALID}]

# AXI-Lite control interface
set_input_delay -clock ap_clk -min 0.500 [get_ports {s_axi_CTRL_AWADDR[*] s_axi_CTRL_AWVALID s_axi_CTRL_WDATA[*] s_axi_CTRL_WSTRB[*] s_axi_CTRL_WVALID s_axi_CTRL_BREADY s_axi_CTRL_ARADDR[*] s_axi_CTRL_ARVALID s_axi_CTRL_RREADY}]
set_input_delay -clock ap_clk -max 1.500 [get_ports {s_axi_CTRL_AWADDR[*] s_axi_CTRL_AWVALID s_axi_CTRL_WDATA[*] s_axi_CTRL_WSTRB[*] s_axi_CTRL_WVALID s_axi_CTRL_BREADY s_axi_CTRL_ARADDR[*] s_axi_CTRL_ARVALID s_axi_CTRL_RREADY}]

# Output delay constraints
# AXI-Stream output interface
set_output_delay -clock ap_clk -min 0.500 [get_ports {layer8_out_TDATA[*] layer8_out_TVALID layer8_out_TLAST}]
set_output_delay -clock ap_clk -max 1.500 [get_ports {layer8_out_TDATA[*] layer8_out_TVALID layer8_out_TLAST}]

# AXI-Lite control interface outputs
set_output_delay -clock ap_clk -min 0.500 [get_ports {s_axi_CTRL_AWREADY s_axi_CTRL_WREADY s_axi_CTRL_BRESP[*] s_axi_CTRL_BVALID s_axi_CTRL_ARREADY s_axi_CTRL_RDATA[*] s_axi_CTRL_RRESP[*] s_axi_CTRL_RVALID interrupt}]
set_output_delay -clock ap_clk -max 1.500 [get_ports {s_axi_CTRL_AWREADY s_axi_CTRL_WREADY s_axi_CTRL_BRESP[*] s_axi_CTRL_BVALID s_axi_CTRL_ARREADY s_axi_CTRL_RDATA[*] s_axi_CTRL_RRESP[*] s_axi_CTRL_RVALID interrupt}]

# Input transition and load
set_driving_cell -lib_cell BUFG [get_ports ap_clk]
set_driving_cell -lib_cell IBUF [get_ports {input_1_TDATA[*] input_1_TVALID s_axi_CTRL_* ap_rst_n}]

# Output load
set_load 5.0 [get_ports {layer8_out_* s_axi_CTRL_* interrupt}]

# False paths for reset
set_false_path -from [get_ports ap_rst_n]

# Max delay for combinational paths (if any)
set_max_delay -from [get_ports input_1_TDATA[*]] -to [get_ports layer8_out_TDATA[*]] 25.0

# BRAM timing optimization
set_property RAM_STYLE BLOCK [get_cells -hierarchical -filter {NAME =~ "*bram*"}]

# DSP optimization (if DSPs are used)
set_property USE_DSP48 yes [get_cells -hierarchical -filter {NAME =~ "*mult*"}]

# Power optimization
set_property POWER_OPT.PAR_EFFORT high [current_design]

# Report timing constraints
# Use these commands in Vivado TCL console after implementation:
# report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file timing_summary.rpt
# report_clock_utilization -file clock_utilization.rpt