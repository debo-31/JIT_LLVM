#include <stdio.h>

void findDifference(int arr1[], int size1, int arr2[], int size2) {
    int found;

    printf("Elements in arr1 but not in arr2: ");
    for (int i = 0; i < size1; i++) {
        found = 0;
        for (int j = 0; j < size2; j++) {
            if (arr1[i] == arr2[j]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            printf("%d ", arr1[i]);
        }
    }
    printf("\n");

    printf("Elements in arr2 but not in arr1: ");
    for (int i = 0; i < size2; i++) {
        found = 0;
        for (int j = 0; j < size1; j++) {
            if (arr2[i] == arr1[j]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            printf("%d ", arr2[i]);
        }
    }
    printf("\n");
}

int jitentry() {
    int arr1[] = {1, 2, 3, 4, 5};
    int arr2[] = {4, 5, 6, 7};

    int size1 = sizeof(arr1) / sizeof(arr1[0]);
    int size2 = sizeof(arr2) / sizeof(arr2[0]);

    printf("Array 1: ");
    for (int i = 0; i < size1; i++) {
        printf("%d ", arr1[i]);
    }
    printf("\n");

    printf("Array 2: ");
    for (int i = 0; i < size2; i++) {
        printf("%d ", arr2[i]);
    }
    printf("\n");

    findDifference(arr1, size1, arr2, size2);

    return 0;
}
