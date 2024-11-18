%{
#include <stdio.h>
#include <stdlib.h>

int line_number = 1; // Keeps track of the current line number
int error_found = 0; // Flag to indicate if an error was found
%}

%option noyywrap

%%

"if"|"else"|"int"|"float"|"char"|"void"    { /* Recognize keywords */ }
[a-zA-Z_][a-zA-Z0-9_]*                     { /* Recognize identifiers */ }
[0-9]+                                     { /* Recognize numbers */ }
"+"|"-"|"*"|"/"|"="|";"|"{"|"}"|"("|")"    { /* Recognize operators and delimiters */ }
"<"|">"|"=="|"!="|"<="|">="                { /* Recognize comparison operators */ }
[ \t]+                                     { /* Ignore spaces and tabs */ }
\n                                         { line_number++; } // Increment line number on newlines

.                                          { 
    printf("Lexical error found at line %d: %s\n", line_number, yytext); 
    error_found = 1; 
}

%%

int main() {
    printf("Enter your C program:\n");
    yylex();
    if (!error_found) {
        printf("Passed: No lexical errors found.\n");
    }
    return 0;
}
