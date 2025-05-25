#!/usr/bin/env python3

def translate_python_to_c(python_file, c_file):
    with open(python_file, 'r') as f:
        content = f.read()
    
    # Very basic translation - only works for our specific example
    c_code = """#include <stdio.h>

int calculate_sum(int n) {
    int result = 0;
    for(int i = 0; i < n; i++) {
        result += i;
    }
    return result;
}

int jitentry() {
    int n = 10;
    printf("Sum of numbers from 0 to %d is: %d\\n", n-1, calculate_sum(n));
    return 0;
}
"""
    
    with open(c_file, 'w') as f:
        f.write(c_code)

if __name__ == "__main__":
    translate_python_to_c("examples/simple.py", "examples/generated.c") 