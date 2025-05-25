#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_TOKEN_LEN 100

typedef enum {
    TOKEN_NUMBER,
    TOKEN_PLUS,
    TOKEN_MINUS,
    TOKEN_MULTIPLY,
    TOKEN_DIVIDE,
    TOKEN_LPAREN,
    TOKEN_RPAREN,
    TOKEN_EOF
} TokenType;

typedef struct {
    TokenType type;
    char value[MAX_TOKEN_LEN];
} Token;

Token currentToken;
const char* input;
int position = 0;

void getNextToken() {
    // Skip whitespace
    while (isspace(input[position])) {
        position++;
    }

    // Check for end of input
    if (input[position] == '\0') {
        currentToken.type = TOKEN_EOF;
        return;
    }

    // Handle numbers
    if (isdigit(input[position])) {
        int i = 0;
        while (isdigit(input[position])) {
            currentToken.value[i++] = input[position++];
        }
        currentToken.value[i] = '\0';
        currentToken.type = TOKEN_NUMBER;
        return;
    }

    // Handle operators and parentheses
    switch (input[position]) {
        case '+':
            currentToken.type = TOKEN_PLUS;
            currentToken.value[0] = '+';
            currentToken.value[1] = '\0';
            break;
        case '-':
            currentToken.type = TOKEN_MINUS;
            currentToken.value[0] = '-';
            currentToken.value[1] = '\0';
            break;
        case '*':
            currentToken.type = TOKEN_MULTIPLY;
            currentToken.value[0] = '*';
            currentToken.value[1] = '\0';
            break;
        case '/':
            currentToken.type = TOKEN_DIVIDE;
            currentToken.value[0] = '/';
            currentToken.value[1] = '\0';
            break;
        case '(':
            currentToken.type = TOKEN_LPAREN;
            currentToken.value[0] = '(';
            currentToken.value[1] = '\0';
            break;
        case ')':
            currentToken.type = TOKEN_RPAREN;
            currentToken.value[0] = ')';
            currentToken.value[1] = '\0';
            break;
        default:
            printf("Error: Invalid character '%c'\n", input[position]);
            exit(1);
    }
    position++;
}

void printToken(Token token) {
    switch (token.type) {
        case TOKEN_NUMBER:
            printf("NUMBER: %s\n", token.value);
            break;
        case TOKEN_PLUS:
            printf("PLUS: +\n");
            break;
        case TOKEN_MINUS:
            printf("MINUS: -\n");
            break;
        case TOKEN_MULTIPLY:
            printf("MULTIPLY: *\n");
            break;
        case TOKEN_DIVIDE:
            printf("DIVIDE: /\n");
            break;
        case TOKEN_LPAREN:
            printf("LPAREN: (\n");
            break;
        case TOKEN_RPAREN:
            printf("RPAREN: )\n");
            break;
        case TOKEN_EOF:
            printf("EOF\n");
            break;
    }
}

int main() {
    char buffer[256];
    printf("Enter an expression to tokenize: ");
    if (!fgets(buffer, sizeof(buffer), stdin)) {
        printf("Error reading input.\n");
        return 1;
    }
    // Remove trailing newline
    size_t len = strlen(buffer);
    if (len > 0 && buffer[len-1] == '\n') buffer[len-1] = '\0';
    input = buffer;
    position = 0;
    printf("\nTokenizing expression: %s\n\n", input);
    while (1) {
        getNextToken();
        printToken(currentToken);
        if (currentToken.type == TOKEN_EOF) {
            break;
        }
    }
    return 0;
} 