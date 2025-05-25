; ModuleID = 'examples/python_advanced.c'
source_filename = "examples/python_advanced.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [39 x i8] c"Advanced Python-style Operations in C\0A\00", align 1
@__const.jitentry.list1 = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5], align 4
@__const.jitentry.list2 = private unnamed_addr constant [5 x i32] [i32 10, i32 20, i32 30, i32 40, i32 50], align 4
@.str.1 = private unnamed_addr constant [10 x i8] c"\0AList 1: \00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.3 = private unnamed_addr constant [10 x i8] c"\0AList 2: \00", align 1
@.str.4 = private unnamed_addr constant [29 x i8] c"\0A\0AReduce (sum) of List 1: %d\00", align 1
@.str.5 = private unnamed_addr constant [32 x i8] c"\0AReduce (product) of List 1: %d\00", align 1
@.str.6 = private unnamed_addr constant [29 x i8] c"\0A\0AZipped sum of both lists: \00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"\0A\0ASlice list1[1:4:1]: \00", align 1
@.str.8 = private unnamed_addr constant [20 x i8] c"\0ASlice list1[::2]: \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @reduce_sum(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %7

7:                                                ; preds = %19, %2
  %8 = load i32, ptr %6, align 4
  %9 = load i32, ptr %4, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %22

11:                                               ; preds = %7
  %12 = load ptr, ptr %3, align 8
  %13 = load i32, ptr %6, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds i32, ptr %12, i64 %14
  %16 = load i32, ptr %15, align 4
  %17 = load i32, ptr %5, align 4
  %18 = add nsw i32 %17, %16
  store i32 %18, ptr %5, align 4
  br label %19

19:                                               ; preds = %11
  %20 = load i32, ptr %6, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %6, align 4
  br label %7, !llvm.loop !6

22:                                               ; preds = %7
  %23 = load i32, ptr %5, align 4
  ret i32 %23
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @reduce_product(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 1, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %7

7:                                                ; preds = %19, %2
  %8 = load i32, ptr %6, align 4
  %9 = load i32, ptr %4, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %22

11:                                               ; preds = %7
  %12 = load ptr, ptr %3, align 8
  %13 = load i32, ptr %6, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds i32, ptr %12, i64 %14
  %16 = load i32, ptr %15, align 4
  %17 = load i32, ptr %5, align 4
  %18 = mul nsw i32 %17, %16
  store i32 %18, ptr %5, align 4
  br label %19

19:                                               ; preds = %11
  %20 = load i32, ptr %6, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %6, align 4
  br label %7, !llvm.loop !8

22:                                               ; preds = %7
  %23 = load i32, ptr %5, align 4
  ret i32 %23
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @zip_and_sum(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  store i32 %3, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %10

10:                                               ; preds = %30, %4
  %11 = load i32, ptr %9, align 4
  %12 = load i32, ptr %8, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %33

14:                                               ; preds = %10
  %15 = load ptr, ptr %5, align 8
  %16 = load i32, ptr %9, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i32, ptr %15, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = load ptr, ptr %6, align 8
  %21 = load i32, ptr %9, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds i32, ptr %20, i64 %22
  %24 = load i32, ptr %23, align 4
  %25 = add nsw i32 %19, %24
  %26 = load ptr, ptr %7, align 8
  %27 = load i32, ptr %9, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i32, ptr %26, i64 %28
  store i32 %25, ptr %29, align 4
  br label %30

30:                                               ; preds = %14
  %31 = load i32, ptr %9, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %9, align 4
  br label %10, !llvm.loop !9

33:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @list_slice(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5, ptr noundef %6) #0 {
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  store ptr %0, ptr %8, align 8
  store ptr %1, ptr %9, align 8
  store i32 %2, ptr %10, align 4
  store i32 %3, ptr %11, align 4
  store i32 %4, ptr %12, align 4
  store i32 %5, ptr %13, align 4
  store ptr %6, ptr %14, align 8
  %16 = load ptr, ptr %14, align 8
  store i32 0, ptr %16, align 4
  %17 = load i32, ptr %12, align 4
  %18 = load i32, ptr %10, align 4
  %19 = icmp sgt i32 %17, %18
  br i1 %19, label %20, label %22

20:                                               ; preds = %7
  %21 = load i32, ptr %10, align 4
  store i32 %21, ptr %12, align 4
  br label %22

22:                                               ; preds = %20, %7
  %23 = load i32, ptr %11, align 4
  store i32 %23, ptr %15, align 4
  br label %24

24:                                               ; preds = %42, %22
  %25 = load i32, ptr %15, align 4
  %26 = load i32, ptr %12, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %46

28:                                               ; preds = %24
  %29 = load ptr, ptr %8, align 8
  %30 = load i32, ptr %15, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds i32, ptr %29, i64 %31
  %33 = load i32, ptr %32, align 4
  %34 = load ptr, ptr %9, align 8
  %35 = load ptr, ptr %14, align 8
  %36 = load i32, ptr %35, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i32, ptr %34, i64 %37
  store i32 %33, ptr %38, align 4
  %39 = load ptr, ptr %14, align 8
  %40 = load i32, ptr %39, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %39, align 4
  br label %42

42:                                               ; preds = %28
  %43 = load i32, ptr %13, align 4
  %44 = load i32, ptr %15, align 4
  %45 = add nsw i32 %44, %43
  store i32 %45, ptr %15, align 4
  br label %24, !llvm.loop !10

46:                                               ; preds = %24
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @jitentry() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [5 x i32], align 4
  %3 = alloca [5 x i32], align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca [5 x i32], align 4
  %9 = alloca i32, align 4
  %10 = alloca [10 x i32], align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 5, ptr %1, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %2, ptr align 4 @__const.jitentry.list1, i64 20, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %3, ptr align 4 @__const.jitentry.list2, i64 20, i1 false)
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %4, align 4
  br label %16

16:                                               ; preds = %26, %0
  %17 = load i32, ptr %4, align 4
  %18 = load i32, ptr %1, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %29

20:                                               ; preds = %16
  %21 = load i32, ptr %4, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [5 x i32], ptr %2, i64 0, i64 %22
  %24 = load i32, ptr %23, align 4
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %24)
  br label %26

