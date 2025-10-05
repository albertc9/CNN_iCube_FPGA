`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Comprehensive testbench for CNN FPGA implementation
// Tests: Functional correctness, Performance, AXI protocol compliance
//////////////////////////////////////////////////////////////////////////////////

module tb_myproject();

    // Test parameters
    parameter CLK_PERIOD = 5.0;  // 200MHz target clock
    parameter NUM_TEST_VECTORS = 1000;
    parameter INPUT_WIDTH = 16;
    parameter OUTPUT_WIDTH = 16;
    parameter INPUT_SIZE = 1024; // 4*256*1 flattened

    // Clock and reset
    logic ap_clk;
    logic ap_rst_n;

    // AXI-Stream Input Interface
    logic [INPUT_WIDTH-1:0] input_1_TDATA;
    logic input_1_TVALID;
    logic input_1_TREADY;
    logic input_1_TLAST;

    // AXI-Stream Output Interface
    logic [OUTPUT_WIDTH-1:0] layer8_out_TDATA;
    logic layer8_out_TVALID;
    logic layer8_out_TREADY;
    logic layer8_out_TLAST;

    // AXI-Lite Control Interface
    logic [4:0] s_axi_CTRL_AWADDR;
    logic s_axi_CTRL_AWVALID;
    logic s_axi_CTRL_AWREADY;
    logic [31:0] s_axi_CTRL_WDATA;
    logic [3:0] s_axi_CTRL_WSTRB;
    logic s_axi_CTRL_WVALID;
    logic s_axi_CTRL_WREADY;
    logic [1:0] s_axi_CTRL_BRESP;
    logic s_axi_CTRL_BVALID;
    logic s_axi_CTRL_BREADY;
    logic [4:0] s_axi_CTRL_ARADDR;
    logic s_axi_CTRL_ARVALID;
    logic s_axi_CTRL_ARREADY;
    logic [31:0] s_axi_CTRL_RDATA;
    logic [1:0] s_axi_CTRL_RRESP;
    logic s_axi_CTRL_RVALID;
    logic s_axi_CTRL_RREADY;
    logic interrupt;

    // Test variables
    real test_inputs[NUM_TEST_VECTORS][INPUT_SIZE];
    real golden_outputs[NUM_TEST_VECTORS];
    logic [INPUT_WIDTH-1:0] input_queue[$];
    int current_vector = 0;
    int input_count = 0;
    int output_count = 0;

    // Performance monitoring
    longint start_time[NUM_TEST_VECTORS];
    longint end_time[NUM_TEST_VECTORS];
    longint total_cycles = 0;
    real throughput_fps;
    real avg_latency;

    // Accuracy tracking
    real fpga_outputs[NUM_TEST_VECTORS];
    real errors[NUM_TEST_VECTORS];
    real max_error = 0.0;
    real mean_error = 0.0;
    int vectors_processed = 0;

    // Files for results
    integer results_file;
    integer performance_file;
    integer error_file;

    // Instantiate DUT
    myproject dut (
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .input_1_TDATA(input_1_TDATA),
        .input_1_TVALID(input_1_TVALID),
        .input_1_TREADY(input_1_TREADY),
        .layer8_out_TDATA(layer8_out_TDATA),
        .layer8_out_TVALID(layer8_out_TVALID),
        .layer8_out_TREADY(layer8_out_TREADY),
        .s_axi_CTRL_AWADDR(s_axi_CTRL_AWADDR),
        .s_axi_CTRL_AWVALID(s_axi_CTRL_AWVALID),
        .s_axi_CTRL_AWREADY(s_axi_CTRL_AWREADY),
        .s_axi_CTRL_WDATA(s_axi_CTRL_WDATA),
        .s_axi_CTRL_WSTRB(s_axi_CTRL_WSTRB),
        .s_axi_CTRL_WVALID(s_axi_CTRL_WVALID),
        .s_axi_CTRL_WREADY(s_axi_CTRL_WREADY),
        .s_axi_CTRL_BRESP(s_axi_CTRL_BRESP),
        .s_axi_CTRL_BVALID(s_axi_CTRL_BVALID),
        .s_axi_CTRL_BREADY(s_axi_CTRL_BREADY),
        .s_axi_CTRL_ARADDR(s_axi_CTRL_ARADDR),
        .s_axi_CTRL_ARVALID(s_axi_CTRL_ARVALID),
        .s_axi_CTRL_ARREADY(s_axi_CTRL_ARREADY),
        .s_axi_CTRL_RDATA(s_axi_CTRL_RDATA),
        .s_axi_CTRL_RRESP(s_axi_CTRL_RRESP),
        .s_axi_CTRL_RVALID(s_axi_CTRL_RVALID),
        .s_axi_CTRL_RREADY(s_axi_CTRL_RREADY),
        .interrupt(interrupt)
    );

    // Clock generation
    initial begin
        ap_clk = 0;
        forever #(CLK_PERIOD/2) ap_clk = ~ap_clk;
    end

    // Load test vectors
    initial begin
        $display("Loading test vectors...");

        // Load input vectors
        if (!$fopen("../../../hls_cnn_conv2d/tb_data/tb_input_features.dat", "r")) begin
            $error("Cannot open input test file");
            $finish;
        end

        for (int i = 0; i < NUM_TEST_VECTORS; i++) begin
            for (int j = 0; j < INPUT_SIZE; j++) begin
                if ($fscanf("../../../hls_cnn_conv2d/tb_data/tb_input_features.dat", "%f", test_inputs[i][j]) != 1) begin
                    $error("Error reading input vector %d, element %d", i, j);
                    $finish;
                end
            end
        end

        // Load golden outputs
        if (!$fopen("../../../hls_cnn_conv2d/tb_data/tb_output_predictions.dat", "r")) begin
            $error("Cannot open golden output file");
            $finish;
        end

        for (int i = 0; i < NUM_TEST_VECTORS; i++) begin
            if ($fscanf("../../../hls_cnn_conv2d/tb_data/tb_output_predictions.dat", "%f", golden_outputs[i]) != 1) begin
                $error("Error reading golden output %d", i);
                $finish;
            end
        end

        $display("Successfully loaded %d test vectors", NUM_TEST_VECTORS);
    end

    // Function to convert real to fixed-point
    function automatic logic [INPUT_WIDTH-1:0] real_to_fixed(real value);
        automatic int fixed_val = int'(value * (1 << 10));
        return fixed_val[INPUT_WIDTH-1:0];
    endfunction

    // Function to convert fixed-point to real
    function automatic real fixed_to_real(logic [OUTPUT_WIDTH-1:0] fixed_val);
        automatic int signed_val = $signed(fixed_val);
        return real'(signed_val) / (1 << 10);
    endfunction

    // Main test sequence
    initial begin
        // Open result files
        results_file = $fopen("simulation_results.log", "w");
        performance_file = $fopen("performance_results.log", "w");
        error_file = $fopen("error_analysis.log", "w");

        $display("=== CNN FPGA Simulation Starting ===");
        $display("Target clock frequency: %0.1f MHz", 1000.0/CLK_PERIOD);
        $display("Test vectors: %d", NUM_TEST_VECTORS);

        // Initialize signals
        ap_rst_n = 0;
        input_1_TVALID = 0;
        input_1_TLAST = 0;
        layer8_out_TREADY = 1; // Always ready to receive

        // AXI-Lite initialization
        s_axi_CTRL_AWVALID = 0;
        s_axi_CTRL_WVALID = 0;
        s_axi_CTRL_BREADY = 1;
        s_axi_CTRL_ARVALID = 0;
        s_axi_CTRL_RREADY = 1;

        // Reset sequence
        repeat (10) @(posedge ap_clk);
        ap_rst_n = 1;
        repeat (5) @(posedge ap_clk);

        $display("Reset complete, starting AXI-Lite configuration...");

        // Configure design via AXI-Lite (start the design)
        axi_lite_write(5'h00, 32'h1); // Start bit

        $display("Design started, beginning test vector processing...");

        // Start input and output processing
        fork
            drive_inputs();
            monitor_outputs();
        join

        // Calculate final statistics
        calculate_statistics();

        // Print summary
        print_final_results();

        // Close files
        $fclose(results_file);
        $fclose(performance_file);
        $fclose(error_file);

        $display("=== Simulation Complete ===");
        $finish;
    end

    // AXI-Lite write task
    task axi_lite_write(input [4:0] addr, input [31:0] data);
        @(posedge ap_clk);
        s_axi_CTRL_AWADDR = addr;
        s_axi_CTRL_AWVALID = 1;
        s_axi_CTRL_WDATA = data;
        s_axi_CTRL_WSTRB = 4'hF;
        s_axi_CTRL_WVALID = 1;

        wait(s_axi_CTRL_AWREADY && s_axi_CTRL_WREADY);
        @(posedge ap_clk);
        s_axi_CTRL_AWVALID = 0;
        s_axi_CTRL_WVALID = 0;

        wait(s_axi_CTRL_BVALID);
        @(posedge ap_clk);
    endtask

    // Drive input vectors
    task drive_inputs();
        for (int vec = 0; vec < NUM_TEST_VECTORS; vec++) begin
            start_time[vec] = $time;

            if (vec % 100 == 0) begin
                $display("Processing vector %d/%d", vec, NUM_TEST_VECTORS);
            end

            // Send input vector (1024 samples)
            for (int i = 0; i < INPUT_SIZE; i++) begin
                @(posedge ap_clk);
                input_1_TDATA = real_to_fixed(test_inputs[vec][i]);
                input_1_TVALID = 1;
                input_1_TLAST = (i == INPUT_SIZE - 1);

                // Wait for ready
                while (!input_1_TREADY) @(posedge ap_clk);
            end

            @(posedge ap_clk);
            input_1_TVALID = 0;
            input_1_TLAST = 0;

            // Small gap between vectors
            repeat (5) @(posedge ap_clk);
        end

        $display("All input vectors sent");
    endtask

    // Monitor outputs
    task monitor_outputs();
        while (vectors_processed < NUM_TEST_VECTORS) begin
            @(posedge ap_clk);

            if (layer8_out_TVALID && layer8_out_TREADY) begin
                end_time[vectors_processed] = $time;

                // Convert output to real
                fpga_outputs[vectors_processed] = fixed_to_real(layer8_out_TDATA);

                // Calculate error
                errors[vectors_processed] = $abs(fpga_outputs[vectors_processed] - golden_outputs[vectors_processed]);

                // Log results
                $fwrite(results_file, "Vector %d: FPGA=%.6f, Golden=%.6f, Error=%.6f\n",
                        vectors_processed, fpga_outputs[vectors_processed],
                        golden_outputs[vectors_processed], errors[vectors_processed]);

                if (vectors_processed % 100 == 0) begin
                    $display("Output %d: FPGA=%.6f, Golden=%.6f, Error=%.6f",
                             vectors_processed, fpga_outputs[vectors_processed],
                             golden_outputs[vectors_processed], errors[vectors_processed]);
                end

                vectors_processed++;
            end
        end

        $display("All outputs received");
    endtask

    // Calculate performance and accuracy statistics
    task calculate_statistics();
        automatic real total_error = 0.0;
        automatic longint total_latency = 0;
        automatic longint total_sim_time;

        max_error = 0.0;

        for (int i = 0; i < NUM_TEST_VECTORS; i++) begin
            // Accuracy
            total_error += errors[i];
            if (errors[i] > max_error) max_error = errors[i];

            // Performance
            total_latency += (end_time[i] - start_time[i]);
        end

        mean_error = total_error / NUM_TEST_VECTORS;
        avg_latency = real'(total_latency) / NUM_TEST_VECTORS / CLK_PERIOD; // in clock cycles

        // Calculate throughput
        total_sim_time = end_time[NUM_TEST_VECTORS-1] - start_time[0];
        throughput_fps = real'(NUM_TEST_VECTORS) * 1e9 / real'(total_sim_time);

        $display("Statistics calculated");
    endtask

    // Print final results
    task print_final_results();
        $display("\n=== SIMULATION RESULTS ===");
        $display("Functional Verification:");
        $display("  Vectors processed: %d", vectors_processed);
        $display("  Mean absolute error: %.8f", mean_error);
        $display("  Maximum error: %.8f", max_error);
        $display("  Accuracy (1-max_error): %.4f%%", (1.0 - max_error) * 100.0);

        $display("\nPerformance Results:");
        $display("  Average latency: %.1f clock cycles", avg_latency);
        $display("  Average latency: %.2f μs @ %.0f MHz", avg_latency * CLK_PERIOD / 1000.0, 1000.0/CLK_PERIOD);
        $display("  Throughput: %.0f inferences/sec", throughput_fps);

        // Write performance summary
        $fwrite(performance_file, "=== PERFORMANCE SUMMARY ===\n");
        $fwrite(performance_file, "Clock frequency: %.1f MHz\n", 1000.0/CLK_PERIOD);
        $fwrite(performance_file, "Average latency: %.1f cycles (%.2f μs)\n", avg_latency, avg_latency * CLK_PERIOD / 1000.0);
        $fwrite(performance_file, "Throughput: %.0f inferences/sec\n", throughput_fps);
        $fwrite(performance_file, "Mean error: %.8f\n", mean_error);
        $fwrite(performance_file, "Max error: %.8f\n", max_error);

        // Write detailed error analysis
        $fwrite(error_file, "=== ERROR ANALYSIS ===\n");
        for (int i = 0; i < NUM_TEST_VECTORS; i++) begin
            $fwrite(error_file, "%d,%.8f,%.8f,%.8f\n", i, fpga_outputs[i], golden_outputs[i], errors[i]);
        end
    endtask

    // Timeout watchdog
    initial begin
        #(CLK_PERIOD * 1000000); // 1M cycles timeout
        $error("Simulation timeout - possible deadlock");
        $finish;
    end

    // Protocol violation checking
    property axi_stream_valid_ready;
        @(posedge ap_clk) disable iff (!ap_rst_n)
        input_1_TVALID && !input_1_TREADY |=> $stable(input_1_TDATA);
    endproperty

    assert property (axi_stream_valid_ready) else $error("AXI-Stream protocol violation: TDATA changed while TVALID high and TREADY low");

endmodule