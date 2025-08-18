; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_vector_compute %s -o - | FileCheck %s

; XFAIL:*

; CHECK: OpCapability TensorFloat32RoundingINTEL
; CHECK: OpExtension "SPV_INTEL_tensor_float32_conversion"
; CHECK: %[[#FP32Ty:]] = OpTypeFloat 32
; CHECK: %[[#FP32v8Ty:]] = OpTypeVector %[[#FP32Ty]] 8
; CHECK: %[[#CONST:]] = OpConstant %[[#FP32Ty]] 1065353216
; CHECK: %[[#FP32ValId:]] = OpFunctionParameter %[[#FP32Ty]]
; CHECK: %[[#FP32v8ValId:]] = OpFunctionParameter %[[#FP32v8Ty]]
; CHECK: OpRoundFToTF32INTEL %[[#FP32Ty]] %[[#FP32ValId]] 
; CHECK: OpRoundFToTF32INTEL %[[#FP32v8Ty]] %[[#FP32v8ValId]] 
; CHECK: OpRoundFToTF32INTEL %[[#FP32Ty]] %[[#CONST]] 

define spir_func void @_Z2opffv8(float %a, <8 x float> %in) {
  %1 = tail call spir_func float @_Z25__spirv_RoundFToTF32INTELf(float %a)
  %2 = tail call spir_func <8 x float> @_Z25__spirv_RoundFToTF32INTELDv8_f(<8 x float> %in)
  %3 = tail call spir_func float @_Z25__spirv_RoundFToTF32INTELf(float 1.000000e+00)
  ret void
}

declare spir_func float @_Z25__spirv_RoundFToTF32INTELf(float)

declare spir_func <8 x float> @_Z25__spirv_RoundFToTF32INTELDv8_f(<8 x float>)

!opencl.spir.version = !{!0}
!spirv.Source = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 1, i32 2}
!1 = !{i32 4, i32 100000}
!2 = !{!"clang version 16.0.0"}
