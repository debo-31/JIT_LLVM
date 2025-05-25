; ModuleID = 'game.c'
source_filename = "game.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [45 x i8] c"I'm thinking of a number between 1 and 100.\0A\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"Enter your guess: \00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.3 = private unnamed_addr constant [10 x i8] c"Too low!\0A\00", align 1
@.str.4 = private unnamed_addr constant [11 x i8] c"Too high!\0A\00", align 1
@.str.5 = private unnamed_addr constant [17 x i8] c"You guessed it!\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @jitentry() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = call i64 @time(ptr noundef null)
  %4 = trunc i64 %3 to i32
  call void @srand(i32 noundef %4)
  %5 = call i32 @rand()
  %6 = srem i32 %5, 100
  %7 = add nsw i32 %6, 1
  store i32 %7, ptr %1, align 4
  %8 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  br label %9

9:                                                ; preds = %27, %0
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  %11 = call i32 (ptr, ...) @scanf(ptr noundef @.str.2, ptr noundef %2)
  %12 = load i32, ptr %2, align 4
  %13 = load i32, ptr %1, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %17

15:                                               ; preds = %9
  %16 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %26

17:                                               ; preds = %9
  %18 = load i32, ptr %2, align 4
  %19 = load i32, ptr %1, align 4
  %20 = icmp sgt i32 %18, %19
  br i1 %20, label %21, label %23

21:                                               ; preds = %17
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  br label %25

23:                                               ; preds = %17
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  br label %25

25:                                               ; preds = %23, %21
  br label %26

26:                                               ; preds = %25, %15
  br label %27

27:                                               ; preds = %26
  %28 = load i32, ptr %2, align 4
  %29 = load i32, ptr %1, align 4
  %30 = icmp ne i32 %28, %29
  br i1 %30, label %9, label %31, !llvm.loop !6

31:                                               ; preds = %27
  ret void
}

declare void @srand(i32 noundef) #1

declare i64 @time(ptr noundef) #1

declare i32 @rand() #1

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
