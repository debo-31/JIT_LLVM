#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void jitentry() {
    int secret, guess;
    srand(time(NULL));
    secret = rand() % 100 + 1;
    printf("I'm thinking of a number between 1 and 100.\n");
    do {
        printf("Enter your guess: ");
        scanf("%d", &guess);
        if (guess < secret) {
            printf("Too low!\n");
        } else if (guess > secret) {
            printf("Too high!\n");
        } else {
            printf("You guessed it!\n");
        }
    } while (guess != secret);
} 