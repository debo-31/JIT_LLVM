; ModuleID = 'lljit/examples/printname.c'
source_filename = "lljit/examples/printname.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [23 x i8] c"Enter your full name: \00", align 1
@__stdinp = external global ptr, align 8
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"Initials: \00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"%c\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @jitentry() #0 {
  %1 = alloca [100 x i8], align 1
  %2 = alloca i32, align 4
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %4 = getelementptr inbounds [100 x i8], ptr %1, i64 0, i64 0
  %5 = load ptr, ptr @__stdinp, align 8
  %6 = call ptr @fgets(ptr noundef %4, i32 noundef 100, ptr noundef %5)
  %7 = getelementptr inbounds [100 x i8], ptr %1, i64 0, i64 0
  %8 = call i64 @strcspn(ptr noundef %7, ptr noundef @.str.1)
  %9 = getelementptr inbounds nuw [100 x i8], ptr %1, i64 0, i64 %8
  store i8 0, ptr %9, align 1
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %11 = getelementptr inbounds [100 x i8], ptr %1, i64 0, i64 0
  %12 = load i8, ptr %11, align 1
  %13 = sext i8 %12 to i32
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %13)
  store i32 1, ptr %2, align 4
  br label %15

15:                                               ; preds = %37, %0
  %16 = load i32, ptr %2, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [100 x i8], ptr %1, i64 0, i64 0
  %19 = call i64 @strlen(ptr noundef %18) #3
  %20 = icmp ult i64 %17, %19
  br i1 %20, label %21, label %40

21:                                               ; preds = %15
  %22 = load i32, ptr %2, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [100 x i8], ptr %1, i64 0, i64 %23
  %25 = load i8, ptr %24, align 1
  %26 = sext i8 %25 to i32
  %27 = icmp eq i32 %26, 32
  br i1 %27, label %28, label %36

28:                                               ; preds = %21
  %29 = load i32, ptr %2, align 4
  %30 = add nsw i32 %29, 1
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [100 x i8], ptr %1, i64 0, i64 %31
  %33 = load i8, ptr %32, align 1
  %34 = sext i8 %33 to i32
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %34)
  br label %36

36:                                               ; preds = %28, %21
  br label %37

37:                                               ; preds = %36
  %38 = load i32, ptr %2, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %2, align 4
  br label %15, !llvm.loop !6

40:                                               ; preds = %15
  %41 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

declare ptr @fgets(ptr noundef, i32 noundef, ptr noundef) #1

declare i64 @strcspn(ptr noundef, ptr noundef) #1

; Function Attrs: nounwind
declare i64 @strlen(ptr noundef) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #3 = { nounwind }

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
