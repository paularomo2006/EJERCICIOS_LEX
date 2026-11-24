/* Ejercicio 7 - Operadores aritméticos (+ - * /) y relacionales (< <= > >= == !=).
 * "<=" se reconoce antes que "<" porque Flex toma la coincidencia MÁS LARGA.
 * Los operandos (letras/dígitos) se ignoran; cualquier otro símbolo se reporta.
 *   flex ej07_operadores.l && gcc lex.yy.c -o ej07 -lfl && ./ej07 < entradas/ej07.txt
 */
%{
#include <stdio.h>
int n_arit = 0, n_rel = 0, n_otros = 0;
void arit(const char *nombre, const char *lex) { printf("OPERADOR ARITMETICO  %-16s : %s\n", nombre, lex); n_arit++; }
void rel (const char *nombre, const char *lex) { printf("OPERADOR RELACIONAL  %-16s : %s\n", nombre, lex); n_rel++; }
%}
%option noyywrap
%%
"+"                 arit("SUMA", yytext);
"-"                 arit("RESTA", yytext);
"*"                 arit("MULTIPLICACION", yytext);
"/"                 arit("DIVISION", yytext);
"<="                rel("MENOR_IGUAL", yytext);
">="                rel("MAYOR_IGUAL", yytext);
"=="                rel("IGUAL", yytext);
"!="                rel("DISTINTO", yytext);
"<"                 rel("MENOR", yytext);
">"                 rel("MAYOR", yytext);
[A-Za-z0-9_]+       ;   /* operandos: se ignoran */
[ \t\r\n]+          ;
.                   { printf("NO RECONOCIDO                           : %s\n", yytext); n_otros++; }
%%
int main(void)
{
    yylex();
    printf("\nResumen: %d aritméticos, %d relacionales, %d no reconocidos\n", n_arit, n_rel, n_otros);
    return 0;
}
