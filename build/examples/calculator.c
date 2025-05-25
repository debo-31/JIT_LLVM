#include <stdio.h>

double calculate(double a, double b, char op) {
    switch(op) {
        case '+': return a + b;
        case '-': return a - b;
        case '*': return a * b;
        case '/': return b != 0 ? a / b : 0;
        default: return 0;
    }
}

int jitentry() {
    double num1, num2;
    char operator;
    int continue_calc = 1;

    while (continue_calc) {
        printf("\nEnter calculation (number operator number, e.g., 5 + 3): ");
        scanf("%lf %c %lf", &num1, &operator, &num2);

        double result = calculate(num1, num2, operator);
        printf("%.2f %c %.2f = %.2f\n", num1, operator, num2, result);

        printf("\nDo you want to calculate again? (1 for yes, 0 for no): ");
        scanf("%d", &continue_calc);
    }

    printf("Thank you for using the calculator!\n");
    return 0;
} 