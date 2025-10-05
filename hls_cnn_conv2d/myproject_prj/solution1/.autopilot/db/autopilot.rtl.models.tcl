set SynModuleInfo {
  {SRCNAME {shift_line_buffer<array<ap_fixed<16, 6, 5, 3, 0>, 1u>, config2>} MODELNAME shift_line_buffer_array_ap_fixed_16_6_5_3_0_1u_config2_s RTLNAME myproject_shift_line_buffer_array_ap_fixed_16_6_5_3_0_1u_config2_s
    SUBMODULES {
      {MODELNAME myproject_shift_line_buffer_array_ap_fixed_16_6_5_3_0_1u_config2_s_void_conv_2d_buffer_bkb RTLNAME myproject_shift_line_buffer_array_ap_fixed_16_6_5_3_0_1u_config2_s_void_conv_2d_buffer_bkb BINDTYPE storage TYPE shiftreg IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME compute_output_buffer_2d<array,array<ap_fixed<16,6,5,3,0>,20u>,config2> MODELNAME compute_output_buffer_2d_array_array_ap_fixed_16_6_5_3_0_20u_config2_s RTLNAME myproject_compute_output_buffer_2d_array_array_ap_fixed_16_6_5_3_0_20u_config2_s}
  {SRCNAME conv_2d_cl<array<ap_fixed,1u>,array<ap_fixed<16,6,5,3,0>,20u>,config2> MODELNAME conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_16_6_5_3_0_20u_config2_s RTLNAME myproject_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_16_6_5_3_0_20u_config2_s
    SUBMODULES {
      {MODELNAME myproject_regslice_both RTLNAME myproject_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME myproject_regslice_both_U}
    }
  }
  {SRCNAME relu<array<ap_fixed,20u>,array<ap_fixed<16,6,5,3,0>,20u>,relu_config3> MODELNAME relu_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_20u_relu_config3_s RTLNAME myproject_relu_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_20u_relu_config3_s
    SUBMODULES {
      {MODELNAME myproject_flow_control_loop_pipe RTLNAME myproject_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME myproject_flow_control_loop_pipe_U}
    }
  }
  {SRCNAME conv_2d_cl<array,array<ap_fixed,10u>,config4>_Pipeline_KernelShiftWidth MODELNAME conv_2d_cl_array_array_ap_fixed_10u_config4_Pipeline_KernelShiftWidth RTLNAME myproject_conv_2d_cl_array_array_ap_fixed_10u_config4_Pipeline_KernelShiftWidth
    SUBMODULES {
      {MODELNAME myproject_sparsemux_19_4_16_1_1 RTLNAME myproject_sparsemux_19_4_16_1_1 BINDTYPE op TYPE sparsemux IMPL auto}
      {MODELNAME myproject_flow_control_loop_pipe_sequential_init RTLNAME myproject_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME myproject_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME conv_2d_cl<array<ap_fixed,20u>,array<ap_fixed<16,6,5,3,0>,10u>,config4> MODELNAME conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_10u_config4_s RTLNAME myproject_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_10u_config4_s}
  {SRCNAME relu<array<ap_fixed,10u>,array<ap_fixed<16,6,5,3,0>,10u>,relu_config5> MODELNAME relu_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_10u_relu_config5_s RTLNAME myproject_relu_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_10u_relu_config5_s}
  {SRCNAME dense<array,array<ap_fixed<16,6,5,3,0>,1u>,config7>_Pipeline_DataPrepare MODELNAME dense_array_array_ap_fixed_16_6_5_3_0_1u_config7_Pipeline_DataPrepare RTLNAME myproject_dense_array_array_ap_fixed_16_6_5_3_0_1u_config7_Pipeline_DataPrepare}
  {SRCNAME dense<array<ap_fixed,10u>,array<ap_fixed<16,6,5,3,0>,1u>,config7> MODELNAME dense_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_1u_config7_s RTLNAME myproject_dense_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_1u_config7_s}
  {SRCNAME sigmoid<array,array<ap_fixed<16,6,5,3,0>,1u>,sigmoid_config8> MODELNAME sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_s RTLNAME myproject_sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_s
    SUBMODULES {
      {MODELNAME myproject_sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_s_sigmoid_table_ROeOg RTLNAME myproject_sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_s_sigmoid_table_ROeOg BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME myproject MODELNAME myproject RTLNAME myproject IS_TOP 1
    SUBMODULES {
      {MODELNAME myproject_fifo_w320_d247_A RTLNAME myproject_fifo_w320_d247_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer2_out_U}
      {MODELNAME myproject_fifo_w320_d247_A RTLNAME myproject_fifo_w320_d247_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer3_out_U}
      {MODELNAME myproject_fifo_w160_d238_A RTLNAME myproject_fifo_w160_d238_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer4_out_U}
      {MODELNAME myproject_fifo_w160_d238_A RTLNAME myproject_fifo_w160_d238_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer5_out_U}
      {MODELNAME myproject_fifo_w16_d1_S RTLNAME myproject_fifo_w16_d1_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME layer7_out_U}
      {MODELNAME myproject_start_for_relu_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_20u_relu_config3_U0 RTLNAME myproject_start_for_relu_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_20u_relu_config3_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_relu_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_20u_relu_config3_U0_U}
      {MODELNAME myproject_start_for_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_10u_config4fYi RTLNAME myproject_start_for_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_10u_config4fYi BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_10u_config4fYi_U}
      {MODELNAME myproject_start_for_relu_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_10u_relu_config5_U0 RTLNAME myproject_start_for_relu_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_10u_relu_config5_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_relu_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_10u_relu_config5_U0_U}
      {MODELNAME myproject_start_for_dense_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_1u_config7_U0 RTLNAME myproject_start_for_dense_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_1u_config7_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_dense_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_1u_config7_U0_U}
      {MODELNAME myproject_start_for_sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_U0 RTLNAME myproject_start_for_sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_U0_U}
      {MODELNAME myproject_CTRL_s_axi RTLNAME myproject_CTRL_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
