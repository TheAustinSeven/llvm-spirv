; RUN: opt < %s -instcombine -S | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define <2 x i64> @test_sse2_1() nounwind readnone uwtable {
  %S = bitcast i32 1 to i32
  %1 = zext i32 %S to i64
  %2 = insertelement <2 x i64> undef, i64 %1, i32 0
  %3 = insertelement <2 x i64> %2, i64 0, i32 1
  %4 = bitcast <2 x i64> %3 to <8 x i16>
  %5 = tail call <8 x i16> @llvm.x86.sse2.psll.w(<8 x i16> <i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8>, <8 x i16> %4)
  %6 = bitcast <8 x i16> %5 to <4 x i32>
  %7 = bitcast <2 x i64> %3 to <4 x i32>
  %8 = tail call <4 x i32> @llvm.x86.sse2.psll.d(<4 x i32> %6, <4 x i32> %7)
  %9 = bitcast <4 x i32> %8 to <2 x i64>
  %10 = tail call <2 x i64> @llvm.x86.sse2.psll.q(<2 x i64> %9, <2 x i64> %3)
  %11 = bitcast <2 x i64> %10 to <8 x i16>
  %12 = tail call <8 x i16> @llvm.x86.sse2.pslli.w(<8 x i16> %11, i32 %S)
  %13 = bitcast <8 x i16> %12 to <4 x i32>
  %14 = tail call <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32> %13, i32 %S)
  %15 = bitcast <4 x i32> %14 to <2 x i64>
  %16 = tail call <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64> %15, i32 %S)
  ret <2 x i64> %16
; CHECK: test_sse2_1
; CHECK: ret <2 x i64> <i64 72058418680037440, i64 144117112246370624>
}

define <4 x i64> @test_avx2_1() nounwind readnone uwtable {
  %S = bitcast i32 1 to i32
  %1 = zext i32 %S to i64
  %2 = insertelement <2 x i64> undef, i64 %1, i32 0
  %3 = insertelement <2 x i64> %2, i64 0, i32 1
  %4 = bitcast <2 x i64> %3 to <8 x i16>
  %5 = tail call <16 x i16> @llvm.x86.avx2.psll.w(<16 x i16> <i16 1, i16 0, i16 0, i16 0, i16 2, i16 0, i16 0, i16 0, i16 3, i16 0, i16 0, i16 0, i16 4, i16 0, i16 0, i16 0>, <8 x i16> %4)
  %6 = bitcast <16 x i16> %5 to <8 x i32>
  %7 = bitcast <2 x i64> %3 to <4 x i32>
  %8 = tail call <8 x i32> @llvm.x86.avx2.psll.d(<8 x i32> %6, <4 x i32> %7)
  %9 = bitcast <8 x i32> %8 to <4 x i64>
  %10 = tail call <4 x i64> @llvm.x86.avx2.psll.q(<4 x i64> %9, <2 x i64> %3)
  %11 = bitcast <4 x i64> %10 to <16 x i16>
  %12 = tail call <16 x i16> @llvm.x86.avx2.pslli.w(<16 x i16> %11, i32 %S)
  %13 = bitcast <16 x i16> %12 to <8 x i32>
  %14 = tail call <8 x i32> @llvm.x86.avx2.pslli.d(<8 x i32> %13, i32 %S)
  %15 = bitcast <8 x i32> %14 to <4 x i64>
  %16 = tail call <4 x i64> @llvm.x86.avx2.pslli.q(<4 x i64> %15, i32 %S)
  ret <4 x i64> %16
; CHECK: test_avx2_1
; CHECK: ret <4 x i64> <i64 64, i64 128, i64 192, i64 256>
}

