#include <stdio.h>

#define N 2  // Size of the matrices (2x2)

void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            C[i][j] = 0;
            for(int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

void print_matrix(int matrix[N][N]) {
    for(int i = 0; i < N; i++) {
        printf("[");
        for(int j = 0; j < N; j++) {
            printf("%d", matrix[i][j]);
            if(j < N-1) printf(", ");
        }
        printf("]\n");
    }
}

int jitentry() {
    int A[N][N], B[N][N], C[N][N];
    printf("Enter elements for Matrix A (2x2):\n");
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            printf("A[%d][%d]: ", i, j);
            scanf("%d", &A[i][j]);
        }
    }
    printf("\nEnter elements for Matrix B (2x2):\n");
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            printf("B[%d][%d]: ", i, j);
            scanf("%d", &B[i][j]);
        }
    }
    printf("\nMatrix A:\n");
    print_matrix(A);
    printf("\nMatrix B:\n");
    print_matrix(B);
    matrix_multiply(A, B, C);
    printf("\nResult Matrix C = A × B:\n");
    print_matrix(C);
    return 0;
} 