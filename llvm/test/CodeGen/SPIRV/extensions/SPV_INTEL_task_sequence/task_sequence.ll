; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_task_sequence %s -o - | FileCheck %s

; XFAIL:*

; Source SYCL code example
; int mult(int a, int b) {
;   return a * b;
; }

; class MyKernel;

; int main() {
;   constexpr int kN = 16384;
;   // create the device queue
;   sycl::queue q(testconfig_selector_v, &m_exception_handler);
;   // create input and golden output data
;   int *in = malloc_host<int>(kN, q);
;   int *res = malloc_shared<int>(kN, q);
;   std::vector<int> golden(kN);
;   for (int i = 0; i < kN; i++) {
;     in[i] = i;
;     golden[i] = i * i;
;   }
;   ext::oneapi::experimental::properties kernel_properties{
;       sycl::ext::intel::experimental::use_stall_enable_clusters};
;   q.single_task<MyKernel>(kernel_properties, [=]() {
;      sycl::ext::intel::experimental::task_sequence<
;          mult, decltype(ext::oneapi::experimental::properties(
;                    balanced, invocation_capacity<10>, response_capacity<17>,
;                    pipelined<>, use_stall_enable_clusters))>
;          myMultTask;
;      for (int i = 0; i < kN; i++) {
;        myMultTask.async(in[i], in[i]);
;      }
;      for (int i = 0; i < kN; i++) {
;        res[i] = myMultTask.get();
;      }
;    }).wait_and_throw();
;   return 0;
; }

