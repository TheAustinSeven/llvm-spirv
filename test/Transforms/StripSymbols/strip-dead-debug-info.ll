; RUN: opt -strip-dead-debug-info -verify %s -S | FileCheck %s

; CHECK: ModuleID = '{{.*}}'
; CHECK-NOT: bar
; CHECK-NOT: abcd

@xyz = global i32 2

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #0

; Function Attrs: nounwind readnone ssp
define i32 @fn() #1 {
entry:
  ret i32 0, !dbg !18
}

; Function Attrs: nounwind readonly ssp
define i32 @foo(i32 %i) #2 {
entry:
  tail call void @llvm.dbg.value(metadata i32 %i, i64 0, metadata !15, metadata !MDExpression()), !dbg !20
  %.0 = load i32, i32* @xyz, align 4
  ret i32 %.0, !dbg !21
}

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readnone ssp }
attributes #2 = { nounwind readonly ssp }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!25}

!0 = !MDCompileUnit(language: DW_LANG_C89, producer: "4.2.1 (Based on Apple Inc. build 5658) (LLVM build)", isOptimized: true, emissionKind: 1, file: !1, enums: !2, retainedTypes: !2, subprograms: !23, globals: !24)
!1 = !MDFile(filename: "g.c", directory: "/tmp/")
!2 = !{null}
!3 = !MDSubprogram(name: "bar", line: 5, isLocal: true, isDefinition: true, virtualIndex: 6, isOptimized: true, file: !1, scope: null, type: !4)
!4 = !MDSubroutineType(types: !2)
!5 = !MDFile(filename: "g.c", directory: "/tmp/")
!6 = !MDSubprogram(name: "fn", linkageName: "fn", line: 6, isLocal: false, isDefinition: true, virtualIndex: 6, isOptimized: true, file: !1, scope: null, type: !7, function: i32 ()* @fn)
!7 = !MDSubroutineType(types: !8)
!8 = !{!9}
!9 = !MDBasicType(tag: DW_TAG_base_type, name: "int", size: 32, align: 32, encoding: DW_ATE_signed)
!10 = !MDSubprogram(name: "foo", linkageName: "foo", line: 7, isLocal: false, isDefinition: true, virtualIndex: 6, isOptimized: true, file: !1, scope: null, type: !11, function: i32 (i32)* @foo)
!11 = !MDSubroutineType(types: !12)
!12 = !{!9, !9}
!13 = !MDLocalVariable(tag: DW_TAG_auto_variable, name: "bb", line: 5, scope: !14, file: !5, type: !9)
!14 = distinct !MDLexicalBlock(line: 5, column: 0, file: !1, scope: !3)
!15 = !MDLocalVariable(tag: DW_TAG_arg_variable, name: "i", line: 7, arg: 0, scope: !10, file: !5, type: !9)
!16 = !MDGlobalVariable(name: "abcd", line: 2, isLocal: true, isDefinition: true, scope: !5, file: !5, type: !9)
!17 = !MDGlobalVariable(name: "xyz", line: 3, isLocal: false, isDefinition: true, scope: !5, file: !5, type: !9, variable: i32* @xyz)
!18 = !MDLocation(line: 6, scope: !19)
!19 = distinct !MDLexicalBlock(line: 6, column: 0, file: !1, scope: !6)
!20 = !MDLocation(line: 7, scope: !10)
!21 = !MDLocation(line: 10, scope: !22)
!22 = distinct !MDLexicalBlock(line: 7, column: 0, file: !1, scope: !10)
!23 = !{!3, !6, !10}
!24 = !{!16, !17}
!25 = !{i32 1, !"Debug Info Version", i32 3}
