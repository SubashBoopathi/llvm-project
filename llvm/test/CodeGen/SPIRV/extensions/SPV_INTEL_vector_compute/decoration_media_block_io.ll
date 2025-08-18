; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_vector_compute %s -o - | FileCheck %s

; XFAIL:*

; CHECK-DAG: OpName %[[#IM2D:]] "im2d"
; CHECK-DAG: OpName %[[#IM3D:]] "im3d"
; CHECK-DAG: OpDecorate %[[#IM3D]] MediaBlockIOINTEL
; CHECK-DAG: OpDecorate %[[#IM2D]] MediaBlockIOINTEL

define spir_kernel void @test(target("spirv.BufferSurfaceINTEL", 2) %buf, target("spirv.Image", void, 0, 0, 0, 0, 0, 0, 2) %im1d, target("spirv.Image", void, 5, 0, 0, 0, 0, 0, 2) %im1db, target("spirv.Image", void, 1, 0, 0, 0, 0, 0, 2) "VCMediaBlockIO" %im2d, target("spirv.Image", void, 2, 0, 0, 0, 0, 0, 2) "VCMediaBlockIO" %im3d, target("spirv.Sampler") %samp, ptr addrspace(1) %ptr, <4 x i32> %gen) #0 {
entry:
  ret void
}
attributes #0 = { "VCFunction" }
