/* Ejercicio 4 - cuatro.l : números, identificadores y reales en notación exponencial.
 * Patrón de real:  [+-]? dígitos . dígitos ([eE][+-]?dígitos)?   |   [+-]? dígitos [eE][+-]?dígitos
 * El real exige parte fraccionaria o exponente para no confundirse con NUMERO.
 *   flex ej04_cuatro.l && gcc lex.yy.c -o ej04 -lfl && ./ej04 < entradas/ej04.txt
 */
%{
#include <stdio.h>
#include <stdlib.h>
%}
DIGITO   [0-9]
LETRA    [a-zA-Z]
EXP      [eE][+-]?{DIGITO}+
%%
{DIGITO}+                             printf("NUMERO        : %s\n", yytext);
{LETRA}({LETRA}|{DIGITO})*            printf("IDENTIFICADOR : %s\n", yytext);
[+-]?{DIGITO}+\.{DIGITO}+({EXP})?     printf("REAL          : %s\n", yytext);
[+-]?{DIGITO}+{EXP}                   printf("REAL          : %s\n", yytext);
[ \t\r\n]+                            ;   /* se ignoran los espacios en blanco */
.                                     printf("SIMBOLO       : %s\n", yytext);
%%
int main()
{
    yylex();
    return 0;
}
