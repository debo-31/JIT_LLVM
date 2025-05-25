; ModuleID = 'lljit/examples/python_style.c'
source_filename = "lljit/examples/python_style.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [35 x i8] c"Python-style List Operations in C\0A\00", align 1
@.str.1 = private unnamed_addr constant [34 x i8] c"\0AEnter 10 integers for the list: \00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"You entered: \00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.5 = private unnamed_addr constant [17 x i8] c"\0A\0AEven numbers: \00", align 1
@.str.6 = private unnamed_addr constant [20 x i8] c"\0A\0ASquared numbers: \00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @filter_list(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store ptr %3, ptr %8, align 8
  %10 = load ptr, ptr %8, align 8
  store i32 0, ptr %10, align 4
  store i32 0, ptr %9, align 4
  br label %11

11:                                               ; preds = %38, %4
  %12 = load i32, ptr %9, align 4
  %13 = load i32, ptr %7, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %41

15:                                               ; preds = %11
  %16 = load ptr, ptr %5, align 8
  %17 = load i32, ptr %9, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i32, ptr %16, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = srem i32 %20, 2
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %37

23:                                               ; preds = %15
  %24 = load ptr, ptr %5, align 8
  %25 = load i32, ptr %9, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds i32, ptr %24, i64 %26
  %28 = load i32, ptr %27, align 4
  %29 = load ptr, ptr %6, align 8
  %30 = load ptr, ptr %8, align 8
  %31 = load i32, ptr %30, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds i32, ptr %29, i64 %32
  store i32 %28, ptr %33, align 4
  %34 = load ptr, ptr %8, align 8
  %35 = load i32, ptr %34, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %34, align 4
  br label %37

37:                                               ; preds = %23, %15
  br label %38

38:                                               ; preds = %37
  %39 = load i32, ptr %9, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %9, align 4
  br label %11, !llvm.loop !6

41:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @map_list(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %8

8:                                                ; preds = %28, %3
  %9 = load i32, ptr %7, align 4
  %10 = load i32, ptr %6, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %31

12:                                               ; preds = %8
  %13 = load ptr, ptr %4, align 8
  %14 = load i32, ptr %7, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %13, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = load ptr, ptr %4, align 8
  %19 = load i32, ptr %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %18, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = mul nsw i32 %17, %22
  %24 = load ptr, ptr %5, align 8
  %25 = load i32, ptr %7, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds i32, ptr %24, i64 %26
  store i32 %23, ptr %27, align 4
  br label %28

28:                                               ; preds = %12
  %29 = load i32, ptr %7, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %7, align 4
  br label %8, !llvm.loop !8

31:                                               ; preds = %8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @jitentry() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [10 x i32], align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca [10 x i32], align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca [10 x i32], align 4
  %9 = alloca i32, align 4
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 10, ptr %1, align 4
  %11 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %21, %0
  %13 = load i32, ptr %3, align 4
  %14 = load i32, ptr %1, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %24

16:                                               ; preds = %12
  %17 = load i32, ptr %3, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [10 x i32], ptr %2, i64 0, i64 %18
  %20 = call i32 (ptr, ...) @scanf(ptr noundef @.str.2, ptr noundef %19)
  br label %21

21:                                               ; preds = %16
  %22 = load i32, ptr %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %3, align 4
  br label %12, !llvm.loop !9

24:                                               ; preds = %12
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store i32 0, ptr %4, align 4
  br label %26

26:                                               ; preds = %36, %24
  %27 = load i32, ptr %4, align 4
  %28 = load i32, ptr %1, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %39

30:                                               ; preds = %26
  %31 = load i32, ptr %4, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [10 x i32], ptr %2, i64 0, i64 %32
  %34 = load i32, ptr %33, align 4
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %34)
  br label %36

36:                                               ; preds = %30
  %37 = load i32, ptr %4, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %4, align 4
  br label %26, !llvm.loop !10

39:                                               ; preds = %26
  %40 = getelementptr inbounds [10 x i32], ptr %2, i64 0, i64 0
  %41 = getelementptr inbounds [10 x i32], ptr %5, i64 0, i64 0
  %42 = load i32, ptr %1, align 4
  call void @filter_list(ptr noundef %40, ptr noundef %41, i32 noundef %42, ptr noundef %6)
  %43 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  store i32 0, ptr %7, align 4
  br label %44

44:                                               ; preds = %54, %39
  %45 = load i32, ptr %7, align 4
  %46 = load i32, ptr %6, align 4
  %47 = icmp slt i32 %45, %46
  br i1 %47, label %48, label %57

48:                                               ; preds = %44
  %49 = load i32, ptr %7, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [10 x i32], ptr %5, i64 0, i64 %50
  %52 = load i32, ptr %51, align 4
  %53 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %52)
  br label %54

54:                                               ; preds = %48
  %55 = load i32, ptr %7, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, ptr %7, align 4
  br label %44, !llvm.loop !11

57:                                               ; preds = %44
  %58 = getelementptr inbounds [10 x i32], ptr %2, i64 0, i64 0
  %59 = getelementptr inbounds [10 x i32], ptr %8, i64 0, i64 0
  %60 = load i32, ptr %1, align 4
  call void @map_list(ptr noundef %58, ptr noundef %59, i32 noundef %60)
  %61 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  store i32 0, ptr %9, align 4
  br label %62

62:                                               ; preds = %72, %57
  %63 = load i32, ptr %9, align 4
  %64 = load i32, ptr %1, align 4
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %75

66:                                               ; preds = %62
  %67 = load i32, ptr %9, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [10 x i32], ptr %8, i64 0, i64 %68
  %70 = load i32, ptr %69, align 4
  %71 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %70)
  br label %72

72:                                               ; preds = %66
  %73 = load i32, ptr %9, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, ptr %9, align 4
  br label %62, !llvm.loop !12

75:                                               ; preds = %62
  %76 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
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
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
