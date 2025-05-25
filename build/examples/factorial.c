#include <stdio.h>

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int jitentry() {
    int n;
    printf("Enter a number to compute its factorial: ");
    scanf("%d", &n);
    printf("Factorial of %d = %d\n", n, factorial(n));
    return 0;
} 