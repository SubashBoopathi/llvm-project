; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_vector_compute %s -o - | FileCheck %s
; XFAIL:*

; CHECK: OpExtInstImport "OpenCL.std"
; CHECK: %[[#ExtInstSetId:]] = OpExtInstImport "OpenCL.std"
; CHECK: %[[#Float:]] = OpTypeFloat 32
; CHECK: %[[#Float5:]] = OpTypeVector [[Float]] 5

@Id = external dso_local local_unnamed_addr addrspace(1) constant <3 x i64>, align 32

declare <5 x float> @llvm.sqrt.f32(<5 x float> %x)

; Function Attrs: convergent norecurse
define dso_local spir_func <5 x float> @test_sqrt(<5 x float> %src) local_unnamed_addr #0 !sycl_explicit_simd !4 !intel_reqd_sub_group_size !6 {
entry:
  %res = call <5 x float> @llvm.sqrt.f32(<5 x float> %src)
; CHECK: ExtInst [[Float5]] {{[0-9]+}} [[ExtInstSetId]] sqrt
  ret <5 x float> %res
}

attributes #0 = { convergent norecurse "frame-pointer"="all" "min-legal-vector-width"="256" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "sycl-module-id"="lower-external-funcs-with-z.cpp" }

!llvm.module.flags = !{!0, !1}
!opencl.spir.version = !{!2}
!spirv.Source = !{!3}
!opencl.used.extensions = !{!4}
!opencl.used.optional.core.features = !{!4}
!opencl.compiler.options = !{!4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"frame-pointer", i32 2}
!2 = !{i32 1, i32 2}
!3 = !{i32 0, i32 100000}
!4 = !{}
!5 = !{!"Compiler"}
!6 = !{i32 1}
