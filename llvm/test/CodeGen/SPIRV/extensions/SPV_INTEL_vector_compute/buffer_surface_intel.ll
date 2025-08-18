; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_vector_compute %s -o - | FileCheck %s

declare i32 @llvm.some.unknown.intrinsic.i32.p1.buffer_ro_t(target("spirv.BufferSurfaceINTEL", 0))
declare i32 @llvm.some.unknown.intrinsic.i32.p1.buffer_wo_t(target("spirv.BufferSurfaceINTEL", 1))
declare i32 @llvm.some.unknown.intrinsic.i32.p1.buffer_rw_t(target("spirv.BufferSurfaceINTEL", 2))
declare i32 @llvm.some.unknown.intrinsic.i32.p1.image1d_rw_t(target("spirv.Image", void, 0, 0, 0, 0, 0, 0, 2))
declare i32 @llvm.some.unknown.intrinsic.i32.p1.image1d_buffer_wo_t(target("spirv.Image", void, 5, 0, 0, 0, 0, 0, 1))
declare i32 @llvm.some.unknown.intrinsic.i32.p1.image2d_wo_t(target("spirv.Image", void, 1, 0, 0, 0, 0, 0, 1))
declare i32 @llvm.some.unknown.intrinsic.i32.p1.image3d_ro_t(target("spirv.Image", void, 2, 0, 0, 0, 0, 0, 0))

; XFAIL:*

; CHECK-DAG: %[[#INT:]] = OpTypeInt 32 0
; CHECK-DAG: %[[#VOID:]] = OpTypeVoid
; CHECK-DAG: %[[#BUFRO:]] = OpTypeBufferSurfaceINTEL ReadOnly
; CHECK-DAG: %[[#BUFWO:]] = OpTypeBufferSurfaceINTEL WriteOnly
; CHECK-DAG: %[[#BUFRW:]] = OpTypeBufferSurfaceINTEL ReadWrite
; CHECK-DAG: %[[#IMAGE1D_RW:]] = OpTypeImage %[[#]] %[[#]] %[[#]] %[[#]] %[[#]] Unknown ReadWrite
; CHECK-DAG: %[[#IMAGE1D_BUF_WO:]] = OpTypeImage %[[#]] %[[#]] %[[#]] %[[#]] %[[#]] Unknown WriteOnly
; CHECK-DAG: %[[#IMAGE2D_WO:]] = OpTypeImage %[[#]] %[[#]] %[[#]] %[[#]] %[[#]] Unknown WriteOnly
; CHECK-DAG: %[[#IMAGE3D_RO:]] = OpTypeImage %[[#]] %[[#]] %[[#]] %[[#]] %[[#]] Unknown ReadOnly
; CHECK-DAG: %[[#BUFINTR_RO:]] = OpTypeFunction %[[#INT]] %[[#BUFRO]]
; CHECK-DAG: %[[#BUFINTR_WO:]] = OpTypeFunction %[[#INT]] %[[#BUFWO]]
; CHECK-DAG: %[[#BUFINTR_RW:]] = OpTypeFunction %[[#INT]] %[[#BUFRW]]
; CHECK-DAG: %[[#]] = OpTypeFunction %[[#INT]] %[[#IMAGE1D_RW]]
; CHECK-DAG: %[[#]] = OpTypeFunction %[[#INT]] %[[#IMAGE1D_BUF_WO]]
; CHECK-DAG: %[[#]] = OpTypeFunction %[[#INT]] %[[#IMAGE2D_WO]]
; CHECK-DAG: %[[#]] = OpTypeFunction %[[#INT]] %[[#IMAGE3D_RO]]
; CHECK-DAG: %[[#]] = OpTypeFunction %[[#VOID]] %[[#BUFRO]] %[[#BUFWO]] %[[#BUFRW]] %[[#IMAGE1D_RW]] %[[#IMAGE1D_BUF_WO]] %[[#IMAGE2D_WO]] %[[#IMAGE3D_RO]]

define spir_kernel void @test(target("spirv.BufferSurfaceINTEL", 0) %buf_ro, target("spirv.BufferSurfaceINTEL", 1) %buf_wo, target("spirv.BufferSurfaceINTEL", 2) %buf_rw, target("spirv.Image", void, 0, 0, 0, 0, 0, 0, 2) %im1d, target("spirv.Image", void, 5, 0, 0, 0, 0, 0, 1) %im1db, target("spirv.Image", void, 1, 0, 0, 0, 0, 0, 1) %im2d, target("spirv.Image", void, 2, 0, 0, 0, 0, 0, 0) %im3d) #0 {
entry:
  %0 = call i32 @llvm.some.unknown.intrinsic.i32.p1.buffer_ro_t(target("spirv.BufferSurfaceINTEL", 0) %buf_ro)
  %1 = call i32 @llvm.some.unknown.intrinsic.i32.p1.buffer_wo_t(target("spirv.BufferSurfaceINTEL", 1) %buf_wo)
  %2 = call i32 @llvm.some.unknown.intrinsic.i32.p1.buffer_rw_t(target("spirv.BufferSurfaceINTEL", 2) %buf_rw)
  %3 = call i32 @llvm.some.unknown.intrinsic.i32.p1.image1d_rw_t(target("spirv.Image", void, 0, 0, 0, 0, 0, 0, 2) %im1d)
  %4 = call i32 @llvm.some.unknown.intrinsic.i32.p1.image1d_buffer_wo_t(target("spirv.Image", void, 5, 0, 0, 0, 0, 0, 1) %im1db)
  %5 = call i32 @llvm.some.unknown.intrinsic.i32.p1.image2d_wo_t(target("spirv.Image", void, 1, 0, 0, 0, 0, 0, 1) %im2d)
  %6 = call i32 @llvm.some.unknown.intrinsic.i32.p1.image3d_ro_t(target("spirv.Image", void, 2, 0, 0, 0, 0, 0, 0) %im3d)
  ret void
}
attributes #0 = { "VCFunction" }
