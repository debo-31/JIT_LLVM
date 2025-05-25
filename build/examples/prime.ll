; ModuleID = 'lljit/examples/prime.c'
source_filename = "lljit/examples/prime.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [48 x i8] c"Enter range to find prime numbers (start end): \00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"%d %d\00", align 1
@.str.2 = private unnamed_addr constant [38 x i8] c"Prime numbers between %d and %d are:\0A\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @isPrime(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %5 = load i32, ptr %3, align 4
  %6 = icmp sle i32 %5, 1
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 0, ptr %2, align 4
  br label %45

8:                                                ; preds = %1
  %9 = load i32, ptr %3, align 4
  %10 = icmp sle i32 %9, 3
  br i1 %10, label %11, label %12

11:                                               ; preds = %8
  store i32 1, ptr %2, align 4
  br label %45

12:                                               ; preds = %8
  %13 = load i32, ptr %3, align 4
  %14 = srem i32 %13, 2
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %20, label %16

16:                                               ; preds = %12
  %17 = load i32, ptr %3, align 4
  %18 = srem i32 %17, 3
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %21

20:                                               ; preds = %16, %12
  store i32 0, ptr %2, align 4
  br label %45

21:                                               ; preds = %16
  store i32 5, ptr %4, align 4
  br label %22

22:                                               ; preds = %41, %21
  %23 = load i32, ptr %4, align 4
  %24 = load i32, ptr %4, align 4
  %25 = mul nsw i32 %23, %24
  %26 = load i32, ptr %3, align 4
  %27 = icmp sle i32 %25, %26
  br i1 %27, label %28, label %44

28:                                               ; preds = %22
  %29 = load i32, ptr %3, align 4
  %30 = load i32, ptr %4, align 4
  %31 = srem i32 %29, %30
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %39, label %33

33:                                               ; preds = %28
  %34 = load i32, ptr %3, align 4
  %35 = load i32, ptr %4, align 4
  %36 = add nsw i32 %35, 2
  %37 = srem i32 %34, %36
  %38 = icmp eq i32 %37, 0
  br i1 %38, label %39, label %40

39:                                               ; preds = %33, %28
  store i32 0, ptr %2, align 4
  br label %45

40:                                               ; preds = %33
  br label %41

41:                                               ; preds = %40
  %42 = load i32, ptr %4, align 4
  %43 = add nsw i32 %42, 6
  store i32 %43, ptr %4, align 4
  br label %22, !llvm.loop !6

44:                                               ; preds = %22
  store i32 1, ptr %2, align 4
  br label %45

45:                                               ; preds = %44, %39, %20, %11, %7
  %46 = load i32, ptr %2, align 4
  ret i32 %46
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @jitentry() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %6 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1, ptr noundef %1, ptr noundef %2)
  %7 = load i32, ptr %1, align 4
  %8 = load i32, ptr %2, align 4
  %9 = icmp sgt i32 %7, %8
  br i1 %9, label %10, label %14

10:                                               ; preds = %0
  %11 = load i32, ptr %1, align 4
  store i32 %11, ptr %3, align 4
  %12 = load i32, ptr %2, align 4
  store i32 %12, ptr %1, align 4
  %13 = load i32, ptr %3, align 4
  store i32 %13, ptr %2, align 4
  br label %14

14:                                               ; preds = %10, %0
  %15 = load i32, ptr %1, align 4
  %16 = load i32, ptr %2, align 4
  %17 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %15, i32 noundef %16)
  %18 = load i32, ptr %1, align 4
  store i32 %18, ptr %4, align 4
  br label %19

19:                                               ; preds = %31, %14
  %20 = load i32, ptr %4, align 4
  %21 = load i32, ptr %2, align 4
  %22 = icmp sle i32 %20, %21
  br i1 %22, label %23, label %34

23:                                               ; preds = %19
  %24 = load i32, ptr %4, align 4
  %25 = call i32 @isPrime(i32 noundef %24)
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %30

27:                                               ; preds = %23
  %28 = load i32, ptr %4, align 4
  %29 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %28)
  br label %30

30:                                               ; preds = %27, %23
  br label %31

31:                                               ; preds = %30
  %32 = load i32, ptr %4, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %4, align 4
  br label %19, !llvm.loop !8

34:                                               ; preds = %19
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  ret i32 0
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
!8 = distinct !{!8, !7}
