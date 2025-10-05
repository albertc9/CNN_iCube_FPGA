# TCL Script to add HLS-generated files to Vivado project

# Remove any existing sources first
puts "Removing existing sources..."
catch {remove_files [get_files]}

# Add all Verilog RTL files (26 files total)
puts "Adding Verilog RTL files..."
add_files -fileset sources_1 [glob ../hls_cnn_conv2d/myproject_prj/solution1/syn/verilog/*.v]

# Add .dat memory initialization files
puts "Adding .dat files..."
add_files -fileset sources_1 ../hls_cnn_conv2d/myproject_prj/solution1/syn/verilog/myproject_sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_s_sigmoid_table_ROeOg.dat

# Set file type for .dat files
set_property file_type {Memory Initialization Files} [get_files *.dat]

# Update compile order
update_compile_order -fileset sources_1

# Set top module (CRITICAL: Must be exactly 'myproject')
set_property top myproject [current_fileset]

# Verify the import
set verilog_files [get_files *.v]
set dat_files [get_files *.dat]

puts "========================================="
puts "Successfully added HLS RTL and .dat files to Vivado project"
puts "Total Verilog files: [llength $verilog_files]"
puts "Total .dat files: [llength $dat_files]"
puts "Top module set to: [get_property top [current_fileset]]"
puts "========================================="

# List all expected modules that should be present
puts "Expected key modules:"
puts "- myproject (TOP)"
puts "- myproject_CTRL_s_axi"
puts "- myproject_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_16_6_5_3_0_20u_config2_s"
puts "- myproject_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_10u_config4_s"
puts "- myproject_relu_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_20u_relu_config3_s"
puts "- myproject_relu_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_10u_relu_config5_s"
puts "- myproject_dense_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_1u_config7_s"
puts "- myproject_sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_s"