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

// Forward declarations
void getNextToken();
void printToken(Token token);
int expr();
int term();
int factor();

// AST node definition
typedef struct ASTNode {
    char label[64];
    struct ASTNode *left;
    struct ASTNode *right;
} ASTNode;

ASTNode* createNode(const char* label, ASTNode* left, ASTNode* right) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    strcpy(node->label, label);
    node->left = left;
    node->right = right;
    return node;
}

void printAST(ASTNode* node, int depth) {
    if (!node) return;
    for (int i = 0; i < depth; i++) printf("  ");
    printf("%s\n", node->label);
    printAST(node->left, depth + 1);
    printAST(node->right, depth + 1);
}

// Modified parser functions to build AST
ASTNode* factorAST();
ASTNode* termAST();
ASTNode* exprAST();

ASTNode* factorAST() {
    ASTNode* node = NULL;
    if (currentToken.type == TOKEN_NUMBER) {
        node = createNode(currentToken.value, NULL, NULL);
        getNextToken();
    } else if (currentToken.type == TOKEN_LPAREN) {
        getNextToken();
        node = exprAST();
        if (currentToken.type != TOKEN_RPAREN) {
            printf("Error: Expected ')'\n");
            exit(1);
        }
        getNextToken();
    } else {
        printf("Error: Expected number or '('\n");
        exit(1);
    }
    return node;
}

ASTNode* termAST() {
    ASTNode* node = factorAST();
    while (currentToken.type == TOKEN_MULTIPLY || currentToken.type == TOKEN_DIVIDE) {
        char op[2] = {0};
        op[0] = (currentToken.type == TOKEN_MULTIPLY) ? '*' : '/';
        getNextToken();
        node = createNode(op, node, factorAST());
    }
    return node;
}

ASTNode* exprAST() {
    ASTNode* node = termAST();
    while (currentToken.type == TOKEN_PLUS || currentToken.type == TOKEN_MINUS) {
        char op[2] = {0};
        op[0] = (currentToken.type == TOKEN_PLUS) ? '+' : '-';
        getNextToken();
        node = createNode(op, node, termAST());
    }
    return node;
}

int evalAST(ASTNode* node) {
    if (!node->left && !node->right) {
        return atoi(node->label);
    }
    int left = evalAST(node->left);
    int right = evalAST(node->right);
    switch (node->label[0]) {
        case '+': return left + right;
        case '-': return left - right;
        case '*': return left * right;
        case '/': return right != 0 ? left / right : 0;
    }
    return 0;
}

void freeAST(ASTNode* node) {
    if (!node) return;
    freeAST(node->left);
    freeAST(node->right);
    free(node);
}

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

// Grammar:
// expr   : term ((PLUS | MINUS) term)*
// term   : factor ((MULTIPLY | DIVIDE) factor)*
// factor : NUMBER | LPAREN expr RPAREN

int factor() {
    int result;
    
    if (currentToken.type == TOKEN_NUMBER) {
        result = atoi(currentToken.value);
        getNextToken();
    } else if (currentToken.type == TOKEN_LPAREN) {
        getNextToken();
        result = expr();
        if (currentToken.type != TOKEN_RPAREN) {
            printf("Error: Expected ')'\n");
            exit(1);
        }
        getNextToken();
    } else {
        printf("Error: Expected number or '('\n");
        exit(1);
    }
    
    return result;
}

int term() {
    int result = factor();
    
    while (currentToken.type == TOKEN_MULTIPLY || currentToken.type == TOKEN_DIVIDE) {
        TokenType op = currentToken.type;
        getNextToken();
        
        if (op == TOKEN_MULTIPLY) {
            result *= factor();
        } else {
            int divisor = factor();
            if (divisor == 0) {
                printf("Error: Division by zero\n");
                exit(1);
            }
            result /= divisor;
        }
    }
    
    return result;
}

int expr() {
    int result = term();
    
    while (currentToken.type == TOKEN_PLUS || currentToken.type == TOKEN_MINUS) {
        TokenType op = currentToken.type;
        getNextToken();
        
        if (op == TOKEN_PLUS) {
            result += term();
        } else {
            result -= term();
        }
    }
    
    return result;
}

void printASTPretty(ASTNode* node, const char* prefix, int isLeft) {
    if (!node) return;
    printf("%s", prefix);
    printf("%s", isLeft ? "├── " : "└── ");
    printf("%s\n", node->label);
    char newPrefix[256];
    strcpy(newPrefix, prefix);
    strcat(newPrefix, isLeft ? "│   " : "    ");
    if (node->left) printASTPretty(node->left, newPrefix, 1);
    if (node->right) printASTPretty(node->right, newPrefix, 0);
}

int main() {
    char buffer[256];
    printf("Enter an arithmetic expression: ");
    if (!fgets(buffer, sizeof(buffer), stdin)) {
        printf("Error reading input.\n");
        return 1;
    }
    // Remove trailing newline
    size_t len = strlen(buffer);
    if (len > 0 && buffer[len-1] == '\n') buffer[len-1] = '\0';
    input = buffer;
    position = 0;
    getNextToken();
    ASTNode* ast = exprAST();
    printf("\nAST:\n");
    printASTPretty(ast, "", 0);
    int result = evalAST(ast);
    printf("\nResult: %d\n", result);
    freeAST(ast);
    return 0;
} 