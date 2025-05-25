#include <stdio.h>

void jitentry() {
    int num, originalNum, reversedNum = 0, remainder;
    
    printf("Enter a number: ");
    scanf("%d", &num);
    originalNum = num;
    
    // Reverse the number
    while (num != 0) {
        remainder = num % 10;
        reversedNum = reversedNum * 10 + remainder;
        num /= 10;
    }
    
    // Check if the number is palindrome
    if (originalNum == reversedNum) {
        printf("%d is a palindrome.\n", originalNum);
    } else {
        printf("%d is not a palindrome.\n", originalNum);
    }
} 