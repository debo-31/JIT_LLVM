#include <stdio.h>

int square(int n) {
    return n * n;
}

int jitentry() {
    int n;
    printf("Enter a number to compute its square: ");
    scanf("%d", &n);
    printf("Square of %d = %d\n", n, square(n));
    return 0;
} 