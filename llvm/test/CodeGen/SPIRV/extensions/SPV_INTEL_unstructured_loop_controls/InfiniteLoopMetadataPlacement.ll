; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_unstructured_loop_controls --spirv-ext=+SPV_INTEL_fpga_loop_controls %s -o - | FileCheck %s

; XFAIL:*

$_ZTS12WhileOneTest = comdat any

; CHECK: OpName %[[#WH_COND:]] "while.cond"

; Function Attrs: inlinehint nounwind
define weak_odr dso_local spir_kernel void @_ZTS12WhileOneTest() #0 comdat !kernel_arg_addr_space !4 !kernel_arg_access_qual !4 !kernel_arg_type !4 !kernel_arg_base_type !4 !kernel_arg_type_qual !4 {
entry:
  %i = alloca i32, align 4
  %s = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %i) #2
  store i32 0, ptr %i, align 4, !tbaa !7
  call void @llvm.lifetime.start.p0(i64 4, ptr %s) #2
  store i32 0, ptr %s, align 4, !tbaa !7
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
; CHECK: %[[#WH_COND]] = Oplabel
; CHECK-NEXT: OpLoopControlINTEL 1
; CHECK-NEXT: OpBranch %[[#]]
  br label %while.body

while.body:                                       ; preds = %while.cond
  %0 = load i32, ptr %i, align 4, !tbaa !7
  %cmp = icmp sge i32 %0, 16
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  call spir_func void @_Z1fv() #0
  br label %while.end

if.else:                                          ; preds = %while.body
  %1 = load i32, ptr %i, align 4, !tbaa !7
  %2 = load i32, ptr %s, align 4, !tbaa !7
  %add = add nsw i32 %2, %1
  store i32 %add, ptr %s, align 4, !tbaa !7
  br label %if.end

if.end:                                           ; preds = %if.else
  %3 = load i32, ptr %i, align 4, !tbaa !7
  %inc = add nsw i32 %3, 1
  store i32 %inc, ptr %i, align 4, !tbaa !7
  br label %while.cond, !llvm.loop !9

while.end:                                        ; preds = %if.then
  call void @llvm.lifetime.end.p0(i64 4, ptr %s) #2
  call void @llvm.lifetime.end.p0(i64 4, ptr %i) #2
  ret void
}

; Function Attrs: nounwind
define spir_func void @_Z1fv() #0 {
entry:
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #1

attributes #0 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind }
!llvm.module.flags = !{!0}
!opencl.spir.version = !{!1}
!spirv.Source = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 2}
!2 = !{i32 4, i32 100000}
!3 = !{!"clang version 9.0.0"}
!4 = !{}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !5, i64 0}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.unroll.enable"}
