#include <stdio.h>
#include <stdlib.h>

// Python-like filter function
void filter_list(int* input, int* output, int size, int* output_size) {
    *output_size = 0;
    for(int i = 0; i < size; i++) {
        // Python-like: [x for x in numbers if x % 2 == 0]
        if(input[i] % 2 == 0) {
            output[*output_size] = input[i];
            (*output_size)++;
        }
    }
}

// Python-like map function
void map_list(int* input, int* output, int size) {
    // Python-like: [x * x for x in numbers]
    for(int i = 0; i < size; i++) {
        output[i] = input[i] * input[i];
    }
}

int jitentry() {
    printf("Python-style List Operations in C\n");
    
    // Take user input for the list
    int size = 10;
    int numbers[10];
    printf("\nEnter 10 integers for the list: ");
    for(int i = 0; i < size; i++) {
        scanf("%d", &numbers[i]);
    }
    printf("You entered: ");
    for(int i = 0; i < size; i++) {
        printf("%d ", numbers[i]);
    }
    
    // Filter even numbers (Python: evens = [x for x in numbers if x % 2 == 0])
    int evens[10];
    int evens_size;
    filter_list(numbers, evens, size, &evens_size);
    
    printf("\n\nEven numbers: ");
    for(int i = 0; i < evens_size; i++) {
        printf("%d ", evens[i]);
    }
    
    // Square numbers (Python: squares = [x * x for x in numbers])
    int squares[10];
    map_list(numbers, squares, size);
    
    printf("\n\nSquared numbers: ");
    for(int i = 0; i < size; i++) {
        printf("%d ", squares[i]);
    }
    
    printf("\n");
    return 0;
} 