26:                                               ; preds = %20
  %27 = load i32, ptr %4, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %4, align 4
  br label %16, !llvm.loop !11

29:                                               ; preds = %16
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store i32 0, ptr %5, align 4
  br label %31

31:                                               ; preds = %41, %29
  %32 = load i32, ptr %5, align 4
  %33 = load i32, ptr %1, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %44

35:                                               ; preds = %31
  %36 = load i32, ptr %5, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [5 x i32], ptr %3, i64 0, i64 %37
  %39 = load i32, ptr %38, align 4
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %39)
  br label %41

41:                                               ; preds = %35
  %42 = load i32, ptr %5, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %5, align 4
  br label %31, !llvm.loop !12

44:                                               ; preds = %31
  %45 = getelementptr inbounds [5 x i32], ptr %2, i64 0, i64 0
  %46 = load i32, ptr %1, align 4
  %47 = call i32 @reduce_sum(ptr noundef %45, i32 noundef %46)
  store i32 %47, ptr %6, align 4
  %48 = load i32, ptr %6, align 4
  %49 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %48)
  %50 = getelementptr inbounds [5 x i32], ptr %2, i64 0, i64 0
  %51 = load i32, ptr %1, align 4
  %52 = call i32 @reduce_product(ptr noundef %50, i32 noundef %51)
  store i32 %52, ptr %7, align 4
  %53 = load i32, ptr %7, align 4
  %54 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %53)
  %55 = getelementptr inbounds [5 x i32], ptr %2, i64 0, i64 0
  %56 = getelementptr inbounds [5 x i32], ptr %3, i64 0, i64 0
  %57 = getelementptr inbounds [5 x i32], ptr %8, i64 0, i64 0
  %58 = load i32, ptr %1, align 4
  call void @zip_and_sum(ptr noundef %55, ptr noundef %56, ptr noundef %57, i32 noundef %58)
  %59 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  store i32 0, ptr %9, align 4
  br label %60

60:                                               ; preds = %70, %44
  %61 = load i32, ptr %9, align 4
  %62 = load i32, ptr %1, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %73

64:                                               ; preds = %60
  %65 = load i32, ptr %9, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [5 x i32], ptr %8, i64 0, i64 %66
  %68 = load i32, ptr %67, align 4
  %69 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %68)
  br label %70

70:                                               ; preds = %64
  %71 = load i32, ptr %9, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, ptr %9, align 4
  br label %60, !llvm.loop !13

73:                                               ; preds = %60
  %74 = getelementptr inbounds [5 x i32], ptr %2, i64 0, i64 0
  %75 = getelementptr inbounds [10 x i32], ptr %10, i64 0, i64 0
  %76 = load i32, ptr %1, align 4
  call void @list_slice(ptr noundef %74, ptr noundef %75, i32 noundef %76, i32 noundef 1, i32 noundef 4, i32 noundef 1, ptr noundef %11)
  %77 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  store i32 0, ptr %12, align 4
  br label %78

78:                                               ; preds = %88, %73
  %79 = load i32, ptr %12, align 4
  %80 = load i32, ptr %11, align 4
  %81 = icmp slt i32 %79, %80
  br i1 %81, label %82, label %91

82:                                               ; preds = %78
  %83 = load i32, ptr %12, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds [10 x i32], ptr %10, i64 0, i64 %84
  %86 = load i32, ptr %85, align 4
  %87 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %86)
  br label %88

88:                                               ; preds = %82
  %89 = load i32, ptr %12, align 4
  %90 = add nsw i32 %89, 1
  store i32 %90, ptr %12, align 4
  br label %78, !llvm.loop !14

91:                                               ; preds = %78
  %92 = getelementptr inbounds [5 x i32], ptr %2, i64 0, i64 0
  %93 = getelementptr inbounds [10 x i32], ptr %10, i64 0, i64 0
  %94 = load i32, ptr %1, align 4
  %95 = load i32, ptr %1, align 4
  call void @list_slice(ptr noundef %92, ptr noundef %93, i32 noundef %94, i32 noundef 0, i32 noundef %95, i32 noundef 2, ptr noundef %11)
  %96 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  store i32 0, ptr %13, align 4
  br label %97

97:                                               ; preds = %107, %91
  %98 = load i32, ptr %13, align 4
  %99 = load i32, ptr %11, align 4
  %100 = icmp slt i32 %98, %99
  br i1 %100, label %101, label %110

101:                                              ; preds = %97
  %102 = load i32, ptr %13, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds [10 x i32], ptr %10, i64 0, i64 %103
  %105 = load i32, ptr %104, align 4
  %106 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %105)
  br label %107

107:                                              ; preds = %101
  %108 = load i32, ptr %13, align 4
  %109 = add nsw i32 %108, 1
  store i32 %109, ptr %13, align 4
  br label %97, !llvm.loop !15

110:                                              ; preds = %97
  %111 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

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
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
