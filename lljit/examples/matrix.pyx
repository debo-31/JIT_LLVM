# cython: language_level=3
import cython

@cython.boundscheck(False)
@cython.wraparound(False)
def matrix_multiply(double[:, :] A, double[:, :] B):
    cdef int m = A.shape[0]
    cdef int n = A.shape[1]
    cdef int p = B.shape[1]
    
    # Create result matrix
    cdef double[:, :] C = cython.zeros((m, p), dtype=cython.double)
    
    cdef int i, j, k
    cdef double temp
    
    for i in range(m):
        for j in range(p):
            temp = 0
            for k in range(n):
                temp += A[i, k] * B[k, j]
            C[i, j] = temp
    
    return C

def jitentry():
    # Example matrices
    A = [[1, 2], [3, 4]]
    B = [[5, 6], [7, 8]]
    
    result = matrix_multiply(A, B)
    
    print("Matrix A:")
    for row in A:
        print(row)
    
    print("\nMatrix B:")
    for row in B:
        print(row)
    
    print("\nResult:")
    for i in range(len(result)):
        print([result[i][j] for j in range(len(result[0]))])
    
    return 0 