define <2 x i64> @test_sse2_0() nounwind readnone uwtable {
  %S = bitcast i32 128 to i32
  %1 = zext i32 %S to i64
  %2 = insertelement <2 x i64> undef, i64 %1, i32 0
  %3 = insertelement <2 x i64> %2, i64 0, i32 1
  %4 = bitcast <2 x i64> %3 to <8 x i16>
  %5 = tail call <8 x i16> @llvm.x86.sse2.psll.w(<8 x i16> <i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8>, <8 x i16> %4)
  %6 = bitcast <8 x i16> %5 to <4 x i32>
  %7 = bitcast <2 x i64> %3 to <4 x i32>
  %8 = tail call <4 x i32> @llvm.x86.sse2.psll.d(<4 x i32> %6, <4 x i32> %7)
  %9 = bitcast <4 x i32> %8 to <2 x i64>
  %10 = tail call <2 x i64> @llvm.x86.sse2.psll.q(<2 x i64> %9, <2 x i64> %3)
  %11 = bitcast <2 x i64> %10 to <8 x i16>
  %12 = tail call <8 x i16> @llvm.x86.sse2.pslli.w(<8 x i16> %11, i32 %S)
  %13 = bitcast <8 x i16> %12 to <4 x i32>
  %14 = tail call <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32> %13, i32 %S)
  %15 = bitcast <4 x i32> %14 to <2 x i64>
  %16 = tail call <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64> %15, i32 %S)
  ret <2 x i64> %16
; CHECK: test_sse2_0
; CHECK: ret <2 x i64> zeroinitializer
}

define <4 x i64> @test_avx2_0() nounwind readnone uwtable {
  %S = bitcast i32 128 to i32
  %1 = zext i32 %S to i64
  %2 = insertelement <2 x i64> undef, i64 %1, i32 0
  %3 = insertelement <2 x i64> %2, i64 0, i32 1
  %4 = bitcast <2 x i64> %3 to <8 x i16>
  %5 = tail call <16 x i16> @llvm.x86.avx2.psll.w(<16 x i16> <i16 1, i16 0, i16 0, i16 0, i16 2, i16 0, i16 0, i16 0, i16 3, i16 0, i16 0, i16 0, i16 4, i16 0, i16 0, i16 0>, <8 x i16> %4)
  %6 = bitcast <16 x i16> %5 to <8 x i32>
  %7 = bitcast <2 x i64> %3 to <4 x i32>
  %8 = tail call <8 x i32> @llvm.x86.avx2.psll.d(<8 x i32> %6, <4 x i32> %7)
  %9 = bitcast <8 x i32> %8 to <4 x i64>
  %10 = tail call <4 x i64> @llvm.x86.avx2.psll.q(<4 x i64> %9, <2 x i64> %3)
  %11 = bitcast <4 x i64> %10 to <16 x i16>
  %12 = tail call <16 x i16> @llvm.x86.avx2.pslli.w(<16 x i16> %11, i32 %S)
  %13 = bitcast <16 x i16> %12 to <8 x i32>
  %14 = tail call <8 x i32> @llvm.x86.avx2.pslli.d(<8 x i32> %13, i32 %S)
  %15 = bitcast <8 x i32> %14 to <4 x i64>
  %16 = tail call <4 x i64> @llvm.x86.avx2.pslli.q(<4 x i64> %15, i32 %S)
  ret <4 x i64> %16
; CHECK: test_avx2_0
; CHECK: ret <4 x i64> zeroinitializer
}
define <2 x i64> @test_sse2_psrl_1() nounwind readnone uwtable {
  %S = bitcast i32 1 to i32
  %1 = zext i32 %S to i64
  %2 = insertelement <2 x i64> undef, i64 %1, i32 0
  %3 = insertelement <2 x i64> %2, i64 0, i32 1
  %4 = bitcast <2 x i64> %3 to <8 x i16>
  %5 = tail call <8 x i16> @llvm.x86.sse2.psrl.w(<8 x i16> <i16 16, i16 32, i16 64, i16 128, i16 256, i16 512, i16 1024, i16 2048>, <8 x i16> %4)
  %6 = bitcast <8 x i16> %5 to <4 x i32>
  %7 = bitcast <2 x i64> %3 to <4 x i32>
  %8 = tail call <4 x i32> @llvm.x86.sse2.psrl.d(<4 x i32> %6, <4 x i32> %7)
  %9 = bitcast <4 x i32> %8 to <2 x i64>
  %10 = tail call <2 x i64> @llvm.x86.sse2.psrl.q(<2 x i64> %9, <2 x i64> %3)
  %11 = bitcast <2 x i64> %10 to <8 x i16>
  %12 = tail call <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16> %11, i32 %S)
  %13 = bitcast <8 x i16> %12 to <4 x i32>
  %14 = tail call <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32> %13, i32 %S)
  %15 = bitcast <4 x i32> %14 to <2 x i64>
  %16 = tail call <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64> %15, i32 %S)
  ret <2 x i64> %16
