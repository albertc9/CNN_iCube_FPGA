# Timing analysis script for CNN FPGA implementation
# Analyzes timing performance and constraint compliance

puts "=== Starting Timing Analysis ==="

# Open synthesized design
if {[file exists [get_property DIRECTORY [current_project]]/CNN_iCube_FPGA.runs/synth_1/myproject.dcp]} {
    puts "Opening synthesized design..."
    open_run synth_1
} else {
    puts "ERROR: Synthesized design not found"
    return -code error "Please run synthesis first"
}

# Apply timing constraints
puts "Reading timing constraints..."
read_xdc [get_property DIRECTORY [current_project]]/CNN_iCube_FPGA.srcs/constrs_1/new/timing_constraints.xdc

# Check timing constraints
puts "Checking timing constraints..."
check_timing -verbose -file timing_check.rpt

# Report all clocks
puts "Analyzing clock configuration..."
report_clocks -file clock_analysis.rpt

# Comprehensive timing summary
puts "Generating timing summary..."
report_timing_summary \
    -delay_type max \
    -report_unconstrained \
    -check_timing_verbose \
    -max_paths 20 \
    -input_pins \
    -routable_nets \
    -file timing_analysis.rpt

# Detailed timing for critical paths
puts "Analyzing critical paths..."
report_timing \
    -max_paths 10 \
    -nworst 2 \
    -delay_type max \
    -sort_by slack \
    -input_pins \
    -routable_nets \
    -file critical_paths.rpt

# Setup and hold timing
report_timing \
    -delay_type min \
    -max_paths 10 \
    -file hold_timing.rpt

# Clock domain crossing analysis
puts "Checking clock domain crossings..."
report_cdc -file clock_domain_crossing.rpt

# Clock interaction report
report_clock_interaction -delay_type max -file clock_interaction.rpt

# Datapath delay analysis
puts "Analyzing datapath delays..."
report_datasheet -file datasheet_timing.rpt

# High fanout nets (can cause timing issues)
report_high_fanout_nets -fanout_greater_than 1000 -max_nets 50 -file high_fanout_nets.rpt

# Clock skew analysis
report_clock_networks -file clock_networks.rpt

# Generate timing histogram
if {[get_timing_paths -max_paths 1000] != {}} {
    report_timing -of_objects [get_timing_paths -max_paths 1000] -file timing_histogram.rpt
}

# Extract timing summary for user
puts "\n=== Timing Analysis Summary ==="

# Parse timing results
set timing_file [open "timing_analysis.rpt" r]
set timing_content [read $timing_file]
close $timing_file

# Extract key metrics
if {[regexp {Design Timing Summary.*?WNS\(ns\).*?(\S+)} $timing_content match wns]} {
    puts "Worst Negative Slack (WNS): ${wns} ns"
    if {$wns >= 0} {
        puts "✅ Setup timing constraints MET"
    } else {
        puts "❌ Setup timing constraints VIOLATED"
        set margin [expr -$wns]
        puts "   Required improvement: ${margin} ns"
        set freq_achievable [expr 1000.0 / (5.0 - $wns)]
        puts "   Maximum achievable frequency: ${freq_achievable} MHz"
    }
} else {
    puts "Could not extract WNS from timing report"
}

if {[regexp {Design Timing Summary.*?TNS\(ns\).*?(\S+)} $timing_content match tns]} {
    puts "Total Negative Slack (TNS): ${tns} ns"
}

if {[regexp {Design Timing Summary.*?WHS\(ns\).*?(\S+)} $timing_content match whs]} {
    puts "Worst Hold Slack (WHS): ${whs} ns"
    if {$whs >= 0} {
        puts "✅ Hold timing constraints MET"
    } else {
        puts "❌ Hold timing constraints VIOLATED"
    }
}

# Check for unconstrained paths
if {[regexp {There are (\d+) unconstrained endpoint} $timing_content match unconstrained_count]} {
    if {$unconstrained_count > 0} {
        puts "⚠️  ${unconstrained_count} unconstrained endpoints found"
    } else {
        puts "✅ All endpoints properly constrained"
    }
}

# Clock analysis
if {[regexp {Clock Summary.*?ap_clk.*?(\d+\.\d+)} $timing_content match clock_freq]} {
    puts "Clock frequency: ${clock_freq} MHz"
}

puts "\nTiming analysis reports generated:"
puts "  - timing_analysis.rpt (comprehensive timing summary)"
puts "  - critical_paths.rpt (worst timing paths)"
puts "  - hold_timing.rpt (hold timing analysis)"
puts "  - clock_analysis.rpt (clock configuration)"
puts "  - clock_domain_crossing.rpt (CDC analysis)"
puts "  - timing_check.rpt (constraint verification)"

# Timing optimization suggestions
puts "\n=== Timing Optimization Suggestions ==="

if {[info exists wns] && $wns < 0} {
    puts "To improve setup timing:"
    puts "  1. Increase ReuseFactor in HLS (trades area for timing)"
    puts "  2. Add pipeline pragmas to critical paths"
    puts "  3. Reduce clock frequency target"
    puts "  4. Use faster speed grade FPGA"
    puts "  5. Optimize placement with floorplanning"
}

if {[info exists unconstrained_count] && $unconstrained_count > 0} {
    puts "To fix unconstrained paths:"
    puts "  1. Add missing clock constraints"
    puts "  2. Set false paths for asynchronous signals"
    puts "  3. Add input/output delay constraints"
}

puts "=== Timing Analysis Complete ==="