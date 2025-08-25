; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv64-unknown-unknown %s -o - | FileCheck %s
; RUN: %if spirv-tools %{ llc -O0 -mtriple=spirv64-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; CHECK-DAG: OpName %[[#r40:]] "r40"
; CHECK-DAG: OpName %[[#r41:]] "r41"
; CHECK-DAG: OpName %[[#r19:]] "r19"
; CHECK-DAG: OpName %[[#r20:]] "r20"
; CHECK-DAG: OpDecorate %[[#r19]] FPRoundingMode RTE
; CHECK-DAG: OpDecorate %[[#r20]] FPRoundingMode RTE

; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] rint %[[#]]
; CHECK-DAG: %[[#]] = OpConvertFToS %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] rint %[[#]] 
; CHECK-DAG: %[[#]] = OpConvertFToS %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] rint %[[#]] 
; CHECK-DAG: %[[#]] = OpConvertFToS %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] rint %[[#]] 
; CHECK-DAG: %[[#]] = OpConvertFToS %[[#]] %[[#]]

define dso_local spir_kernel void @test(float %a, i32 %in, i32 %ui) {
entry:
  %r40 = tail call i32 @llvm.lrint.i32.f32(float %a)
  %r41 = tail call i64 @llvm.lrint.i64.f32(float %a)
  %r19 = tail call i32 @llvm.experimental.constrained.lrint(float %a, metadata !"round.tonearest", metadata !"fpexcept.strict")
  %r20 = tail call i32 @llvm.experimental.constrained.llrint(float %a, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret void 
}
