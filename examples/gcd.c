#include <stdio.h>

void jitentry() {
    int num1, num2;
    printf("Enter two numbers: ");
    scanf("%d %d", &num1, &num2);
    
    // Make sure num1 is greater than num2
    if (num1 < num2) {
        int temp = num1;
        num1 = num2;
        num2 = temp;
    }
    
    // Calculate GCD using Euclidean algorithm
    while (num2 != 0) {
        int remainder = num1 % num2;
        num1 = num2;
        num2 = remainder;
    }
    
    printf("GCD is: %d\n", num1);
} 