; ModuleID = 'examples/calculator.c'
source_filename = "examples/calculator.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [59 x i8] c"\0AEnter calculation (number operator number, e.g., 5 + 3): \00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"%lf %c %lf\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"%.2f %c %.2f = %.2f\0A\00", align 1
@.str.3 = private unnamed_addr constant [57 x i8] c"\0ADo you want to calculate again? (1 for yes, 0 for no): \00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.5 = private unnamed_addr constant [37 x i8] c"Thank you for using the calculator!\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define double @calculate(double noundef %0, double noundef %1, i8 noundef signext %2) #0 {
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca i8, align 1
  store double %0, ptr %5, align 8
  store double %1, ptr %6, align 8
  store i8 %2, ptr %7, align 1
  %8 = load i8, ptr %7, align 1
  %9 = sext i8 %8 to i32
  switch i32 %9, label %32 [
    i32 43, label %10
    i32 45, label %14
    i32 42, label %18
    i32 47, label %22
  ]

10:                                               ; preds = %3
  %11 = load double, ptr %5, align 8
  %12 = load double, ptr %6, align 8
  %13 = fadd double %11, %12
  store double %13, ptr %4, align 8
  br label %33

14:                                               ; preds = %3
  %15 = load double, ptr %5, align 8
  %16 = load double, ptr %6, align 8
  %17 = fsub double %15, %16
  store double %17, ptr %4, align 8
  br label %33

18:                                               ; preds = %3
  %19 = load double, ptr %5, align 8
  %20 = load double, ptr %6, align 8
  %21 = fmul double %19, %20
  store double %21, ptr %4, align 8
  br label %33

22:                                               ; preds = %3
  %23 = load double, ptr %6, align 8
  %24 = fcmp une double %23, 0.000000e+00
  br i1 %24, label %25, label %29

25:                                               ; preds = %22
  %26 = load double, ptr %5, align 8
  %27 = load double, ptr %6, align 8
  %28 = fdiv double %26, %27
  br label %30

29:                                               ; preds = %22
  br label %30

30:                                               ; preds = %29, %25
  %31 = phi double [ %28, %25 ], [ 0.000000e+00, %29 ]
  store double %31, ptr %4, align 8
  br label %33

32:                                               ; preds = %3
  store double 0.000000e+00, ptr %4, align 8
  br label %33

33:                                               ; preds = %32, %30, %18, %14, %10
  %34 = load double, ptr %4, align 8
  ret double %34
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @jitentry() #0 {
  %1 = alloca double, align 8
  %2 = alloca double, align 8
  %3 = alloca i8, align 1
  %4 = alloca i32, align 4
  %5 = alloca double, align 8
  store i32 1, ptr %4, align 4
  br label %6

6:                                                ; preds = %9, %0
  %7 = load i32, ptr %4, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %24

9:                                                ; preds = %6
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %11 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1, ptr noundef %1, ptr noundef %3, ptr noundef %2)
  %12 = load double, ptr %1, align 8
  %13 = load double, ptr %2, align 8
  %14 = load i8, ptr %3, align 1
  %15 = call double @calculate(double noundef %12, double noundef %13, i8 noundef signext %14)
  store double %15, ptr %5, align 8
  %16 = load double, ptr %1, align 8
  %17 = load i8, ptr %3, align 1
  %18 = sext i8 %17 to i32
  %19 = load double, ptr %2, align 8
  %20 = load double, ptr %5, align 8
  %21 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %16, i32 noundef %18, double noundef %19, double noundef %20)
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %23 = call i32 (ptr, ...) @scanf(ptr noundef @.str.4, ptr noundef %4)
  br label %6, !llvm.loop !6

24:                                               ; preds = %6
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
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
