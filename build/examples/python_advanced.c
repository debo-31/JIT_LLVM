#include <stdio.h>
#include <stdlib.h>

// Python-like reduce function (e.g., reduce(lambda x, y: x + y, numbers))
int reduce_sum(int* list, int size) {
    int result = 0;
    for(int i = 0; i < size; i++) {
        result += list[i];
    }
    return result;
}

// Python-like reduce with multiplication (e.g., reduce(lambda x, y: x * y, numbers))
int reduce_product(int* list, int size) {
    int result = 1;
    for(int i = 0; i < size; i++) {
        result *= list[i];
    }
    return result;
}

// Python-like zip and list operation
void zip_and_sum(int* list1, int* list2, int* output, int size) {
    // Python: [x + y for x, y in zip(list1, list2)]
    for(int i = 0; i < size; i++) {
        output[i] = list1[i] + list2[i];
    }
}

// Python-like list slicing (e.g., list[start:end:step])
void list_slice(int* input, int* output, int size, int start, int end, int step, int* output_size) {
    *output_size = 0;
    if(end > size) end = size;
    for(int i = start; i < end; i += step) {
        output[*output_size] = input[i];
        (*output_size)++;
    }
}

int jitentry() {
    printf("Advanced Python-style Operations in C\n");
    
    // Create two lists
    int size = 5;
    int list1[5], list2[5];
    printf("\nEnter 5 integers for List 1: ");
    for(int i = 0; i < size; i++) scanf("%d", &list1[i]);
    printf("Enter 5 integers for List 2: ");
    for(int i = 0; i < size; i++) scanf("%d", &list2[i]);
    
    printf("\nList 1: ");
    for(int i = 0; i < size; i++) printf("%d ", list1[i]);
    
    printf("\nList 2: ");
    for(int i = 0; i < size; i++) printf("%d ", list2[i]);
    
    // Reduce operations
    // Python: sum = reduce(lambda x, y: x + y, list1)
    int sum = reduce_sum(list1, size);
    printf("\n\nReduce (sum) of List 1: %d", sum);
    
    // Python: product = reduce(lambda x, y: x * y, list1)
    int product = reduce_product(list1, size);
    printf("\nReduce (product) of List 1: %d", product);
    
    // Zip and sum operation
    // Python: [x + y for x, y in zip(list1, list2)]
    int zipped_sum[5];
    zip_and_sum(list1, list2, zipped_sum, size);
    printf("\n\nZipped sum of both lists: ");
    for(int i = 0; i < size; i++) printf("%d ", zipped_sum[i]);
    
    // List slicing
    int sliced[10];
    int slice_size;
    
    // Python: list1[1:4:1] (start=1, end=4, step=1)
    list_slice(list1, sliced, size, 1, 4, 1, &slice_size);
    printf("\n\nSlice list1[1:4:1]: ");
    for(int i = 0; i < slice_size; i++) printf("%d ", sliced[i]);
    
    // Python: list1[::2] (every second element)
    list_slice(list1, sliced, size, 0, size, 2, &slice_size);
    printf("\nSlice list1[::2]: ");
    for(int i = 0; i < slice_size; i++) printf("%d ", sliced[i]);
    
    printf("\n");
    return 0;
} 