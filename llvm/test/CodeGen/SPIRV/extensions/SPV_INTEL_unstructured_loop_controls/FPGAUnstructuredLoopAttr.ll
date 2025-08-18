; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_unstructured_loop_controls --spirv-ext=+SPV_INTEL_fpga_loop_controls %s -o - | FileCheck %s

; XFAIL:*

; CHECK: OpCapability UnstructuredLoopControlsINTEL 
; CHECK: OpCapability FPGALoopControlsINTEL 
; CHECK: OpExtension "SPV_INTEL_fpga_loop_controls"
; CHECK: OpExtension "SPV_INTEL_unstructured_loop_controls"
; CHECK: OpName %[[#FOO:]] "foo"
; CHECK: OpName %[[#ENTRY_1:]] "entry"
; CHECK: OpName %[[#FOR:]] "for.cond"
; CHECK: OpName %[[#BOO:]] "boo"
; CHECK: OpName %[[#ENTRY_2:]] "entry"
; CHECK: OpName %[[#WHILE:]] "while.body"
; CHECK: %[[#FOO]] = OpFunction %[[#]] %[[#]] %[[#]]
; CHECK: %[[#ENTRY_1]] = OpLabel
; CHECK: OpBranch  %[[#FOR]]
; CHECK: %[[#FOR]] = OpLabel

; Per SPIR-V spec extension INTEL/SPV_INTEL_fpga_loop_controls,
; LoopControlMaxConcurrencyINTELMask = 0x20000 (131072)
; CHECK: OpLoopControlINTEL 131072 2
; CHECK-NEXT: OpBranch %[[#FOR]]

; CHECK: %[[#BOO]] = OpFunction %[[#]] %[[#]] %[[#]]
; CHECK: %[[#ENTRY_2]] = OpLabel
; CHECK: OpBranch %[[#WHILE]]
; CHECK: OpLabel = %[[#WHILE]]

; Per SPIR-V spec extension INTEL/SPV_INTEL_fpga_loop_controls,
; LoopControlInitiationIntervalINTELMask = 0x10000 (65536)
; CHECK: OpLoopControlINTEL 65536 2
; CHECK-NEXT: OpBranch %[[#WHILE]]

; Function Attrs: norecurse noreturn nounwind readnone
define spir_kernel void @foo() local_unnamed_addr #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond, !llvm.loop !3
}

; Function Attrs: norecurse noreturn nounwind readnone
define spir_kernel void @boo() local_unnamed_addr #0 {
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %while.body
  br label %while.body, !llvm.loop !5
}

attributes #0 = { nounwind }
!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!opencl.spir.version = !{!1}
!llvm.ident = !{!2}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 2}
!2 = !{!"clang version 9.0.0"}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.max_concurrency.count", i32 2}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.ii.count", i32 2}
