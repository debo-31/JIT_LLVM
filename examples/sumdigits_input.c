#include <stdio.h>

// Pure function: recursively computes the sum of digits of n
int sum_of_digits(int n) {
    if (n == 0) return 0;
    return (n % 10) + sum_of_digits(n / 10);
}

int jitentry() {
    int n;
    printf("Enter an integer: ");
    scanf("%d", &n);
    printf("Sum of digits of %d is %d\n", n, sum_of_digits(n));
    return 0;
}