; CHECK: test_sse2_psrl_1
; CHECK: ret <2 x i64> <i64 562954248421376, i64 9007267974742020>
}

define <4 x i64> @test_avx2_psrl_1() nounwind readnone uwtable {
  %S = bitcast i32 1 to i32
  %1 = zext i32 %S to i64
  %2 = insertelement <2 x i64> undef, i64 %1, i32 0
  %3 = insertelement <2 x i64> %2, i64 0, i32 1
  %4 = bitcast <2 x i64> %3 to <8 x i16>
  %5 = tail call <16 x i16> @llvm.x86.avx2.psrl.w(<16 x i16> <i16 1024, i16 0, i16 0, i16 0, i16 2048, i16 0, i16 0, i16 0, i16 4096, i16 0, i16 0, i16 0, i16 8192, i16 0, i16 0, i16 0>, <8 x i16> %4)
  %6 = bitcast <16 x i16> %5 to <8 x i32>
  %7 = bitcast <2 x i64> %3 to <4 x i32>
  %8 = tail call <8 x i32> @llvm.x86.avx2.psrl.d(<8 x i32> %6, <4 x i32> %7)
  %9 = bitcast <8 x i32> %8 to <4 x i64>
  %10 = tail call <4 x i64> @llvm.x86.avx2.psrl.q(<4 x i64> %9, <2 x i64> %3)
  %11 = bitcast <4 x i64> %10 to <16 x i16>
  %12 = tail call <16 x i16> @llvm.x86.avx2.psrli.w(<16 x i16> %11, i32 %S)
  %13 = bitcast <16 x i16> %12 to <8 x i32>
  %14 = tail call <8 x i32> @llvm.x86.avx2.psrli.d(<8 x i32> %13, i32 %S)
  %15 = bitcast <8 x i32> %14 to <4 x i64>
  %16 = tail call <4 x i64> @llvm.x86.avx2.psrli.q(<4 x i64> %15, i32 %S)
  ret <4 x i64> %16
; CHECK: test_avx2_psrl_1
; CHECK: ret <4 x i64> <i64 16, i64 32, i64 64, i64 128>
}

define <2 x i64> @test_sse2_psrl_0() nounwind readnone uwtable {
  %S = bitcast i32 128 to i32
  %1 = zext i32 %S to i64
  %2 = insertelement <2 x i64> undef, i64 %1, i32 0
  %3 = insertelement <2 x i64> %2, i64 0, i32 1
  %4 = bitcast <2 x i64> %3 to <8 x i16>
  %5 = tail call <8 x i16> @llvm.x86.sse2.psrl.w(<8 x i16> <i16 32, i16 64, i16 128, i16 256, i16 512, i16 1024, i16 2048, i16 4096>, <8 x i16> %4)
  %6 = bitcast <8 x i16> %5 to <4 x i32>
  %7 = bitcast <2 x i64> %3 to <4 x i32>
  %8 = tail call <4 x i32> @llvm.x86.sse2.psrl.d(<4 x i32> %6, <4 x i32> %7)
  %9 = bitcast <4 x i32> %8 to <2 x i64>
  %10 = tail call <2 x i64> @llvm.x86.sse2.psrl.q(<2 x i64> %9, <2 x i64> %3)
  %11 = bitcast <2 x i64> %10 to <8 x i16>
  %12 = tail call <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16> %11, i32 %S)
  %13 = bitcast <8 x i16> %12 to <4 x i32>
  %14 = tail call <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32> %13, i32 %S)
  %15 = bitcast <4 x i32> %14 to <2 x i64>
  %16 = tail call <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64> %15, i32 %S)
  ret <2 x i64> %16
; CHECK: test_sse2_psrl_0
; CHECK: ret <2 x i64> zeroinitializer
}

