#include <stdio.h>

void jitentry() {
    int num, i;
    
    printf("Enter a number to generate its multiplication table: ");
    scanf("%d", &num);
    
    printf("\nMultiplication Table for %d:\n", num);
    printf("------------------------\n");
    
    for (i = 1; i <= 10; i++) {
        printf("%d x %d = %d\n", num, i, num * i);
    }
} 