; ModuleID = 'examples/fibonacci.c'
source_filename = "examples/fibonacci.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [58 x i8] c"Enter how many Fibonacci numbers you want to see (1-20): \00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2 = private unnamed_addr constant [40 x i8] c"Please enter a number between 1 and 20\0A\00", align 1
@.str.3 = private unnamed_addr constant [29 x i8] c"First %d Fibonacci numbers:\0A\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"%d: %lld\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i64 @fibonacci(i32 noundef %0) #0 {
  %2 = alloca i64, align 8
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = load i32, ptr %3, align 4
  %5 = icmp sle i32 %4, 1
  br i1 %5, label %6, label %9

6:                                                ; preds = %1
  %7 = load i32, ptr %3, align 4
  %8 = sext i32 %7 to i64
  store i64 %8, ptr %2, align 8
  br label %17

9:                                                ; preds = %1
  %10 = load i32, ptr %3, align 4
  %11 = sub nsw i32 %10, 1
  %12 = call i64 @fibonacci(i32 noundef %11)
  %13 = load i32, ptr %3, align 4
  %14 = sub nsw i32 %13, 2
  %15 = call i64 @fibonacci(i32 noundef %14)
  %16 = add nsw i64 %12, %15
  store i64 %16, ptr %2, align 8
  br label %17

17:                                               ; preds = %9, %6
  %18 = load i64, ptr %2, align 8
  ret i64 %18
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @jitentry() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1, ptr noundef %2)
  %6 = load i32, ptr %2, align 4
  %7 = icmp slt i32 %6, 1
  br i1 %7, label %11, label %8

8:                                                ; preds = %0
  %9 = load i32, ptr %2, align 4
  %10 = icmp sgt i32 %9, 20
  br i1 %10, label %11, label %13

11:                                               ; preds = %8, %0
  %12 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  store i32 1, ptr %1, align 4
  br label %30

13:                                               ; preds = %8
  %14 = load i32, ptr %2, align 4
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %14)
  store i32 0, ptr %3, align 4
  br label %16

16:                                               ; preds = %26, %13
  %17 = load i32, ptr %3, align 4
  %18 = load i32, ptr %2, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %29

20:                                               ; preds = %16
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %21, 1
  %23 = load i32, ptr %3, align 4
  %24 = call i64 @fibonacci(i32 noundef %23)
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %22, i64 noundef %24)
  br label %26

26:                                               ; preds = %20
  %27 = load i32, ptr %3, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %3, align 4
  br label %16, !llvm.loop !6

29:                                               ; preds = %16
  store i32 0, ptr %1, align 4
  br label %30

30:                                               ; preds = %29, %11
  %31 = load i32, ptr %1, align 4
  ret i32 %31
}

declare i32 @printf(ptr noundef, ...) #1

declare i32 @scanf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 4]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 20.1.3"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
