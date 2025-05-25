#include <stdio.h>

int calculate_sum(int n) {
    int result = 0;
    for(int i = 0; i < n; i++) {
        result += i;
    }
    return result;
}

int jitentry() {
    int n;
    printf("Enter the upper limit (exclusive) for the sum: ");
    scanf("%d", &n);
    printf("Sum of numbers from 0 to %d is: %d\n", n-1, calculate_sum(n));
    return 0;
}
