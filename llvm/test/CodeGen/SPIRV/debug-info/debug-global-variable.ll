; RUN: llc --verify-machineinstrs --spv-emit-nonsemantic-debug-info --spirv-ext=+SPV_KHR_non_semantic_info --print-after=spirv-nonsemantic-debug-info -O0 -mtriple=spirv64-unknown-unknown %s -o - 2>&1 | FileCheck %s --check-prefix=CHECK-MIR
; RUN: llc --verify-machineinstrs --spv-emit-nonsemantic-debug-info --spirv-ext=+SPV_KHR_non_semantic_info -O0 -mtriple=spirv64-unknown-unknown %s -o - | FileCheck %s --check-prefix=CHECK-SPIRV
; RUN: llc --verify-machineinstrs -O0 -mtriple=spirv64-unknown-unknown --spirv-ext=+SPV_KHR_non_semantic_info %s -o - | FileCheck %s --check-prefix=CHECK-OPTION
; RUN: %if spirv-tools %{ llc --verify-machineinstrs --spv-emit-nonsemantic-debug-info --spirv-ext=+SPV_KHR_non_semantic_info -O0 -mtriple=spirv64-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; CHECK-MIR-DAG: [[i32type:%[0-9]+\:type]] = OpTypeInt 32, 0
; CHECK-MIR-DAG: [[void_type:%[0-9]+\:type\(s64\)]] = OpTypeVoid
; CHECK-MIR-DAG: [[func_type:%[0-9]+\:type]] = OpTypeFunction [[i32type]]
; CHECK-MIR-DAG: [[ptr_type:%[0-9]+\:type]] = OpTypePointer 7, [[i32type]]
; CHECK-MIR-DAG: [[i32_0:%[0-9]+\:iid]] = OpConstantNull [[i32type]]
; CHECK-MIR-DAG: [[i32_1:%[0-9]+\:iid\(s32\)]] = OpConstantI [[i32type]], 1
; CHECK-MIR-DAG: [[i32_3:%[0-9]+\:iid\(s32\)]] = OpConstantI [[i32type]], 3
; CHECK-MIR-DAG: [[i32_4:%[0-9]+\:iid\(s32\)]] = OpConstantI [[i32type]], 4
; CHECK-MIR-DAG: [[i32_5:%[0-9]+\:iid\(s32\)]] = OpConstantI [[i32type]], 5
; CHECK-MIR-DAG: [[i32_8:%[0-9]+\:iid\(s32\)]] = OpConstantI [[i32type]], 8
; CHECK-MIR-DAG: [[i32_12:%[0-9]+\:iid\(s32\)]] = OpConstantI [[i32type]], 12
; CHECK-MIR-DAG: [[i32_32:%[0-9]+\:iid\(s32\)]] = OpConstantI [[i32type]], 32
; CHECK-MIR-DAG: [[i32_42:%[0-9]+\:iid]] = OpConstantI [[i32type]], 42
; CHECK-MIR-DAG: [[string_file:%[0-9]+\:id\(s32\)]] = OpString 1886221359, 1869375279, 778854754, 7368803
; CHECK-MIR-DAG: [[debug_source:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 35, [[string_file]]
; CHECK-MIR-DAG: [[string_int:%[0-9]+\:id\(s32\)]] = OpString 7630441
; CHECK-MIR-DAG: [[string_global_var:%[0-9]+\:id\(s32\)]] = OpString 1651469415, 1633053793, 114
; CHECK-MIR-DAG: [[string_empty:%[0-9]+\:id\(s32\)]] = OpString 0
; CHECK-MIR-DAG: [[debug_comp_unit:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 1, [[i32_3]], [[i32_5]], [[debug_source]], [[i32_12]]
; CHECK-MIR-DAG: [[debug_type_basic:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 2, [[string_int]], [[i32_32]], [[i32_4]], [[i32_3]]
; CHECK-MIR-DAG: [[debug_info_none:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 0
; CHECK-MIR-DAG: [[debug_global_var:%[0-9]+\:id\(s32\)]] = OpExtInst [[void_type]], 3, 18, [[string_global_var]], [[debug_type_basic]], [[debug_source]], [[i32_1]], [[i32_1]], [[debug_comp_unit]], [[string_empty]], [[debug_info_none]], [[i32_8]]

; CHECK-SPIRV-DAG: [[i32type:%[0-9]+]] = OpTypeInt 32 0
; CHECK-SPIRV-DAG: [[void_type:%[0-9]+]] = OpTypeVoid
; CHECK-SPIRV-DAG: [[func_type:%[0-9]+]] = OpTypeFunction [[i32type]]
; CHECK-SPIRV-DAG: [[ptr_type:%[0-9]+]] = OpTypePointer Function [[i32type]]
; CHECK-SPIRV-DAG: [[i32_0:%[0-9]+]] = OpConstantNull [[i32type]]
; CHECK-SPIRV-DAG: [[i32_1:%[0-9]+]] = OpConstant [[i32type]] 1
; CHECK-SPIRV-DAG: [[i32_3:%[0-9]+]] = OpConstant [[i32type]] 3
; CHECK-SPIRV-DAG: [[i32_42:%[0-9]+]] = OpConstant [[i32type]] 42
; CHECK-SPIRV-DAG: [[i32_4:%[0-9]+]] = OpConstant [[i32type]] 4
; CHECK-SPIRV-DAG: [[i32_5:%[0-9]+]] = OpConstant [[i32type]] 5
; CHECK-SPIRV-DAG: [[i32_8:%[0-9]+]] = OpConstant [[i32type]] 8
; CHECK-SPIRV-DAG: [[i32_12:%[0-9]+]] = OpConstant [[i32type]] 12
; CHECK-SPIRV-DAG: [[i32_32:%[0-9]+]] = OpConstant [[i32type]] 32
; CHECK-SPIRV-DAG: [[string_file:%[0-9]+]] = OpString "/tmp/global.cpp"
; CHECK-SPIRV-DAG: [[string_int:%[0-9]+]] = OpString "int"
; CHECK-SPIRV-DAG: [[string_global_var:%[0-9]+]] = OpString "globalVar"
; CHECK-SPIRV-DAG: [[string_empty:%[0-9]+]] = OpString ""
; CHECK-SPIRV-DAG: [[debug_source:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugSource [[string_file]]
; CHECK-SPIRV-DAG: [[debug_comp_unit:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugCompilationUnit [[i32_3]] [[i32_5]] [[debug_source]] [[i32_12]]
; CHECK-SPIRV-DAG: [[debug_type_basic:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugTypeBasic [[string_int]] [[i32_32]] [[i32_4]] [[i32_3]]
; CHECK-SPIRV-DAG: [[debug_info_none:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugInfoNone
; CHECK-SPIRV-DAG: [[debug_global_var:%[0-9]+]] = OpExtInst [[void_type]] {{%[0-9]+}} DebugGlobalVariable [[string_global_var]] [[debug_type_basic]] [[debug_source]] [[i32_1]] [[i32_1]] [[debug_comp_unit]] [[string_empty]] [[debug_info_none]] [[i32_8]]

; CHECK-OPTION-NOT: DebugSource
; CHECK-OPTION-NOT: DebugCompilationUnit
; CHECK-OPTION-NOT: DebugTypeBasic
; CHECK-OPTION-NOT: DebugGlobalVariable

@globalVar = dso_local global i32 42, align 4, !dbg !0

define dso_local noundef i32 @main() !dbg !14 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %0 = load i32, ptr @globalVar, align 4, !dbg !17
  ret i32 %0, !dbg !18
}

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!6, !7, !8, !9, !10, !11, !12}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "globalVar", scope: !2, file: !3, line: 1, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_Zig, file: !3, producer: "clang version XX.X" , isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "global.cpp", directory: "/tmp")
!4 = !{!0}
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed, flags: DIFlagPublic)
!6 = !{i32 7, !"Dwarf Version", i32 5}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{i32 8, !"PIC Level", i32 2}
!10 = !{i32 7, !"PIE Level", i32 2}
!11 = !{i32 7, !"uwtable", i32 2}
!12 = !{i32 7, !"frame-pointer", i32 2}
!14 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 3, type: !15, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{!5}
!17 = !DILocation(line: 4, column: 10, scope: !14)
!18 = !DILocation(line: 4, column: 3, scope: !14)
