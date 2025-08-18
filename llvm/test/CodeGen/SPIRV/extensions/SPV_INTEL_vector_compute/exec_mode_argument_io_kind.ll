; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_vector_compute %s -o - | FileCheck %s

; XFAIL:*

; CHECK: OpName [[IBUF:[0-9]+]] "ibuf"
; CHECK: OpName [[OBUF:[0-9]+]] "obuf"
; CHECK: OpDecorate [[IBUF]] FuncParamIOKindINTEL 0
; CHECK: OpDecorate [[OBUF]] FuncParamIOKindINTEL 1

define dso_local dllexport spir_kernel void @k_rte(i32 "VCArgumentIOKind"="0" %ibuf, i32 "VCArgumentIOKind"="1" %obuf) local_unnamed_addr #1 {
entry:
  ret void
}

attributes #1 = { noinline norecurse nounwind readnone "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
!llvm.module.flags = !{!0}
!llvm.ident = !{!1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1"}
