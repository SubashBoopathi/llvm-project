; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_vector_compute %s -o - | FileCheck %s

; CHECK-DAG: OpName [[IN:[0-9]+]] "in"
; CHECK-DAG: OpDecorate [[IN]] GlobalVariableOffsetINTEL 1 

@in = internal global <256 x i8> undef, align 256 #0
declare <256 x i8> @llvm.genx.vload(ptr nonnull %aaa)

; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport spir_kernel void @k_rte(i32 %ibuf, i32 %obuf) local_unnamed_addr #1 {
entry:
  %gload53 = tail call <256 x i8> @llvm.genx.vload(ptr nonnull @in)
  ret void
}

attributes #0 = { "VCByteOffset"="1" "VCVolatile" "VCGlobalVariable" }
attributes #1 = { noinline norecurse nounwind readnone "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1"}
