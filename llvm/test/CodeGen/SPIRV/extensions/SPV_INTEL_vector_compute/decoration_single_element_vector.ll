; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_vector_compute %s -o - | FileCheck %s

; XFAIL:*

@global_var = external global ptr #2

; CHECK-DAG: OpName [[def:[0-9]+]] "_Z24__cm_intrinsic_impl_sdivu2CMvb1_cS_"
; CHECK-DAG: OpName [[a:[0-9]+]] "a"
; CHECK-DAG: OpName [[b:[0-9]+]] "b"
; CHECK-DAG: OpName [[glob:[0-9]+]] "global_var"
; CHECK-DAG: OpDecorate [[def]] SingleElementVectorINTEL
; CHECK-DAG: OpDecorate [[a]] SingleElementVectorINTEL
; CHECK-DAG: OpDecorate [[b]] SingleElementVectorINTEL
; CHECK-DAG: OpDecorate [[glob]] SingleElementVectorINTEL 2

define dso_local "VCSingleElementVector" i8 @_Z24__cm_intrinsic_impl_sdivu2CMvb1_cS_(i8 "VCSingleElementVector" %a, i8 "VCSingleElementVector" %b) local_unnamed_addr #1 {
entry:
  %conv.i.i = sitofp i8 %a to float
  %conv1.i.i = sitofp i8 %b to float
  %div.i.i = fdiv float 1.000000e+00, %conv1.i.i
  %mul.i.i = fmul float %conv.i.i, 0x3FF0000100000000
  %mul2.i.i = fmul float %mul.i.i, %div.i.i
  %conv3.i.i = fptosi float %mul2.i.i to i32
  %conv3.i = trunc i32 %conv3.i.i to i8
  ret i8 %conv3.i
}

; Function Attrs: noinline nounwind
define dso_local dllexport spir_kernel void @linear(i8 %ibuf, i8 %obuf) local_unnamed_addr #1 {
entry:
  %0 = call i8 @_Z24__cm_intrinsic_impl_sdivu2CMvb1_cS_(i8 %ibuf, i8 %obuf)
  %1 = tail call i8 @some.unknown.intrinsic(i8 %ibuf, i8 %obuf)
  ret void
}

; Function Attrs: nounwind readnone
declare i8 @some.unknown.intrinsic(i8 "VCSingleElementVector", i8) #1

; LLVM: "VCGlobalVariable"
; LLVM-SAME: "VCSingleElementVector"="2"

attributes #1 = { noinline norecurse nounwind readnone "VCFunction"}
attributes #2 = { "VCGlobalVariable" "VCSingleElementVector"="2" }