; CHECK: %[[#IntTy:]] = OpTypeInt 32 0
; CHECK: %[[#TypeTS:]] = OpTypeTaskSequenceINTEL
; CHECK: %[[#StructTS:]] = OpTypeStruct %[[#TypeTS]]
; CHECK-UNTYPED-PTR: %[[#Ptr:]] = OpTypeUntypedPointerKHR Function
; CHECK: %[[#FuncTy:]] = OpTypeFunction  %[[#IntTy]] %[[#IntTy]] %[[#IntTy]]
; CHECK-TYPED-PTR: %[[#PtrTS:]] = OpTypePointer Function %[[#TypeTS]]

; <id> Result Type <id> Result <id> Function Literal Pipelined Literal UseStallEnableClusters Literal GetCapacity Literal AsyncCapacity
; CHECK: %[[#CreateRes:]] = OpTaskSequenceCreateINTEL %[[#TypeTS]] %[[#FuncId:]] 10 4294967295 17 1
; CHECK-TYPED-PTR: %[[#GEP:]] = OpInBoundsPtrAccessChain %[[#PtrTS]] 
; CHECK-UNTYPED-PTR: %[[#GEP:]] = OpUntypedInBoundsPtrAccessChainKHR %[[#Ptr]] %[[#StructTS]]
; CHECK: OpStore %[[#GEP]] %[[#CreateRes]]
; CHECK: %[[#LoadIntVar:]] = OpLoad %[[#IntTy]] %[[#]] Aligned 8
; CHECK: %[[#LoadIntVar:]] = OpLoad %[[#IntTy]] %[[#]] Aligned 8
; CHECK: %[[#LoadId:]] = OpLoad %[[#TypeTS]] %[[#GEP]] Aligned 8
; CHECK: OpTaskSequenceAsyncINTEL %[[#LoadId]] %[[#LoadIntVar]] %[[#LoadIntVar]]
; CHECK: %[[#SeqId:]] = OpLoad %[[#TypeTS]] %[[#GEP]] Aligned 8
; CHECK: %[[#:]] = TaskSequenceGetINTEL %[[#IntTy]] %[[#SeqId]]
; CHECK: %[[#ReleaseSeqId:]] = OpLoad %[[#TypeTS]] %[[#GEP]]
; CHECK: OpTaskSequenceReleaseINTEL %[[#ReleaseSeqId]]
; CHECK: %[[#FuncId]] = OpFunction %[[#IntTy]] None %[[#FuncTy]]

%"class.sycl::_V1::ext::intel::experimental::task_sequence.3" = type { target("spirv.TaskSequenceINTEL") }

$_ZTS8MyKernel = comdat any

; Function Attrs: convergent mustprogress norecurse nounwind
define weak_odr dso_local spir_kernel void @_ZTS8MyKernel(ptr addrspace(1) noundef align 4 %_arg_in, ptr addrspace(1) noundef align 4 %_arg_res) local_unnamed_addr #0 comdat !srcloc !5 !kernel_arg_buffer_location !6 !sycl_fixed_targets !7 !sycl_kernel_omit_args !8 !stall_enable !9 {
entry:
  %myMultTask.i = alloca %"class.sycl::_V1::ext::intel::experimental::task_sequence.3", align 8
  store i32 0, ptr %myMultTask.i, align 8, !tbaa !10
  %call.i1 = call spir_func noundef target("spirv.TaskSequenceINTEL") @_Z31__spirv_TaskSequenceCreateINTELIN4sycl3_V13ext5intel12experimental13task_sequenceIL_Z4multiiENS2_6oneapi12experimental10propertiesISt5tupleIJNS7_14property_valueINS4_13pipelined_keyEJSt17integral_constantIiLin1EEEEENSA_INS4_16fpga_cluster_keyEJSC_INS4_25fpga_cluster_options_enumELSG_1EEEEENSA_INS4_12balanced_keyEJEEENSA_INS4_23invocation_capacity_keyEJSC_IjLj10EEEEENSA_INS4_21response_capacity_keyEJSC_IjLj17EEEEEEEEEEEiJiiEEmPT_PFT0_DpT1_Ejjit(ptr noundef nonnull @_Z4multii, i32 noundef 10, i32 noundef -1, i32 noundef 17, i16 noundef zeroext 1) #3
  %id.i = getelementptr inbounds %"class.sycl::_V1::ext::intel::experimental::task_sequence.3", ptr %myMultTask.i, i64 0, i32 0
  store target("spirv.TaskSequenceINTEL") %call.i1, ptr %id.i, align 8, !tbaa !16
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.body.i, %entry
  %i.0.i = phi i32 [ 0, %entry ], [ %inc.i, %for.body.i ]
  %cmp.i = icmp ult i32 %i.0.i, 16384
  br i1 %cmp.i, label %for.body.i, label %for.cond6.i

for.body.i:                                       ; preds = %for.cond.i
  %idxprom.i = zext nneg i32 %i.0.i to i64
  %arrayidx.i = getelementptr inbounds i32, ptr addrspace(1) %_arg_in, i64 %idxprom.i
  %0 = load i32, ptr addrspace(1) %arrayidx.i, align 4, !tbaa !17
  %1 = load i32, ptr %myMultTask.i, align 8, !tbaa !10
  %inc.i2 = add i32 %1, 1
  store i32 %inc.i2, ptr %myMultTask.i, align 8, !tbaa !10
  %2 = load target("spirv.TaskSequenceINTEL"), ptr %id.i, align 8, !tbaa !16
  call spir_func void @_Z30__spirv_TaskSequenceAsyncINTELIJiiEEvmDpT_(target("spirv.TaskSequenceINTEL") noundef %2, i32 noundef %0, i32 noundef %0) #3
  %inc.i = add nuw nsw i32 %i.0.i, 1
  br label %for.cond.i, !llvm.loop !18

for.cond6.i:                                      ; preds = %for.body10.i, %for.cond.i
  %i5.0.i = phi i32 [ %inc14.i, %for.body10.i ], [ 0, %for.cond.i ]
  %cmp7.i = icmp ult i32 %i5.0.i, 16384
  br i1 %cmp7.i, label %for.body10.i, label %_ZZ4mainENKUlvE_clEv.exit

for.body10.i:                                     ; preds = %for.cond6.i
  %3 = load i32, ptr %myMultTask.i, align 8, !tbaa !10
  %dec.i = add i32 %3, -1
  store i32 %dec.i, ptr %myMultTask.i, align 8, !tbaa !10
  %4 = load target("spirv.TaskSequenceINTEL"), ptr %id.i, align 8, !tbaa !16
  %call.i5 = call spir_func noundef i32 @_Z28__spirv_TaskSequenceGetINTELIiET_m(target("spirv.TaskSequenceINTEL") noundef %4) #3
  %idxprom11.i = zext nneg i32 %i5.0.i to i64
  %arrayidx12.i = getelementptr inbounds i32, ptr addrspace(1) %_arg_res, i64 %idxprom11.i
  store i32 %call.i5, ptr addrspace(1) %arrayidx12.i, align 4, !tbaa !17
  %inc14.i = add nuw nsw i32 %i5.0.i, 1
  br label %for.cond6.i, !llvm.loop !20

_ZZ4mainENKUlvE_clEv.exit:                        ; preds = %for.cond6.i
  %5 = load target("spirv.TaskSequenceINTEL"), ptr %id.i, align 8, !tbaa !16
  call spir_func void @_Z32__spirv_TaskSequenceReleaseINTELm(target("spirv.TaskSequenceINTEL") noundef %5) #3
  ret void
}

; Function Attrs: mustprogress norecurse nounwind
define linkonce_odr dso_local spir_func noundef i32 @_Z4multii(i32 noundef %a, i32 noundef %b) #1 !srcloc !21 {
entry:
  %mul = mul nsw i32 %a, %b
  ret i32 %mul
}

; Function Attrs: convergent nounwind
declare dso_local spir_func noundef target("spirv.TaskSequenceINTEL") @_Z31__spirv_TaskSequenceCreateINTELIN4sycl3_V13ext5intel12experimental13task_sequenceIL_Z4multiiENS2_6oneapi12experimental10propertiesISt5tupleIJNS7_14property_valueINS4_13pipelined_keyEJSt17integral_constantIiLin1EEEEENSA_INS4_16fpga_cluster_keyEJSC_INS4_25fpga_cluster_options_enumELSG_1EEEEENSA_INS4_12balanced_keyEJEEENSA_INS4_23invocation_capacity_keyEJSC_IjLj10EEEEENSA_INS4_21response_capacity_keyEJSC_IjLj17EEEEEEEEEEEiJiiEEmPT_PFT0_DpT1_Ejjit(ptr noundef, i32 noundef, i32 noundef, i32 noundef, i16 noundef zeroext) local_unnamed_addr #2

; Function Attrs: convergent nounwind
declare dso_local spir_func void @_Z30__spirv_TaskSequenceAsyncINTELIJiiEEvmDpT_(target("spirv.TaskSequenceINTEL") noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: convergent nounwind
declare dso_local spir_func noundef i32 @_Z28__spirv_TaskSequenceGetINTELIiET_m(target("spirv.TaskSequenceINTEL") noundef) local_unnamed_addr #2

; Function Attrs: convergent nounwind
declare dso_local spir_func void @_Z32__spirv_TaskSequenceReleaseINTELm(target("spirv.TaskSequenceINTEL") noundef) local_unnamed_addr #2

attributes #0 = { convergent mustprogress norecurse nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "sycl-fpga-cluster"="1" "sycl-module-id"="test.cpp" "sycl-optlevel"="2" "sycl-single-task" "uniform-work-group-size"="true" }
attributes #1 = { mustprogress norecurse nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "sycl-optlevel"="2" }
attributes #2 = { convergent nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #3 = { convergent nounwind }

!opencl.spir.version = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!spirv.Source = !{!1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1}
!llvm.ident = !{!2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2}
!llvm.module.flags = !{!3, !4}
!sycl.specialization-constants = !{}
!sycl.specialization-constants-default-values = !{}

!0 = !{i32 1, i32 2}
!1 = !{i32 4, i32 100000}
!2 = !{!"clang version 18.0.0git (https://github.com/bowenxue-intel/llvm.git bb1121cb47589e94ab65b81971a298b9d2c21ff6)"}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{i32 5445863}
!6 = !{i32 -1, i32 -1}
!7 = !{}
!8 = !{i1 false, i1 false}
!9 = !{i1 true}
!10 = !{!11, !12, i64 0}
!11 = !{!"_ZTSN4sycl3_V13ext5intel12experimental13task_sequenceIL_Z4multiiENS1_6oneapi12experimental10propertiesISt5tupleIJNS6_14property_valueINS3_13pipelined_keyEJSt17integral_constantIiLin1EEEEENS9_INS3_16fpga_cluster_keyEJSB_INS3_25fpga_cluster_options_enumELSF_1EEEEENS9_INS3_12balanced_keyEJEEENS9_INS3_23invocation_capacity_keyEJSB_IjLj10EEEEENS9_INS3_21response_capacity_keyEJSB_IjLj17EEEEEEEEEEE", !12, i64 0, !15, i64 8}
!12 = !{!"int", !13, i64 0}
!13 = !{!"omnipotent char", !14, i64 0}
!14 = !{!"Simple C++ TBAA"}
!15 = !{!"long", !13, i64 0}
!16 = !{!11, !15, i64 8}
!17 = !{!12, !12, i64 0}
!18 = distinct !{!18, !19}
!19 = !{!"llvm.loop.mustprogress"}
!20 = distinct !{!20, !19}
!21 = !{i32 5445350}
