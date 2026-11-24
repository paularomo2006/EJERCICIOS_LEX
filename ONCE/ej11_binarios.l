/* Ejercicio 11 - Números binarios (secuencias de 0 y 1) y su valor decimal.
 * Conversión (método de Horner): valor = valor*2 + bit, recorriendo yytext.
 * Una secuencia como 1012 coincide más largo con [0-9]+ que con [01]+ -> NO_BINARIO.
 *   flex ej11_binarios.l && gcc lex.yy.c -o ej11 -lfl && ./ej11 < entradas/ej11.txt
 */
%{
#include <stdio.h>
%}
%option noyywrap
%%
[01]+     {
              unsigned long long v = 0;
              int i, desborda = 0;
              for (i = 0; i < yyleng; i++) {
                  if (v >> 63) desborda = 1;
                  v = (v << 1) | (unsigned long long)(yytext[i] - '0');
              }
              if (desborda) printf("BINARIO %-20s = (excede 64 bits)\n", yytext);
              else          printf("BINARIO %-20s = %llu\n", yytext, v);
          }
[0-9]+    printf("NO_BINARIO %-17s (tiene dígitos distintos de 0 y 1)\n", yytext);
.|\n      ;
%%
int main(void)
{
    yylex();
    return 0;
}
