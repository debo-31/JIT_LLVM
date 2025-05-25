#include <stdio.h>
int jitentry() {
    int n, m;
    printf("Enter a number: ");
    scanf("%d", &n);
    printf("Enter another number: ");
    scanf("%d", &m);
    printf("numbers concatenated are: %d%d\n", n, m);
    return 0;
}