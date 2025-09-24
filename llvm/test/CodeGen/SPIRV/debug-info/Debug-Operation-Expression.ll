; RUN: llc --verify-machineinstrs --spv-emit-nonsemantic-debug-info --spirv-ext=+SPV_KHR_non_semantic_info --print-after=spirv-nonsemantic-debug-info -O0 -mtriple=spirv64-unknown-unknown %s -o - 2>&1 | FileCheck %s --check-prefix=CHECK-MIR
; RUN: llc --verify-machineinstrs --spv-emit-nonsemantic-debug-info --spirv-ext=+SPV_KHR_non_semantic_info -O0 -mtriple=spirv64-unknown-unknown %s -o - | FileCheck %s --check-prefix=CHECK-SPIRV
; RUN: llc --verify-machineinstrs -O0 -mtriple=spirv64-unknown-unknown --spirv-ext=+SPV_KHR_non_semantic_info %s -o - | FileCheck %s --check-prefix=CHECK-OPTION
; RUN: %if spirv-tools %{ llc --verify-machineinstrs --spv-emit-nonsemantic-debug-info --spirv-ext=+SPV_KHR_non_semantic_info -O0 -mtriple=spirv64-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; CHECK-MIR-DAG: [[i32type:%[0-9]+\:type]] = OpTypeInt 32, 0
; CHECK-MIR-DAG: [[void_type:%[0-9]+\:type]] = OpTypeVoid
; CHECK-MIR-DAG: [[i32_0:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 0
; CHECK-MIR-DAG: [[i32_1:%[0-9]+\:iid]] = OpConstantI [[i32type]], 1
; CHECK-MIR-DAG: [[i32_2:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 2
; CHECK-MIR-DAG: [[i32_3:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 3
; CHECK-MIR-DAG: [[i32_4:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 4
; CHECK-MIR-DAG: [[i32_5:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 5
; CHECK-MIR-DAG: [[i32_6:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 6
; CHECK-MIR-DAG: [[i32_7:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 7
; CHECK-MIR-DAG: [[i32_8:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 8
; CHECK-MIR-DAG: [[i32_9:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 9
; CHECK-MIR-DAG: [[i32_12:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 12
; CHECK-MIR-DAG: [[i32_20:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 20
; CHECK-MIR-DAG: [[i32_32:%[0-9]+\:iid(\(s32\))?]] = OpConstantI [[i32type]], 32
; CHECK-MIR: [[op_constu_8:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_8]], [[i32_8]]
; CHECK-MIR: [[op_stack_value:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_7]]
; CHECK-MIR: [[expr_constu_stack_value:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 31, [[op_constu_8]], [[op_stack_value]]
; CHECK-MIR: [[op_deref:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_0]]
; CHECK-MIR: [[expr_deref:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 31, [[op_deref]]
; CHECK-MIR: [[op_plus:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_1]]
; CHECK-MIR: [[expr_plus:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 31, [[op_plus]]
; CHECK-MIR: [[op_minus:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_2]]
; CHECK-MIR: [[expr_minus:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 31, [[op_minus]]
; CHECK-MIR: [[op_xderef:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_6]]
; CHECK-MIR: [[expr_xderef:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 31, [[op_xderef]]
; CHECK-MIR: [[op_constu_20:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_8]], [[i32_20]]
; CHECK-MIR: [[op_swap:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_5]]
; CHECK-MIR: [[expr_constu_swap:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 31, [[op_constu_20]], [[op_swap]]
; CHECK-MIR: [[op_plus_uconst_8:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_3]], [[i32_8]]
; CHECK-MIR: [[op_stack_value1:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_7]]
; CHECK-MIR: [[expr_plus_uconst_stack_value:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 31, [[op_plus_uconst_8]], [[op_stack_value1]]
; CHECK-MIR-DAG: [[op_fragment:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 30, [[i32_9]], [[i32_4]], [[i32_12]]
; CHECK-MIR-DAG: [[expr_fragment:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 31, [[op_fragment]]

; CHECK-SPIRV: [[i32type:%[0-9]+]] = OpTypeInt 32 0
; CHECK-SPIRV: [[void_type:%[0-9]+]] = OpTypeVoid
; CHECK-SPIRV-DAG: [[i32_0:%[0-9]+]] = OpConstant [[i32type]] 0
; CHECK-SPIRV-DAG: [[i32_1:%[0-9]+]] = OpConstant [[i32type]] 1
; CHECK-SPIRV-DAG: [[i32_2:%[0-9]+]] = OpConstant [[i32type]] 2
; CHECK-SPIRV-DAG: [[i32_3:%[0-9]+]] = OpConstant [[i32type]] 3
; CHECK-SPIRV-DAG: [[i32_4:%[0-9]+]] = OpConstant [[i32type]] 4
; CHECK-SPIRV-DAG: [[i32_5:%[0-9]+]] = OpConstant [[i32type]] 5
; CHECK-SPIRV-DAG: [[i32_6:%[0-9]+]] = OpConstant [[i32type]] 6
; CHECK-SPIRV-DAG: [[i32_7:%[0-9]+]] = OpConstant [[i32type]] 7
; CHECK-SPIRV-DAG: [[i32_8:%[0-9]+]] = OpConstant [[i32type]] 8
; CHECK-SPIRV-DAG: [[i32_9:%[0-9]+]] = OpConstant [[i32type]] 9
; CHECK-SPIRV-DAG: [[i32_12:%[0-9]+]] = OpConstant [[i32type]] 12
; CHECK-SPIRV-DAG: [[i32_20:%[0-9]+]] = OpConstant [[i32type]] 20
; CHECK-SPIRV-DAG: [[i32_32:%[0-9]+]] = OpConstant [[i32type]] 32
; CHECK-SPIRV-DAG: [[op_constu_8:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_8]] [[i32_8]]
; CHECK-SPIRV-DAG: [[op_constu_20:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_8]] [[i32_20]]
; CHECK-SPIRV-DAG: [[op_deref:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_0]]
; CHECK-SPIRV-DAG: [[op_plus:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_1]]
; CHECK-SPIRV-DAG: [[op_minus:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_2]]
; CHECK-SPIRV-DAG: [[op_plus_uconst_8:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_3]] [[i32_8]]
; CHECK-SPIRV-DAG: [[op_swap:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_5]]
; CHECK-SPIRV-DAG: [[op_xderef:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_6]]
; CHECK-SPIRV-DAG: [[op_stack_value:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_7]]
; CHECK-SPIRV-DAG: [[op_fragment:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_9]] [[i32_4]] [[i32_12]]
; CHECK-SPIRV-DAG: [[expr_constu_stack_value:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugExpression [[op_constu_8]] [[op_stack_value]]
; CHECK-SPIRV-DAG: [[expr_deref:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugExpression [[op_deref]]
; CHECK-SPIRV-DAG: [[expr_plus:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugExpression [[op_plus]]
; CHECK-SPIRV-DAG: [[expr_minus:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugExpression [[op_minus]]
; CHECK-SPIRV-DAG: [[expr_xderef:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugExpression [[op_xderef]]
; CHECK-SPIRV-DAG: [[expr_constu_swap:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugExpression [[op_constu_20]] [[op_swap]]
; CHECK-SPIRV-DAG: [[op_stack_value1:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugOperation [[i32_7]]
; CHECK-SPIRV-DAG: [[expr_plus_uconst_stack_value:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugExpression [[op_plus_uconst_8]] [[op_stack_value1]]
; CHECK-SPIRV-DAG: [[expr_fragment:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugExpression [[op_fragment]]
; CHECK-SPIRV-DAG: [[int:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugTypeBasic {{%[0-9]+}} [[i32_32]] [[i32_4]] [[i32_0]]

; CHECK-OPTION-NOT: DebugOperation
; CHECK-OPTION-NOT: DebugExpression
; CHECK-OPTION-NOT: DebugTypeBasic
; CHECK-OPTION-NOT: DebugTypePointer

define spir_func void @test(i32 %arg) !dbg !6 {
entry:
  %local = add i32 %arg, 1, !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_constu, 8, DW_OP_stack_value)), !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_deref)), !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_plus)), !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_minus)), !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_xderef)), !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_constu, 20, DW_OP_swap)), !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_LLVM_fragment, 4, 12)), !dbg !15
  call void @llvm.dbg.value(metadata i32 %local, metadata !14, metadata !DIExpression(DW_OP_bit_piece, 4, 12)), !dbg !15
  ret void
}

declare void @llvm.dbg.value(metadata, metadata, metadata) #0

attributes #0 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}

!0 = distinct !DICompileUnit(language: DW_LANG_SYCL, file: !1, producer: "clang version 18.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example.c", directory: "/dir", checksumkind: CSK_MD5, checksum: "0123456789abcdef0123456789abcdef")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 1, type: !7, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0)
!7 = !DISubroutineType(types: !8)
!8 = !{null, !9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocalVariable(name: "local", scope: !6, file: !1, line: 2, type: !9)
!15 = !DILocation(line: 2, column: 5, scope: !6)
