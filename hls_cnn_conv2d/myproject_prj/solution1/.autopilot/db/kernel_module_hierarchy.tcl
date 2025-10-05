set ModuleHierarchy {[{
"Name" : "myproject","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_16_6_5_3_0_20u_config2_U0","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputHeight_ReadInputWidth","ID" : "2","Type" : "no",
		"SubInsts" : [
		{"Name" : "call_ln57_compute_output_buffer_2d_array_array_ap_fixed_16_6_5_3_0_20u_config2_s_fu_62","ID" : "3","Type" : "sequential",
				"SubInsts" : [
				{"Name" : "call_ln286_shift_line_buffer_array_ap_fixed_16_6_5_3_0_1u_config2_s_fu_74","ID" : "4","Type" : "pipeline"},]},]},]},
	{"Name" : "relu_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_20u_relu_config3_U0","ID" : "5","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "6","Type" : "pipeline"},]},
	{"Name" : "conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_16_6_5_3_0_10u_config4_U0","ID" : "7","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputWidth","ID" : "8","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_conv_2d_cl_array_array_ap_fixed_10u_config4_Pipeline_KernelShiftWidth_fu_745","ID" : "9","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "KernelShiftWidth","ID" : "10","Type" : "pipeline"},]},],
		"SubLoops" : [
		{"Name" : "ReuseLoop","ID" : "11","Type" : "pipeline"},]},]},
	{"Name" : "relu_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_10u_relu_config5_U0","ID" : "12","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "13","Type" : "pipeline"},]},
	{"Name" : "dense_array_ap_fixed_10u_array_ap_fixed_16_6_5_3_0_1u_config7_U0","ID" : "14","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_dense_array_array_ap_fixed_16_6_5_3_0_1u_config7_Pipeline_DataPrepare_fu_59","ID" : "15","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "DataPrepare","ID" : "16","Type" : "pipeline"},]},],
		"SubLoops" : [
		{"Name" : "ReuseLoop","ID" : "17","Type" : "pipeline"},]},
	{"Name" : "sigmoid_array_array_ap_fixed_16_6_5_3_0_1u_sigmoid_config8_U0","ID" : "18","Type" : "sequential"},]
}]}