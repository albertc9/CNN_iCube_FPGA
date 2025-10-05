# Vivado simulation script for CNN FPGA verification
# Runs behavioral simulation with comprehensive analysis

# Set project variables
set project_name "CNN_iCube_FPGA"
set project_dir [file normalize .]

# Open project
puts "Opening Vivado project: $project_name"
puts "Project path: $project_dir/$project_name/$project_name.xpr"
open_project $project_dir/$project_name/$project_name.xpr

# Set simulation properties
set_property -name {xsim.simulate.runtime} -value {-all} -objects [get_filesets sim_1]
set_property -name {xsim.simulate.wdb} -value {} -objects [get_filesets sim_1]
set_property -name {xsim.simulate.saif} -value {simulation.saif} -objects [get_filesets sim_1]

# Add testbench if not already present
if {[llength [get_files -of_objects [get_filesets sim_1] tb_myproject.sv]] == 0} {
    add_files -fileset sim_1 $project_dir/$project_name/$project_name.srcs/sim_1/new/tb_myproject.sv
    update_compile_order -fileset sim_1
}

# Set top module for simulation
set_property top tb_myproject [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]

puts "Starting elaboration..."
launch_simulation -mode behavioral

# Run simulation
puts "Running simulation - this may take several minutes..."
restart
run -all

# Generate SAIF file for power analysis
puts "Generating switching activity file for power analysis..."
open_saif simulation.saif
log_saif [get_objects -r /*]
run 1000us
flush_saif
close_saif

puts "Simulation complete. Results saved to:"
puts "  - simulation_results.log"
puts "  - performance_results.log"
puts "  - error_analysis.log"
puts "  - simulation.saif (for power analysis)"

# Save simulation results
file copy -force [get_property DIRECTORY [current_project]]/CNN_iCube_FPGA.sim/sim_1/behav/xsim/simulation_results.log ./
file copy -force [get_property DIRECTORY [current_project]]/CNN_iCube_FPGA.sim/sim_1/behav/xsim/performance_results.log ./
file copy -force [get_property DIRECTORY [current_project]]/CNN_iCube_FPGA.sim/sim_1/behav/xsim/error_analysis.log ./
file copy -force [get_property DIRECTORY [current_project]]/CNN_iCube_FPGA.sim/sim_1/behav/xsim/simulation.saif ./

puts "Simulation files copied to project root directory"

# Optional: Run timing analysis if synthesized design exists
if {[file exists $project_dir/$project_name/$project_name.runs/synth_1/myproject.dcp]} {
    puts "Running timing analysis on synthesized design..."

    open_run synth_1

    # Apply timing constraints
    read_xdc $project_dir/$project_name/$project_name.srcs/constrs_1/new/timing_constraints.xdc

    # Generate timing reports
    report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose -max_paths 10 -file timing_analysis.rpt
    report_clock_utilization -file clock_utilization.rpt

    puts "Timing analysis complete - check timing_analysis.rpt"
}

puts "=== Vivado Simulation Script Complete ==="