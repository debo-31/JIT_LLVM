#include <stdio.h>

long long fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int jitentry() {
    int n;
    printf("Enter how many Fibonacci numbers you want to see (1-20): ");
    scanf("%d", &n);
    
    if (n < 1 || n > 20) {
        printf("Please enter a number between 1 and 20\n");
        return 1;
    }

    printf("First %d Fibonacci numbers:\n", n);
    for (int i = 0; i < n; i++) {
        printf("%d: %lld\n", i + 1, fibonacci(i));
    }
    return 0;
} 