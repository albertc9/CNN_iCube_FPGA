; ModuleID = '/home/work1/Work/CNN_iCube_FPGA/hls_cnn_conv2d/myproject_prj/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>" = type { %"struct.nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>" }
%"struct.nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>" = type { [1 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"] }
%"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>" = type { %"struct.ap_fixed_base<16, 6, true, AP_TRN, AP_WRAP, 0>" }
%"struct.ap_fixed_base<16, 6, true, AP_TRN, AP_WRAP, 0>" = type { %"struct.ssdm_int<16, true>" }
%"struct.ssdm_int<16, true>" = type { i16 }

; Function Attrs: inaccessiblememonly nounwind willreturn
declare void @llvm.sideeffect() #0

; Function Attrs: noinline
define void @apatb_myproject_ir(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias nocapture nonnull dereferenceable(2) %input_1, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias nocapture nonnull dereferenceable(2) %layer8_out, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="800" %w2, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="20" %b2, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="2000" %w4, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="10" %b4, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="2380" %w7) local_unnamed_addr #1 {
entry:
  %input_1_copy = alloca %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>", align 512
  call void @llvm.sideeffect() #10 [ "stream_interface"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %input_1_copy, i32 0) ]
  %layer8_out_copy = alloca %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>", align 512
  call void @llvm.sideeffect() #10 [ "stream_interface"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %layer8_out_copy, i32 0) ]
  %w2_copy = alloca [800 x i16], align 512
  %b2_copy_0 = alloca i16, align 512
  %b2_copy_1 = alloca i16, align 512
  %b2_copy_2 = alloca i16, align 512
  %b2_copy_3 = alloca i16, align 512
  %b2_copy_4 = alloca i16, align 512
  %b2_copy_5 = alloca i16, align 512
  %b2_copy_6 = alloca i16, align 512
  %b2_copy_7 = alloca i16, align 512
  %b2_copy_8 = alloca i16, align 512
  %b2_copy_9 = alloca i16, align 512
  %b2_copy_10 = alloca i16, align 512
  %b2_copy_11 = alloca i16, align 512
  %b2_copy_12 = alloca i16, align 512
  %b2_copy_13 = alloca i16, align 512
  %b2_copy_14 = alloca i16, align 512
  %b2_copy_15 = alloca i16, align 512
  %b2_copy_16 = alloca i16, align 512
  %b2_copy_17 = alloca i16, align 512
  %b2_copy_18 = alloca i16, align 512
  %b2_copy_19 = alloca i16, align 512
  %w4_copy = alloca [2000 x i16], align 512
  %b4_copy_0 = alloca i16, align 512
  %b4_copy_1 = alloca i16, align 512
  %b4_copy_2 = alloca i16, align 512
  %b4_copy_3 = alloca i16, align 512
  %b4_copy_4 = alloca i16, align 512
  %b4_copy_5 = alloca i16, align 512
  %b4_copy_6 = alloca i16, align 512
  %b4_copy_7 = alloca i16, align 512
  %b4_copy_8 = alloca i16, align 512
  %b4_copy_9 = alloca i16, align 512
  %malloccall = call i8* @malloc(i64 4760)
  %w7_copy = bitcast i8* %malloccall to [2380 x i16]*
  %0 = bitcast %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %w2 to [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]*
  %1 = bitcast %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %b2 to [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]*
  %2 = bitcast %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %w4 to [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]*
  %3 = bitcast %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %b4 to [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]*
  %4 = bitcast %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %w7 to [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]*
  call void @copy_in(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* nonnull %input_1, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* nonnull align 512 %input_1_copy, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* nonnull %layer8_out, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* nonnull align 512 %layer8_out_copy, [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %0, [800 x i16]* nonnull align 512 %w2_copy, [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %1, i16* nonnull align 512 %b2_copy_0, i16* nonnull align 512 %b2_copy_1, i16* nonnull align 512 %b2_copy_2, i16* nonnull align 512 %b2_copy_3, i16* nonnull align 512 %b2_copy_4, i16* nonnull align 512 %b2_copy_5, i16* nonnull align 512 %b2_copy_6, i16* nonnull align 512 %b2_copy_7, i16* nonnull align 512 %b2_copy_8, i16* nonnull align 512 %b2_copy_9, i16* nonnull align 512 %b2_copy_10, i16* nonnull align 512 %b2_copy_11, i16* nonnull align 512 %b2_copy_12, i16* nonnull align 512 %b2_copy_13, i16* nonnull align 512 %b2_copy_14, i16* nonnull align 512 %b2_copy_15, i16* nonnull align 512 %b2_copy_16, i16* nonnull align 512 %b2_copy_17, i16* nonnull align 512 %b2_copy_18, i16* nonnull align 512 %b2_copy_19, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %2, [2000 x i16]* nonnull align 512 %w4_copy, [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %3, i16* nonnull align 512 %b4_copy_0, i16* nonnull align 512 %b4_copy_1, i16* nonnull align 512 %b4_copy_2, i16* nonnull align 512 %b4_copy_3, i16* nonnull align 512 %b4_copy_4, i16* nonnull align 512 %b4_copy_5, i16* nonnull align 512 %b4_copy_6, i16* nonnull align 512 %b4_copy_7, i16* nonnull align 512 %b4_copy_8, i16* nonnull align 512 %b4_copy_9, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %4, [2380 x i16]* %w7_copy)
  call void @apatb_myproject_hw(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %input_1_copy, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %layer8_out_copy, [800 x i16]* %w2_copy, i16* %b2_copy_0, i16* %b2_copy_1, i16* %b2_copy_2, i16* %b2_copy_3, i16* %b2_copy_4, i16* %b2_copy_5, i16* %b2_copy_6, i16* %b2_copy_7, i16* %b2_copy_8, i16* %b2_copy_9, i16* %b2_copy_10, i16* %b2_copy_11, i16* %b2_copy_12, i16* %b2_copy_13, i16* %b2_copy_14, i16* %b2_copy_15, i16* %b2_copy_16, i16* %b2_copy_17, i16* %b2_copy_18, i16* %b2_copy_19, [2000 x i16]* %w4_copy, i16* %b4_copy_0, i16* %b4_copy_1, i16* %b4_copy_2, i16* %b4_copy_3, i16* %b4_copy_4, i16* %b4_copy_5, i16* %b4_copy_6, i16* %b4_copy_7, i16* %b4_copy_8, i16* %b4_copy_9, [2380 x i16]* %w7_copy)
  call void @copy_back(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %input_1, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %input_1_copy, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %layer8_out, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %layer8_out_copy, [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %0, [800 x i16]* %w2_copy, [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %1, i16* %b2_copy_0, i16* %b2_copy_1, i16* %b2_copy_2, i16* %b2_copy_3, i16* %b2_copy_4, i16* %b2_copy_5, i16* %b2_copy_6, i16* %b2_copy_7, i16* %b2_copy_8, i16* %b2_copy_9, i16* %b2_copy_10, i16* %b2_copy_11, i16* %b2_copy_12, i16* %b2_copy_13, i16* %b2_copy_14, i16* %b2_copy_15, i16* %b2_copy_16, i16* %b2_copy_17, i16* %b2_copy_18, i16* %b2_copy_19, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %2, [2000 x i16]* %w4_copy, [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %3, i16* %b4_copy_0, i16* %b4_copy_1, i16* %b4_copy_2, i16* %b4_copy_3, i16* %b4_copy_4, i16* %b4_copy_5, i16* %b4_copy_6, i16* %b4_copy_7, i16* %b4_copy_8, i16* %b4_copy_9, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %4, [2380 x i16]* %w7_copy)
  call void @free(i8* %malloccall)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"onebyonecpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias align 512 %dst, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %dst, null
  %1 = icmp eq %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call fastcc void @"streamcpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* nonnull align 512 %dst, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* nonnull %src)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"streamcpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias nocapture align 512, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_2(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %2 to i8*
  %6 = bitcast %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %1 to i8*
  call void @fpga_fifo_pop_2(i8* %5, i8* %6)
  %7 = load volatile %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %2
  %8 = bitcast %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %2 to i8*
  %9 = bitcast %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %0 to i8*
  call void @fpga_fifo_push_2(i8* %8, i8* %9)
  br label %empty, !llvm.loop !45

ret:                                              ; preds = %empty
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a800struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([800 x i16]* noalias nocapture align 512 "unpacked"="0.0" %dst, [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #4 {
entry:
  %0 = icmp eq [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a800struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([800 x i16]* %dst, [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %src, i64 800)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a800struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([800 x i16]* nocapture "unpacked"="0.0" %dst, [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [800 x i16], [800 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i16, i16* %src.addr.0.0.05, align 2
  store i16 %1, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2000struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([2000 x i16]* noalias nocapture align 512 "unpacked"="0.0" %dst, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #4 {
entry:
  %0 = icmp eq [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2000struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([2000 x i16]* %dst, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %src, i64 2000)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2000struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([2000 x i16]* nocapture "unpacked"="0.0" %dst, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [2000 x i16], [2000 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i16, i16* %src.addr.0.0.05, align 2
  store i16 %1, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2380struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([2380 x i16]* noalias nocapture "unpacked"="0.0" %dst, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #4 {
entry:
  %0 = icmp eq [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2380struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([2380 x i16]* %dst, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %src, i64 2380)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2380struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([2380 x i16]* nocapture "unpacked"="0.0" %dst, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [2380 x i16], [2380 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i16, i16* %src.addr.0.0.05, align 2
  store i16 %1, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2380struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.83"([2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "unpacked"="0" %dst, [2380 x i16]* noalias nocapture readonly "unpacked"="1.0" %src) unnamed_addr #4 {
entry:
  %0 = icmp eq [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2380struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.86"([2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %dst, [2380 x i16]* %src, i64 2380)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2380struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.86"([2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* "unpacked"="0" %dst, [2380 x i16]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2380 x i16], [2380 x i16]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i16, i16* %src.addr.0.0.05, align 2
  store i16 %1, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2000struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.106"([2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "unpacked"="0" %dst, [2000 x i16]* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #4 {
entry:
  %0 = icmp eq [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2000struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.109"([2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %dst, [2000 x i16]* %src, i64 2000)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2000struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.109"([2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* "unpacked"="0" %dst, [2000 x i16]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2000 x i16], [2000 x i16]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i16, i16* %src.addr.0.0.05, align 2
  store i16 %1, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a800struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.133"([800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "unpacked"="0" %dst, [800 x i16]* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #4 {
entry:
  %0 = icmp eq [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a800struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.136"([800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %dst, [800 x i16]* %src, i64 800)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a800struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.136"([800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* "unpacked"="0" %dst, [800 x i16]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [800 x i16], [800 x i16]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i16, i16* %src.addr.0.0.05, align 2
  store i16 %1, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #6

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a20struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.122"(i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.0" %dst_0, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.1" %dst_1, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.2" %dst_2, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.3" %dst_3, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.4" %dst_4, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.5" %dst_5, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.6" %dst_6, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.7" %dst_7, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.8" %dst_8, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.9" %dst_9, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.10" %dst_10, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.11" %dst_11, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.12" %dst_12, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.13" %dst_13, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.14" %dst_14, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.15" %dst_15, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.16" %dst_16, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.17" %dst_17, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.18" %dst_18, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.19" %dst_19, [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* readonly "orig.arg.no"="1" "unpacked"="1" %src, i64 "orig.arg.no"="2" "unpacked"="2" %num) #5 {
entry:
  %0 = icmp eq [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %dst.addr.0.0.06.exit, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %dst.addr.0.0.06.exit ]
  %1 = trunc i64 %for.loop.idx2 to i5
  %src.addr.0.0.05 = getelementptr [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %2 = load i16, i16* %src.addr.0.0.05, align 2
  switch i5 %1, label %dst.addr.0.0.06.case.19 [
    i5 0, label %dst.addr.0.0.06.case.0
    i5 1, label %dst.addr.0.0.06.case.1
    i5 2, label %dst.addr.0.0.06.case.2
    i5 3, label %dst.addr.0.0.06.case.3
    i5 4, label %dst.addr.0.0.06.case.4
    i5 5, label %dst.addr.0.0.06.case.5
    i5 6, label %dst.addr.0.0.06.case.6
    i5 7, label %dst.addr.0.0.06.case.7
    i5 8, label %dst.addr.0.0.06.case.8
    i5 9, label %dst.addr.0.0.06.case.9
    i5 10, label %dst.addr.0.0.06.case.10
    i5 11, label %dst.addr.0.0.06.case.11
    i5 12, label %dst.addr.0.0.06.case.12
    i5 13, label %dst.addr.0.0.06.case.13
    i5 14, label %dst.addr.0.0.06.case.14
    i5 15, label %dst.addr.0.0.06.case.15
    i5 -16, label %dst.addr.0.0.06.case.16
    i5 -15, label %dst.addr.0.0.06.case.17
    i5 -14, label %dst.addr.0.0.06.case.18
  ]

dst.addr.0.0.06.case.0:                           ; preds = %for.loop
  store i16 %2, i16* %dst_0, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.1:                           ; preds = %for.loop
  store i16 %2, i16* %dst_1, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.2:                           ; preds = %for.loop
  store i16 %2, i16* %dst_2, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.3:                           ; preds = %for.loop
  store i16 %2, i16* %dst_3, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.4:                           ; preds = %for.loop
  store i16 %2, i16* %dst_4, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.5:                           ; preds = %for.loop
  store i16 %2, i16* %dst_5, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.6:                           ; preds = %for.loop
  store i16 %2, i16* %dst_6, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.7:                           ; preds = %for.loop
  store i16 %2, i16* %dst_7, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.8:                           ; preds = %for.loop
  store i16 %2, i16* %dst_8, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.9:                           ; preds = %for.loop
  store i16 %2, i16* %dst_9, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.10:                          ; preds = %for.loop
  store i16 %2, i16* %dst_10, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.11:                          ; preds = %for.loop
  store i16 %2, i16* %dst_11, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.12:                          ; preds = %for.loop
  store i16 %2, i16* %dst_12, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.13:                          ; preds = %for.loop
  store i16 %2, i16* %dst_13, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.14:                          ; preds = %for.loop
  store i16 %2, i16* %dst_14, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.15:                          ; preds = %for.loop
  store i16 %2, i16* %dst_15, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.16:                          ; preds = %for.loop
  store i16 %2, i16* %dst_16, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.17:                          ; preds = %for.loop
  store i16 %2, i16* %dst_17, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.18:                          ; preds = %for.loop
  store i16 %2, i16* %dst_18, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.19:                          ; preds = %for.loop
  %3 = icmp eq i5 %1, -13
  call void @llvm.assume(i1 %3)
  store i16 %2, i16* %dst_19, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.exit:                             ; preds = %dst.addr.0.0.06.case.19, %dst.addr.0.0.06.case.18, %dst.addr.0.0.06.case.17, %dst.addr.0.0.06.case.16, %dst.addr.0.0.06.case.15, %dst.addr.0.0.06.case.14, %dst.addr.0.0.06.case.13, %dst.addr.0.0.06.case.12, %dst.addr.0.0.06.case.11, %dst.addr.0.0.06.case.10, %dst.addr.0.0.06.case.9, %dst.addr.0.0.06.case.8, %dst.addr.0.0.06.case.7, %dst.addr.0.0.06.case.6, %dst.addr.0.0.06.case.5, %dst.addr.0.0.06.case.4, %dst.addr.0.0.06.case.3, %dst.addr.0.0.06.case.2, %dst.addr.0.0.06.case.1, %dst.addr.0.0.06.case.0
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.0.0.06.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @"onebyonecpy_hls.p0a20struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.119"(i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.0" %dst_0, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.1" %dst_1, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.2" %dst_2, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.3" %dst_3, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.4" %dst_4, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.5" %dst_5, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.6" %dst_6, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.7" %dst_7, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.8" %dst_8, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.9" %dst_9, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.10" %dst_10, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.11" %dst_11, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.12" %dst_12, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.13" %dst_13, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.14" %dst_14, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.15" %dst_15, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.16" %dst_16, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.17" %dst_17, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.18" %dst_18, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.19" %dst_19, [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "orig.arg.no"="1" "unpacked"="1" %src) #4 {
entry:
  %0 = icmp eq [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a20struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.122"(i16* %dst_0, i16* %dst_1, i16* %dst_2, i16* %dst_3, i16* %dst_4, i16* %dst_5, i16* %dst_6, i16* %dst_7, i16* %dst_8, i16* %dst_9, i16* %dst_10, i16* %dst_11, i16* %dst_12, i16* %dst_13, i16* %dst_14, i16* %dst_15, i16* %dst_16, i16* %dst_17, i16* %dst_18, i16* %dst_19, [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %src, i64 20)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a10struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.96"(i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.0" %dst_0, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.1" %dst_1, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.2" %dst_2, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.3" %dst_3, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.4" %dst_4, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.5" %dst_5, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.6" %dst_6, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.7" %dst_7, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.8" %dst_8, i16* nocapture "orig.arg.no"="0" "unpacked"="0.0.9" %dst_9, [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* readonly "orig.arg.no"="1" "unpacked"="1" %src, i64 "orig.arg.no"="2" "unpacked"="2" %num) #5 {
entry:
  %0 = icmp eq [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %dst.addr.0.0.06.exit, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %dst.addr.0.0.06.exit ]
  %1 = trunc i64 %for.loop.idx2 to i4
  %src.addr.0.0.05 = getelementptr [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %2 = load i16, i16* %src.addr.0.0.05, align 2
  switch i4 %1, label %dst.addr.0.0.06.case.9 [
    i4 0, label %dst.addr.0.0.06.case.0
    i4 1, label %dst.addr.0.0.06.case.1
    i4 2, label %dst.addr.0.0.06.case.2
    i4 3, label %dst.addr.0.0.06.case.3
    i4 4, label %dst.addr.0.0.06.case.4
    i4 5, label %dst.addr.0.0.06.case.5
    i4 6, label %dst.addr.0.0.06.case.6
    i4 7, label %dst.addr.0.0.06.case.7
    i4 -8, label %dst.addr.0.0.06.case.8
  ]

dst.addr.0.0.06.case.0:                           ; preds = %for.loop
  store i16 %2, i16* %dst_0, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.1:                           ; preds = %for.loop
  store i16 %2, i16* %dst_1, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.2:                           ; preds = %for.loop
  store i16 %2, i16* %dst_2, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.3:                           ; preds = %for.loop
  store i16 %2, i16* %dst_3, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.4:                           ; preds = %for.loop
  store i16 %2, i16* %dst_4, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.5:                           ; preds = %for.loop
  store i16 %2, i16* %dst_5, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.6:                           ; preds = %for.loop
  store i16 %2, i16* %dst_6, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.7:                           ; preds = %for.loop
  store i16 %2, i16* %dst_7, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.8:                           ; preds = %for.loop
  store i16 %2, i16* %dst_8, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.case.9:                           ; preds = %for.loop
  %3 = icmp eq i4 %1, -7
  call void @llvm.assume(i1 %3)
  store i16 %2, i16* %dst_9, align 2
  br label %dst.addr.0.0.06.exit

dst.addr.0.0.06.exit:                             ; preds = %dst.addr.0.0.06.case.9, %dst.addr.0.0.06.case.8, %dst.addr.0.0.06.case.7, %dst.addr.0.0.06.case.6, %dst.addr.0.0.06.case.5, %dst.addr.0.0.06.case.4, %dst.addr.0.0.06.case.3, %dst.addr.0.0.06.case.2, %dst.addr.0.0.06.case.1, %dst.addr.0.0.06.case.0
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.0.0.06.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @"onebyonecpy_hls.p0a10struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.93"(i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.0" %dst_0, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.1" %dst_1, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.2" %dst_2, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.3" %dst_3, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.4" %dst_4, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.5" %dst_5, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.6" %dst_6, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.7" %dst_7, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.8" %dst_8, i16* noalias nocapture align 512 "orig.arg.no"="0" "unpacked"="0.0.9" %dst_9, [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "orig.arg.no"="1" "unpacked"="1" %src) #4 {
entry:
  %0 = icmp eq [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a10struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.96"(i16* %dst_0, i16* %dst_1, i16* %dst_2, i16* %dst_3, i16* %dst_4, i16* %dst_5, i16* %dst_6, i16* %dst_7, i16* %dst_8, i16* %dst_9, [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %src, i64 10)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal void @copy_in(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias "orig.arg.no"="0" "unpacked"="0", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias align 512 "orig.arg.no"="1" "unpacked"="1", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias "orig.arg.no"="2" "unpacked"="2", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias align 512 "orig.arg.no"="3" "unpacked"="3", [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "orig.arg.no"="4" "unpacked"="4", [800 x i16]* noalias nocapture align 512 "orig.arg.no"="5" "unpacked"="5.0", [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "orig.arg.no"="6" "unpacked"="6", i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.0" %_0, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.1" %_1, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.2" %_2, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.3" %_3, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.4" %_4, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.5" %_5, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.6" %_6, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.7" %_7, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.8" %_8, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.9" %_9, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.10" %_10, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.11" %_11, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.12" %_12, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.13" %_13, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.14" %_14, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.15" %_15, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.16" %_16, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.17" %_17, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.18" %_18, i16* noalias nocapture align 512 "orig.arg.no"="7" "unpacked"="7.0.19" %_19, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "orig.arg.no"="8" "unpacked"="8", [2000 x i16]* noalias nocapture align 512 "orig.arg.no"="9" "unpacked"="9.0", [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "orig.arg.no"="10" "unpacked"="10", i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.0" %_01, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.1" %_110, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.2" %_211, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.3" %_312, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.4" %_413, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.5" %_514, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.6" %_615, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.7" %_716, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.8" %_817, i16* noalias nocapture align 512 "orig.arg.no"="11" "unpacked"="11.0.9" %_918, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias readonly "orig.arg.no"="12" "unpacked"="12", [2380 x i16]* noalias nocapture "orig.arg.no"="13" "unpacked"="13.0") #7 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* align 512 %1, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %0)
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* align 512 %3, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %2)
  call fastcc void @"onebyonecpy_hls.p0a800struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([800 x i16]* align 512 %5, [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %4)
  call void @"onebyonecpy_hls.p0a20struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.119"(i16* align 512 %_0, i16* align 512 %_1, i16* align 512 %_2, i16* align 512 %_3, i16* align 512 %_4, i16* align 512 %_5, i16* align 512 %_6, i16* align 512 %_7, i16* align 512 %_8, i16* align 512 %_9, i16* align 512 %_10, i16* align 512 %_11, i16* align 512 %_12, i16* align 512 %_13, i16* align 512 %_14, i16* align 512 %_15, i16* align 512 %_16, i16* align 512 %_17, i16* align 512 %_18, i16* align 512 %_19, [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %6)
  call fastcc void @"onebyonecpy_hls.p0a2000struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([2000 x i16]* align 512 %8, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %7)
  call void @"onebyonecpy_hls.p0a10struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.93"(i16* align 512 %_01, i16* align 512 %_110, i16* align 512 %_211, i16* align 512 %_312, i16* align 512 %_413, i16* align 512 %_514, i16* align 512 %_615, i16* align 512 %_716, i16* align 512 %_817, i16* align 512 %_918, [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %9)
  call fastcc void @"onebyonecpy_hls.p0a2380struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([2380 x i16]* %11, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %10)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a20struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* "orig.arg.no"="0" "unpacked"="0" %dst, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.0" %src_0, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.1" %src_1, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.2" %src_2, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.3" %src_3, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.4" %src_4, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.5" %src_5, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.6" %src_6, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.7" %src_7, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.8" %src_8, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.9" %src_9, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.10" %src_10, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.11" %src_11, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.12" %src_12, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.13" %src_13, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.14" %src_14, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.15" %src_15, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.16" %src_16, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.17" %src_17, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.18" %src_18, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.19" %src_19, i64 "orig.arg.no"="2" "unpacked"="2" %num) #5 {
entry:
  %0 = icmp eq [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.0.0.05.exit, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.0.0.05.exit ]
  %1 = trunc i64 %for.loop.idx2 to i5
  %dst.addr.0.0.06 = getelementptr [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  switch i5 %1, label %src.addr.0.0.05.case.19 [
    i5 0, label %src.addr.0.0.05.case.0
    i5 1, label %src.addr.0.0.05.case.1
    i5 2, label %src.addr.0.0.05.case.2
    i5 3, label %src.addr.0.0.05.case.3
    i5 4, label %src.addr.0.0.05.case.4
    i5 5, label %src.addr.0.0.05.case.5
    i5 6, label %src.addr.0.0.05.case.6
    i5 7, label %src.addr.0.0.05.case.7
    i5 8, label %src.addr.0.0.05.case.8
    i5 9, label %src.addr.0.0.05.case.9
    i5 10, label %src.addr.0.0.05.case.10
    i5 11, label %src.addr.0.0.05.case.11
    i5 12, label %src.addr.0.0.05.case.12
    i5 13, label %src.addr.0.0.05.case.13
    i5 14, label %src.addr.0.0.05.case.14
    i5 15, label %src.addr.0.0.05.case.15
    i5 -16, label %src.addr.0.0.05.case.16
    i5 -15, label %src.addr.0.0.05.case.17
    i5 -14, label %src.addr.0.0.05.case.18
  ]

src.addr.0.0.05.case.0:                           ; preds = %for.loop
  %_0 = load i16, i16* %src_0, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.1:                           ; preds = %for.loop
  %_1 = load i16, i16* %src_1, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.2:                           ; preds = %for.loop
  %_2 = load i16, i16* %src_2, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.3:                           ; preds = %for.loop
  %_3 = load i16, i16* %src_3, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.4:                           ; preds = %for.loop
  %_4 = load i16, i16* %src_4, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.5:                           ; preds = %for.loop
  %_5 = load i16, i16* %src_5, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.6:                           ; preds = %for.loop
  %_6 = load i16, i16* %src_6, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.7:                           ; preds = %for.loop
  %_7 = load i16, i16* %src_7, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.8:                           ; preds = %for.loop
  %_8 = load i16, i16* %src_8, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.9:                           ; preds = %for.loop
  %_9 = load i16, i16* %src_9, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.10:                          ; preds = %for.loop
  %_10 = load i16, i16* %src_10, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.11:                          ; preds = %for.loop
  %_11 = load i16, i16* %src_11, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.12:                          ; preds = %for.loop
  %_12 = load i16, i16* %src_12, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.13:                          ; preds = %for.loop
  %_13 = load i16, i16* %src_13, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.14:                          ; preds = %for.loop
  %_14 = load i16, i16* %src_14, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.15:                          ; preds = %for.loop
  %_15 = load i16, i16* %src_15, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.16:                          ; preds = %for.loop
  %_16 = load i16, i16* %src_16, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.17:                          ; preds = %for.loop
  %_17 = load i16, i16* %src_17, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.18:                          ; preds = %for.loop
  %_18 = load i16, i16* %src_18, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.19:                          ; preds = %for.loop
  %2 = icmp eq i5 %1, -13
  call void @llvm.assume(i1 %2)
  %_19 = load i16, i16* %src_19, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.exit:                             ; preds = %src.addr.0.0.05.case.19, %src.addr.0.0.05.case.18, %src.addr.0.0.05.case.17, %src.addr.0.0.05.case.16, %src.addr.0.0.05.case.15, %src.addr.0.0.05.case.14, %src.addr.0.0.05.case.13, %src.addr.0.0.05.case.12, %src.addr.0.0.05.case.11, %src.addr.0.0.05.case.10, %src.addr.0.0.05.case.9, %src.addr.0.0.05.case.8, %src.addr.0.0.05.case.7, %src.addr.0.0.05.case.6, %src.addr.0.0.05.case.5, %src.addr.0.0.05.case.4, %src.addr.0.0.05.case.3, %src.addr.0.0.05.case.2, %src.addr.0.0.05.case.1, %src.addr.0.0.05.case.0
  %3 = phi i16 [ %_0, %src.addr.0.0.05.case.0 ], [ %_1, %src.addr.0.0.05.case.1 ], [ %_2, %src.addr.0.0.05.case.2 ], [ %_3, %src.addr.0.0.05.case.3 ], [ %_4, %src.addr.0.0.05.case.4 ], [ %_5, %src.addr.0.0.05.case.5 ], [ %_6, %src.addr.0.0.05.case.6 ], [ %_7, %src.addr.0.0.05.case.7 ], [ %_8, %src.addr.0.0.05.case.8 ], [ %_9, %src.addr.0.0.05.case.9 ], [ %_10, %src.addr.0.0.05.case.10 ], [ %_11, %src.addr.0.0.05.case.11 ], [ %_12, %src.addr.0.0.05.case.12 ], [ %_13, %src.addr.0.0.05.case.13 ], [ %_14, %src.addr.0.0.05.case.14 ], [ %_15, %src.addr.0.0.05.case.15 ], [ %_16, %src.addr.0.0.05.case.16 ], [ %_17, %src.addr.0.0.05.case.17 ], [ %_18, %src.addr.0.0.05.case.18 ], [ %_19, %src.addr.0.0.05.case.19 ]
  store i16 %3, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.0.0.05.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @"onebyonecpy_hls.p0a20struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="0" "unpacked"="0" %dst, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.0" %src_0, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.1" %src_1, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.2" %src_2, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.3" %src_3, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.4" %src_4, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.5" %src_5, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.6" %src_6, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.7" %src_7, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.8" %src_8, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.9" %src_9, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.10" %src_10, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.11" %src_11, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.12" %src_12, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.13" %src_13, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.14" %src_14, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.15" %src_15, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.16" %src_16, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.17" %src_17, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.18" %src_18, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.19" %src_19) #4 {
entry:
  %0 = icmp eq [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a20struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %dst, i16* %src_0, i16* %src_1, i16* %src_2, i16* %src_3, i16* %src_4, i16* %src_5, i16* %src_6, i16* %src_7, i16* %src_8, i16* %src_9, i16* %src_10, i16* %src_11, i16* %src_12, i16* %src_13, i16* %src_14, i16* %src_15, i16* %src_16, i16* %src_17, i16* %src_18, i16* %src_19, i64 20)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a10struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* "orig.arg.no"="0" "unpacked"="0" %dst, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.0" %src_0, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.1" %src_1, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.2" %src_2, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.3" %src_3, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.4" %src_4, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.5" %src_5, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.6" %src_6, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.7" %src_7, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.8" %src_8, i16* nocapture readonly "orig.arg.no"="1" "unpacked"="1.0.9" %src_9, i64 "orig.arg.no"="2" "unpacked"="2" %num) #5 {
entry:
  %0 = icmp eq [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.0.0.05.exit, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.0.0.05.exit ]
  %1 = trunc i64 %for.loop.idx2 to i4
  %dst.addr.0.0.06 = getelementptr [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"], [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  switch i4 %1, label %src.addr.0.0.05.case.9 [
    i4 0, label %src.addr.0.0.05.case.0
    i4 1, label %src.addr.0.0.05.case.1
    i4 2, label %src.addr.0.0.05.case.2
    i4 3, label %src.addr.0.0.05.case.3
    i4 4, label %src.addr.0.0.05.case.4
    i4 5, label %src.addr.0.0.05.case.5
    i4 6, label %src.addr.0.0.05.case.6
    i4 7, label %src.addr.0.0.05.case.7
    i4 -8, label %src.addr.0.0.05.case.8
  ]

src.addr.0.0.05.case.0:                           ; preds = %for.loop
  %_0 = load i16, i16* %src_0, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.1:                           ; preds = %for.loop
  %_1 = load i16, i16* %src_1, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.2:                           ; preds = %for.loop
  %_2 = load i16, i16* %src_2, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.3:                           ; preds = %for.loop
  %_3 = load i16, i16* %src_3, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.4:                           ; preds = %for.loop
  %_4 = load i16, i16* %src_4, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.5:                           ; preds = %for.loop
  %_5 = load i16, i16* %src_5, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.6:                           ; preds = %for.loop
  %_6 = load i16, i16* %src_6, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.7:                           ; preds = %for.loop
  %_7 = load i16, i16* %src_7, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.8:                           ; preds = %for.loop
  %_8 = load i16, i16* %src_8, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.case.9:                           ; preds = %for.loop
  %2 = icmp eq i4 %1, -7
  call void @llvm.assume(i1 %2)
  %_9 = load i16, i16* %src_9, align 2
  br label %src.addr.0.0.05.exit

src.addr.0.0.05.exit:                             ; preds = %src.addr.0.0.05.case.9, %src.addr.0.0.05.case.8, %src.addr.0.0.05.case.7, %src.addr.0.0.05.case.6, %src.addr.0.0.05.case.5, %src.addr.0.0.05.case.4, %src.addr.0.0.05.case.3, %src.addr.0.0.05.case.2, %src.addr.0.0.05.case.1, %src.addr.0.0.05.case.0
  %3 = phi i16 [ %_0, %src.addr.0.0.05.case.0 ], [ %_1, %src.addr.0.0.05.case.1 ], [ %_2, %src.addr.0.0.05.case.2 ], [ %_3, %src.addr.0.0.05.case.3 ], [ %_4, %src.addr.0.0.05.case.4 ], [ %_5, %src.addr.0.0.05.case.5 ], [ %_6, %src.addr.0.0.05.case.6 ], [ %_7, %src.addr.0.0.05.case.7 ], [ %_8, %src.addr.0.0.05.case.8 ], [ %_9, %src.addr.0.0.05.case.9 ]
  store i16 %3, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.0.0.05.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @"onebyonecpy_hls.p0a10struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="0" "unpacked"="0" %dst, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.0" %src_0, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.1" %src_1, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.2" %src_2, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.3" %src_3, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.4" %src_4, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.5" %src_5, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.6" %src_6, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.7" %src_7, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.8" %src_8, i16* noalias nocapture readonly align 512 "orig.arg.no"="1" "unpacked"="1.0.9" %src_9) #4 {
entry:
  %0 = icmp eq [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a10struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* nonnull %dst, i16* %src_0, i16* %src_1, i16* %src_2, i16* %src_3, i16* %src_4, i16* %src_5, i16* %src_6, i16* %src_7, i16* %src_8, i16* %src_9, i64 10)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal void @copy_out(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias "orig.arg.no"="0" "unpacked"="0", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias align 512 "orig.arg.no"="1" "unpacked"="1", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias "orig.arg.no"="2" "unpacked"="2", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias align 512 "orig.arg.no"="3" "unpacked"="3", [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="4" "unpacked"="4", [800 x i16]* noalias nocapture readonly align 512 "orig.arg.no"="5" "unpacked"="5.0", [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="6" "unpacked"="6", i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.0" %_0, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.1" %_1, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.2" %_2, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.3" %_3, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.4" %_4, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.5" %_5, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.6" %_6, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.7" %_7, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.8" %_8, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.9" %_9, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.10" %_10, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.11" %_11, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.12" %_12, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.13" %_13, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.14" %_14, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.15" %_15, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.16" %_16, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.17" %_17, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.18" %_18, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.19" %_19, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="8" "unpacked"="8", [2000 x i16]* noalias nocapture readonly align 512 "orig.arg.no"="9" "unpacked"="9.0", [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="10" "unpacked"="10", i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.0" %_01, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.1" %_110, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.2" %_211, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.3" %_312, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.4" %_413, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.5" %_514, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.6" %_615, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.7" %_716, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.8" %_817, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.9" %_918, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="12" "unpacked"="12", [2380 x i16]* noalias nocapture readonly "orig.arg.no"="13" "unpacked"="13.0") #8 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %0, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %2, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0a800struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.133"([800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %4, [800 x i16]* align 512 %5)
  call void @"onebyonecpy_hls.p0a20struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %6, i16* align 512 %_0, i16* align 512 %_1, i16* align 512 %_2, i16* align 512 %_3, i16* align 512 %_4, i16* align 512 %_5, i16* align 512 %_6, i16* align 512 %_7, i16* align 512 %_8, i16* align 512 %_9, i16* align 512 %_10, i16* align 512 %_11, i16* align 512 %_12, i16* align 512 %_13, i16* align 512 %_14, i16* align 512 %_15, i16* align 512 %_16, i16* align 512 %_17, i16* align 512 %_18, i16* align 512 %_19)
  call fastcc void @"onebyonecpy_hls.p0a2000struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.106"([2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %7, [2000 x i16]* align 512 %8)
  call void @"onebyonecpy_hls.p0a10struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"([10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %9, i16* align 512 %_01, i16* align 512 %_110, i16* align 512 %_211, i16* align 512 %_312, i16* align 512 %_413, i16* align 512 %_514, i16* align 512 %_615, i16* align 512 %_716, i16* align 512 %_817, i16* align 512 %_918)
  call fastcc void @"onebyonecpy_hls.p0a2380struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>.83"([2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %10, [2380 x i16]* %11)
  ret void
}

declare void @apatb_myproject_hw(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"*, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"*, [800 x i16]*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, [2000 x i16]*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, [2380 x i16]*)

; Function Attrs: argmemonly noinline willreturn
define internal void @copy_back(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias "orig.arg.no"="0" "unpacked"="0", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias align 512 "orig.arg.no"="1" "unpacked"="1", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias "orig.arg.no"="2" "unpacked"="2", %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* noalias align 512 "orig.arg.no"="3" "unpacked"="3", [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="4" "unpacked"="4", [800 x i16]* noalias nocapture readonly align 512 "orig.arg.no"="5" "unpacked"="5.0", [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="6" "unpacked"="6", i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.0" %_0, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.1" %_1, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.2" %_2, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.3" %_3, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.4" %_4, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.5" %_5, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.6" %_6, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.7" %_7, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.8" %_8, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.9" %_9, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.10" %_10, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.11" %_11, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.12" %_12, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.13" %_13, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.14" %_14, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.15" %_15, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.16" %_16, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.17" %_17, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.18" %_18, i16* noalias nocapture readonly align 512 "orig.arg.no"="7" "unpacked"="7.0.19" %_19, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="8" "unpacked"="8", [2000 x i16]* noalias nocapture readonly align 512 "orig.arg.no"="9" "unpacked"="9.0", [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="10" "unpacked"="10", i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.0" %_01, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.1" %_110, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.2" %_211, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.3" %_312, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.4" %_413, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.5" %_514, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.6" %_615, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.7" %_716, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.8" %_817, i16* noalias nocapture readonly align 512 "orig.arg.no"="11" "unpacked"="11.0.9" %_918, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* noalias "orig.arg.no"="12" "unpacked"="12", [2380 x i16]* noalias nocapture readonly "orig.arg.no"="13" "unpacked"="13.0") #8 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %0, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %2, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* align 512 %3)
  ret void
}

define void @myproject_hw_stub_wrapper(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"*, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"*, [800 x i16]*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, [2000 x i16]*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, i16*, [2380 x i16]*) #9 {
entry:
  %35 = alloca [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]
  %36 = alloca [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]
  %37 = alloca [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]
  %38 = alloca [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]
  %malloccall = tail call i8* @malloc(i64 4760)
  %39 = bitcast i8* %malloccall to [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]*
  call void @copy_out(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* null, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %0, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* null, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %1, [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %35, [800 x i16]* %2, [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %36, i16* %3, i16* %4, i16* %5, i16* %6, i16* %7, i16* %8, i16* %9, i16* %10, i16* %11, i16* %12, i16* %13, i16* %14, i16* %15, i16* %16, i16* %17, i16* %18, i16* %19, i16* %20, i16* %21, i16* %22, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %37, [2000 x i16]* %23, [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %38, i16* %24, i16* %25, i16* %26, i16* %27, i16* %28, i16* %29, i16* %30, i16* %31, i16* %32, i16* %33, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %39, [2380 x i16]* %34)
  %40 = bitcast [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %35 to %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*
  %41 = bitcast [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %36 to %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*
  %42 = bitcast [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %37 to %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*
  %43 = bitcast [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %38 to %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*
  %44 = bitcast [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %39 to %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*
  call void @myproject_hw_stub(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %0, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %1, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %40, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %41, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %42, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %43, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"* %44)
  call void @copy_in(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* null, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %0, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* null, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"* %1, [800 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %35, [800 x i16]* %2, [20 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %36, i16* %3, i16* %4, i16* %5, i16* %6, i16* %7, i16* %8, i16* %9, i16* %10, i16* %11, i16* %12, i16* %13, i16* %14, i16* %15, i16* %16, i16* %17, i16* %18, i16* %19, i16* %20, i16* %21, i16* %22, [2000 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %37, [2000 x i16]* %23, [10 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %38, i16* %24, i16* %25, i16* %26, i16* %27, i16* %28, i16* %29, i16* %30, i16* %31, i16* %32, i16* %33, [2380 x %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"]* %39, [2380 x i16]* %34)
  ret void
}

declare void @myproject_hw_stub(%"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"*, %"class.hls::stream<nnet::array<ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>, 1>, 0>"*, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*, %"struct.ap_fixed<16, 6, AP_TRN, AP_WRAP, 0>"*)

declare i1 @fpga_fifo_not_empty_2(i8*)

declare void @fpga_fifo_pop_2(i8*, i8*)

declare void @fpga_fifo_push_2(i8*, i8*)

attributes #0 = { inaccessiblememonly nounwind willreturn }
attributes #1 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #2 = { argmemonly noinline willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline willreturn "fpga.wrapper.func"="streamcpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #5 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #6 = { nounwind willreturn }
attributes #7 = { argmemonly noinline willreturn "fpga.wrapper.func"="copyin" }
attributes #8 = { argmemonly noinline willreturn "fpga.wrapper.func"="copyout" }
attributes #9 = { "fpga.wrapper.func"="stub" }
attributes #10 = { inaccessiblememonly nounwind willreturn "xlx.port.bitwidth"="16" "xlx.source"="user" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}
!datalayout.transforms.on.top = !{!5, !31}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = !{!6, !8, !10}
!6 = !{!7}
!7 = !{!"3.0", [20 x i16]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30}
!11 = !{!"3.0.0", i16* null}
!12 = !{!"3.0.1", i16* null}
!13 = !{!"3.0.2", i16* null}
!14 = !{!"3.0.3", i16* null}
!15 = !{!"3.0.4", i16* null}
!16 = !{!"3.0.5", i16* null}
!17 = !{!"3.0.6", i16* null}
!18 = !{!"3.0.7", i16* null}
!19 = !{!"3.0.8", i16* null}
!20 = !{!"3.0.9", i16* null}
!21 = !{!"3.0.10", i16* null}
!22 = !{!"3.0.11", i16* null}
!23 = !{!"3.0.12", i16* null}
!24 = !{!"3.0.13", i16* null}
!25 = !{!"3.0.14", i16* null}
!26 = !{!"3.0.15", i16* null}
!27 = !{!"3.0.16", i16* null}
!28 = !{!"3.0.17", i16* null}
!29 = !{!"3.0.18", i16* null}
!30 = !{!"3.0.19", i16* null}
!31 = !{!32, !8, !34}
!32 = !{!33}
!33 = !{!"5.0", [10 x i16]* null}
!34 = !{!35, !36, !37, !38, !39, !40, !41, !42, !43, !44}
!35 = !{!"5.0.0", i16* null}
!36 = !{!"5.0.1", i16* null}
!37 = !{!"5.0.2", i16* null}
!38 = !{!"5.0.3", i16* null}
!39 = !{!"5.0.4", i16* null}
!40 = !{!"5.0.5", i16* null}
!41 = !{!"5.0.6", i16* null}
!42 = !{!"5.0.7", i16* null}
!43 = !{!"5.0.8", i16* null}
!44 = !{!"5.0.9", i16* null}
!45 = distinct !{!45, !46}
!46 = !{!"llvm.loop.rotate.disable"}