define <4 x i64> @test_avx2_psrl_0() nounwind readnone uwtable {
  %S = bitcast i32 128 to i32
  %1 = zext i32 %S to i64
  %2 = insertelement <2 x i64> undef, i64 %1, i32 0
  %3 = insertelement <2 x i64> %2, i64 0, i32 1
  %4 = bitcast <2 x i64> %3 to <8 x i16>
  %5 = tail call <16 x i16> @llvm.x86.avx2.psrl.w(<16 x i16> <i16 1024, i16 0, i16 0, i16 0, i16 2048, i16 0, i16 0, i16 0, i16 4096, i16 0, i16 0, i16 0, i16 8192, i16 0, i16 0, i16 0>, <8 x i16> %4)
  %6 = bitcast <16 x i16> %5 to <8 x i32>
  %7 = bitcast <2 x i64> %3 to <4 x i32>
  %8 = tail call <8 x i32> @llvm.x86.avx2.psrl.d(<8 x i32> %6, <4 x i32> %7)
  %9 = bitcast <8 x i32> %8 to <4 x i64>
  %10 = tail call <4 x i64> @llvm.x86.avx2.psrl.q(<4 x i64> %9, <2 x i64> %3)
  %11 = bitcast <4 x i64> %10 to <16 x i16>
  %12 = tail call <16 x i16> @llvm.x86.avx2.psrli.w(<16 x i16> %11, i32 %S)
  %13 = bitcast <16 x i16> %12 to <8 x i32>
  %14 = tail call <8 x i32> @llvm.x86.avx2.psrli.d(<8 x i32> %13, i32 %S)
  %15 = bitcast <8 x i32> %14 to <4 x i64>
  %16 = tail call <4 x i64> @llvm.x86.avx2.psrli.q(<4 x i64> %15, i32 %S)
  ret <4 x i64> %16
; CHECK: test_avx2_psrl_0
; CHECK: ret <4 x i64> zeroinitializer
}

declare <4 x i64> @llvm.x86.avx2.pslli.q(<4 x i64>, i32) #1
declare <8 x i32> @llvm.x86.avx2.pslli.d(<8 x i32>, i32) #1
declare <16 x i16> @llvm.x86.avx2.pslli.w(<16 x i16>, i32) #1
declare <4 x i64> @llvm.x86.avx2.psll.q(<4 x i64>, <2 x i64>) #1
declare <8 x i32> @llvm.x86.avx2.psll.d(<8 x i32>, <4 x i32>) #1
declare <16 x i16> @llvm.x86.avx2.psll.w(<16 x i16>, <8 x i16>) #1
declare <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64>, i32) #1
declare <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32>, i32) #1
declare <8 x i16> @llvm.x86.sse2.pslli.w(<8 x i16>, i32) #1
declare <2 x i64> @llvm.x86.sse2.psll.q(<2 x i64>, <2 x i64>) #1
declare <4 x i32> @llvm.x86.sse2.psll.d(<4 x i32>, <4 x i32>) #1
declare <8 x i16> @llvm.x86.sse2.psll.w(<8 x i16>, <8 x i16>) #1
declare <4 x i64> @llvm.x86.avx2.psrli.q(<4 x i64>, i32) #1
declare <8 x i32> @llvm.x86.avx2.psrli.d(<8 x i32>, i32) #1
declare <16 x i16> @llvm.x86.avx2.psrli.w(<16 x i16>, i32) #1
declare <4 x i64> @llvm.x86.avx2.psrl.q(<4 x i64>, <2 x i64>) #1
declare <8 x i32> @llvm.x86.avx2.psrl.d(<8 x i32>, <4 x i32>) #1
declare <16 x i16> @llvm.x86.avx2.psrl.w(<16 x i16>, <8 x i16>) #1
declare <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64>, i32) #1
declare <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32>, i32) #1
declare <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16>, i32) #1
declare <2 x i64> @llvm.x86.sse2.psrl.q(<2 x i64>, <2 x i64>) #1
declare <4 x i32> @llvm.x86.sse2.psrl.d(<4 x i32>, <4 x i32>) #1
declare <8 x i16> @llvm.x86.sse2.psrl.w(<8 x i16>, <8 x i16>) #1

attributes #1 = { nounwind readnone }
