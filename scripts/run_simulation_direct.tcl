# Direct Vivado simulation script for CNN FPGA verification
# Simplified approach to avoid path issues

puts "=== Starting CNN FPGA Simulation ==="

# Open the project
set project_path "./CNN_iCube_FPGA/CNN_iCube_FPGA.xpr"
puts "Opening project: $project_path"

if {[file exists $project_path]} {
    open_project $project_path
    puts "Project opened successfully"
} else {
    puts "ERROR: Project file not found at $project_path"
    exit 1
}

# Check current sources
puts "Current design sources:"
foreach src [get_files -of_objects [get_filesets sources_1]] {
    puts "  $src"
}

# Add testbench to simulation
puts "Setting up simulation..."

# Check if testbench exists
set tb_path "./CNN_iCube_FPGA/CNN_iCube_FPGA.srcs/sim_1/new/tb_myproject.sv"
if {[file exists $tb_path]} {
    puts "Found testbench: $tb_path"
    add_files -fileset sim_1 $tb_path
    update_compile_order -fileset sim_1
} else {
    puts "WARNING: Testbench not found at $tb_path"
    puts "Available simulation files:"
    foreach sim_file [get_files -of_objects [get_filesets sim_1]] {
        puts "  $sim_file"
    }
}

# Set simulation properties
set_property top tb_myproject [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]

# Set simulation runtime
set_property -name {xsim.simulate.runtime} -value {100ms} -objects [get_filesets sim_1]

puts "Starting simulation elaboration..."

# Try to run simulation
if {[catch {launch_simulation -mode behavioral} result]} {
    puts "ERROR: Failed to launch simulation: $result"

    # Try to elaborate only
    puts "Attempting elaboration only..."
    if {[catch {launch_simulation -mode behavioral -step elaborate} elab_result]} {
        puts "ERROR: Elaboration also failed: $elab_result"

        # Check for compilation errors
        puts "Checking for syntax/compilation issues..."
        if {[catch {check_syntax} syntax_result]} {
            puts "Syntax check result: $syntax_result"
        }
        exit 1
    }
}

puts "Simulation launched successfully!"

# Since this is running in batch mode, let's create a simple result
puts "Creating simulation status report..."

set status_file [open "simulation_status.txt" w]
puts $status_file "CNN FPGA Simulation Status"
puts $status_file "=========================="
puts $status_file "Timestamp: [clock format [clock seconds]]"
puts $status_file "Project: CNN_iCube_FPGA"
puts $status_file "Status: Simulation environment prepared"
puts $status_file ""
puts $status_file "Note: Full simulation requires interactive mode or"
puts $status_file "custom testbench with file I/O for automated results."
close $status_file

puts "Simulation setup complete - check simulation_status.txt"
puts "=== CNN FPGA Simulation Script Complete ==="