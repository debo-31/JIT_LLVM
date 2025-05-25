; ModuleID = 'examples/matrix.c'
source_filename = "examples/matrix.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [2 x i8] c"[\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"]\0A\00", align 1
@__const.jitentry.A = private unnamed_addr constant [2 x [2 x i32]] [[2 x i32] [i32 1, i32 2], [2 x i32] [i32 3, i32 4]], align 4
@__const.jitentry.B = private unnamed_addr constant [2 x [2 x i32]] [[2 x i32] [i32 5, i32 6], [2 x i32] [i32 7, i32 8]], align 4
@.str.4 = private unnamed_addr constant [11 x i8] c"Matrix A:\0A\00", align 1
@.str.5 = private unnamed_addr constant [12 x i8] c"\0AMatrix B:\0A\00", align 1
@.str.6 = private unnamed_addr constant [28 x i8] c"\0AResult Matrix C = A \C3\97 B:\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @matrix_multiply(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %10

10:                                               ; preds = %63, %3
  %11 = load i32, ptr %7, align 4
  %12 = icmp slt i32 %11, 2
  br i1 %12, label %13, label %66

13:                                               ; preds = %10
  store i32 0, ptr %8, align 4
  br label %14

14:                                               ; preds = %59, %13
  %15 = load i32, ptr %8, align 4
  %16 = icmp slt i32 %15, 2
  br i1 %16, label %17, label %62

17:                                               ; preds = %14
  %18 = load ptr, ptr %6, align 8
  %19 = load i32, ptr %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [2 x i32], ptr %18, i64 %20
  %22 = load i32, ptr %8, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [2 x i32], ptr %21, i64 0, i64 %23
  store i32 0, ptr %24, align 4
  store i32 0, ptr %9, align 4
  br label %25

25:                                               ; preds = %55, %17
  %26 = load i32, ptr %9, align 4
  %27 = icmp slt i32 %26, 2
  br i1 %27, label %28, label %58

28:                                               ; preds = %25
  %29 = load ptr, ptr %4, align 8
  %30 = load i32, ptr %7, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [2 x i32], ptr %29, i64 %31
  %33 = load i32, ptr %9, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [2 x i32], ptr %32, i64 0, i64 %34
  %36 = load i32, ptr %35, align 4
  %37 = load ptr, ptr %5, align 8
  %38 = load i32, ptr %9, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [2 x i32], ptr %37, i64 %39
  %41 = load i32, ptr %8, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [2 x i32], ptr %40, i64 0, i64 %42
  %44 = load i32, ptr %43, align 4
  %45 = mul nsw i32 %36, %44
  %46 = load ptr, ptr %6, align 8
  %47 = load i32, ptr %7, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [2 x i32], ptr %46, i64 %48
  %50 = load i32, ptr %8, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [2 x i32], ptr %49, i64 0, i64 %51
  %53 = load i32, ptr %52, align 4
  %54 = add nsw i32 %53, %45
  store i32 %54, ptr %52, align 4
  br label %55

55:                                               ; preds = %28
  %56 = load i32, ptr %9, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %9, align 4
  br label %25, !llvm.loop !6

58:                                               ; preds = %25
  br label %59

59:                                               ; preds = %58
  %60 = load i32, ptr %8, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %8, align 4
  br label %14, !llvm.loop !8

62:                                               ; preds = %14
  br label %63

63:                                               ; preds = %62
  %64 = load i32, ptr %7, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, ptr %7, align 4
  br label %10, !llvm.loop !9

66:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @print_matrix(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %33, %1
  %6 = load i32, ptr %3, align 4
  %7 = icmp slt i32 %6, 2
  br i1 %7, label %8, label %36

8:                                                ; preds = %5
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 0, ptr %4, align 4
  br label %10

10:                                               ; preds = %28, %8
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %11, 2
  br i1 %12, label %13, label %31

13:                                               ; preds = %10
  %14 = load ptr, ptr %2, align 8
  %15 = load i32, ptr %3, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [2 x i32], ptr %14, i64 %16
  %18 = load i32, ptr %4, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [2 x i32], ptr %17, i64 0, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %21)
  %23 = load i32, ptr %4, align 4
  %24 = icmp slt i32 %23, 1
  br i1 %24, label %25, label %27

25:                                               ; preds = %13
  %26 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  br label %27

27:                                               ; preds = %25, %13
  br label %28

28:                                               ; preds = %27
  %29 = load i32, ptr %4, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %4, align 4
  br label %10, !llvm.loop !10

31:                                               ; preds = %10
  %32 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %33

33:                                               ; preds = %31
  %34 = load i32, ptr %3, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %3, align 4
  br label %5, !llvm.loop !11

36:                                               ; preds = %5
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @jitentry() #0 {
  %1 = alloca [2 x [2 x i32]], align 4
  %2 = alloca [2 x [2 x i32]], align 4
  %3 = alloca [2 x [2 x i32]], align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %1, ptr align 4 @__const.jitentry.A, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %2, ptr align 4 @__const.jitentry.B, i64 16, i1 false)
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  %5 = getelementptr inbounds [2 x [2 x i32]], ptr %1, i64 0, i64 0
  call void @print_matrix(ptr noundef %5)
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  %7 = getelementptr inbounds [2 x [2 x i32]], ptr %2, i64 0, i64 0
  call void @print_matrix(ptr noundef %7)
  %8 = getelementptr inbounds [2 x [2 x i32]], ptr %1, i64 0, i64 0
  %9 = getelementptr inbounds [2 x [2 x i32]], ptr %2, i64 0, i64 0
  %10 = getelementptr inbounds [2 x [2 x i32]], ptr %3, i64 0, i64 0
  call void @matrix_multiply(ptr noundef %8, ptr noundef %9, ptr noundef %10)
  %11 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  %12 = getelementptr inbounds [2 x [2 x i32]], ptr %3, i64 0, i64 0
  call void @print_matrix(ptr noundef %12)
  ret i32 0
}

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
