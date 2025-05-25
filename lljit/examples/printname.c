
#include <stdio.h>
#include <string.h>

int jitentry() {
    char name[100];
    printf("Enter your full name: ");
    fgets(name, sizeof(name), stdin);

    // Removing the newline character from the input if present
    name[strcspn(name, "\n")] = 0;

    // Print the first letter of the name
    printf("Initials: ");
    printf("%c", name[0]);

    // Traverse the rest of the name and print the initials
    for (int i = 1; i < strlen(name); i++) {
        if (name[i] == ' ') {
            // Print the letter after a space (next word)
            printf("%c", name[i + 1]);
        }
    }

    printf("\n");

    return 0;
}
