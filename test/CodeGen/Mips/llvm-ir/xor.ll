; RUN: llc < %s -march=mips -mcpu=mips2 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP32
; RUN: llc < %s -march=mips -mcpu=mips32 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP32
; RUN: llc < %s -march=mips -mcpu=mips32r2 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP32
; RUN: llc < %s -march=mips -mcpu=mips32r6 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP32
; RUN: llc < %s -march=mips64 -mcpu=mips3 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP64
; RUN: llc < %s -march=mips64 -mcpu=mips4 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP64
; RUN: llc < %s -march=mips64 -mcpu=mips64 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP64
; RUN: llc < %s -march=mips64 -mcpu=mips64r2 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP64
; RUN: llc < %s -march=mips64 -mcpu=mips64r6 | FileCheck %s \
; RUN:    -check-prefix=ALL -check-prefix=GP64

define signext i1 @xor_i1(i1 signext %a, i1 signext %b) {
entry:
; ALL-LABEL: xor_i1:

  ; ALL:          xor     $2, $4, $5

  %r = xor i1 %a, %b
  ret i1 %r
}

define signext i8 @xor_i8(i8 signext %a, i8 signext %b) {
entry:
; ALL-LABEL: xor_i8:

  ; ALL:          xor     $2, $4, $5

  %r = xor i8 %a, %b
  ret i8 %r
}

define signext i16 @xor_i16(i16 signext %a, i16 signext %b) {
entry:
; ALL-LABEL: xor_i16:

  ; ALL:          xor     $2, $4, $5

  %r = xor i16 %a, %b
  ret i16 %r
}

define signext i32 @xor_i32(i32 signext %a, i32 signext %b) {
entry:
; ALL-LABEL: xor_i32:

  ; GP32:         xor     $2, $4, $5

  ; GP64:         xor     $[[T0:[0-9]+]], $4, $5
  ; GP64:         sll     $2, $[[T0]], 0

  %r = xor i32 %a, %b
  ret i32 %r
}

define signext i64 @xor_i64(i64 signext %a, i64 signext %b) {
entry:
; ALL-LABEL: xor_i64:

  ; GP32:         xor     $2, $4, $6
  ; GP32:         xor     $3, $5, $7

  ; GP64:         xor     $2, $4, $5

  %r = xor i64 %a, %b
  ret i64 %r
}
