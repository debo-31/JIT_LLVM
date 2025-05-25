#include <stdio.h>

int jitentry() {
    int x;
    printf("Enter a number: ");
    scanf("%d", &x);
    printf("You entered: %d\n", x);
    return 0;
}
