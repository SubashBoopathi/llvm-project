; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv64-unknown-unknown %s -o - | FileCheck %s
; RUN: %if spirv-tools %{ llc -O0 -mtriple=spirv64-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; CHECK-DAG: OpName %[[#r1:]] "r1"
; CHECK-DAG: OpName %[[#r2:]] "r2"
; CHECK-DAG: OpName %[[#r3:]] "r3"
; CHECK-DAG: OpName %[[#r4:]] "r4"
; CHECK-DAG: OpName %[[#r5:]] "r5"
; CHECK-DAG: OpName %[[#r6:]] "r6"
; CHECK-DAG: OpName %[[#r7:]] "r7"
; CHECK-DAG: OpName %[[#r8:]] "r8"
; CHECK-DAG: OpName %[[#r9:]] "r9"
; CHECK-DAG: OpName %[[#r10:]] "r10"
; CHECK-DAG: OpName %[[#r11:]] "r11"
; CHECK-DAG: OpName %[[#r12:]] "r12"
; CHECK-DAG: OpName %[[#r13:]] "r13"
; CHECK-DAG: OpName %[[#r14:]] "r14"
; CHECK-DAG: OpName %[[#r15:]] "r15"
; CHECK-DAG: OpName %[[#r16:]] "r16"
; CHECK-DAG: OpName %[[#r17:]] "r17"
; CHECK-DAG: OpName %[[#r18:]] "r18"
; CHECK-DAG: OpName %[[#r21:]] "r21"
; CHECK-DAG: OpName %[[#r22:]] "r22"
; CHECK-DAG: OpName %[[#r23:]] "r23"
; CHECK-DAG: OpName %[[#r24:]] "r24"
; CHECK-DAG: OpName %[[#r25:]] "r25"
; CHECK-DAG: OpName %[[#r26:]] "r26"
; CHECK-DAG: OpName %[[#r27:]] "r27"
; CHECK-DAG: OpName %[[#r28:]] "r28"
; CHECK-DAG: OpName %[[#r29:]] "r29"
; CHECK-DAG: OpName %[[#r20:]] "r30"

; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTE
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTZ
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTP
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTN
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTZ
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTP
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTN
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTE
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTZ
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTP
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTN
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTE
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTZ
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTP
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTN
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTE
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTZ
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTP
; CHECK-DAG: OpDecorate %[[#]] FPRoundingMode RTE

; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] pow %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] pown %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] sin %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] cos %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] tan %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] asin %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] acos %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] atan %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] atan2 %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] sinh %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] cosh %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] tanh %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] exp %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] exp2 %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] log %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] log10 %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] log2 %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] rint %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] rint %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] fmax %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] fmin %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] fmin %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] fmax %[[#]] %[[#]]
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] ceil %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] floor %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] round %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] rint %[[#]] 
; CHECK-DAG: %[[#]] = OpExtInst %[[#]] %[[#]] trunc %[[#]] 
; CHECK-DAG: OpFunctionEnd

define dso_local spir_kernel void @test(float %a, i32 %in, i32 %ui) {
entry:
  %r1 = tail call float @llvm.experimental.constrained.pow(float %a, float %a, metadata !"round.tonearest", metadata !"fpexcept.strict")
  %r2 = tail call float @llvm.experimental.constrained.powi(float %a, i32 %in, metadata !"round.towardzero", metadata !"fpexcept.strict")
  %r3 = tail call float @llvm.experimental.constrained.sin(float %a, metadata !"round.upward", metadata !"fpexcept.strict")
  %r4 = tail call float @llvm.experimental.constrained.cos(float %a, metadata !"round.downward", metadata !"fpexcept.strict")
  %r5 = tail call float @llvm.experimental.constrained.tan(float %a, metadata !"round.towardzero", metadata !"fpexcept.strict")
  %r6 = tail call float @llvm.experimental.constrained.asin(float %a, metadata !"round.upward", metadata !"fpexcept.strict")
  %r7 = tail call float @llvm.experimental.constrained.acos(float %a, metadata !"round.downward", metadata !"fpexcept.strict")
  %r8 = tail call float @llvm.experimental.constrained.atan(float %a, metadata !"round.tonearest", metadata !"fpexcept.strict")
  %r9 = tail call float @llvm.experimental.constrained.atan2(float %a, float %a, metadata !"round.towardzero", metadata !"fpexcept.strict")
  %r10 = tail call float @llvm.experimental.constrained.sinh(float %a, metadata !"round.upward", metadata !"fpexcept.strict")
  %r11 = tail call float @llvm.experimental.constrained.cosh(float %a, metadata !"round.downward", metadata !"fpexcept.strict")
  %r12 = tail call float @llvm.experimental.constrained.tanh(float %a, metadata !"round.tonearest", metadata !"fpexcept.strict")
  %r13 = tail call float @llvm.experimental.constrained.exp(float %a, metadata !"round.towardzero", metadata !"fpexcept.strict")
  %r14 = tail call float @llvm.experimental.constrained.exp2(float %a, metadata !"round.upward", metadata !"fpexcept.strict")
  %r15 = tail call float @llvm.experimental.constrained.log(float %a, metadata !"round.downward", metadata !"fpexcept.strict")
  %r16 = tail call float @llvm.experimental.constrained.log10(float %a, metadata !"round.tonearest", metadata !"fpexcept.strict")
  %r17 = tail call float @llvm.experimental.constrained.log2(float %a, metadata !"round.towardzero", metadata !"fpexcept.strict")
  %r18 = tail call float @llvm.experimental.constrained.rint(float %a, metadata !"round.upward", metadata !"fpexcept.strict")
  %r21 = tail call float @llvm.experimental.constrained.nearbyint(float %a, metadata !"round.tonearest", metadata !"fpexcept.strict")
  %r22 = tail call float @llvm.experimental.constrained.maxnum(float %a, float %a, metadata !"fpexcept.strict")
  %r23 = tail call float @llvm.experimental.constrained.minnum(float %a, float %a, metadata !"fpexcept.strict")
  %r24 = tail call float @llvm.experimental.constrained.maximum(float %a, float %a, metadata !"fpexcept.strict")
  %r25 = tail call float @llvm.experimental.constrained.minimum(float %a, float %a, metadata !"fpexcept.strict")
  %r26 = tail call float @llvm.experimental.constrained.ceil(float %a, metadata !"fpexcept.strict")
  %r27 = tail call float @llvm.experimental.constrained.floor(float %a, metadata !"fpexcept.strict")
  %r28 = tail call float @llvm.experimental.constrained.round(float %a, metadata !"fpexcept.strict")
  %r29 = tail call float @llvm.experimental.constrained.roundeven(float %a, metadata !"fpexcept.strict")
  %r30 = tail call float @llvm.experimental.constrained.trunc(float %a, metadata !"fpexcept.strict")
  ret void
}
