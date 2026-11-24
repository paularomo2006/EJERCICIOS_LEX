/* Ejercicio 6 - Identificadores, palabras reservadas (if, else, while, int) y enteros.
 * Orden de las reglas: "if" coincide con la regla de reservadas y con la de
 * identificadores con la MISMA longitud -> gana la que aparece primero.
 * "iffy" es más largo que "if" -> gana la regla de identificadores (coincidencia más larga).
 *   flex ej06_identificadores.l && gcc lex.yy.c -o ej06 -lfl && ./ej06 < entradas/ej06.txt
 */
%{
#include <stdio.h>
%}
%option noyywrap
DIGITO   [0-9]
LETRA    [a-zA-Z_]
%%
"if"|"else"|"while"|"int"        printf("<PALABRA_RESERVADA, %s>\n", yytext);
{LETRA}({LETRA}|{DIGITO})*       printf("<IDENTIFICADOR, %s>\n", yytext);
{DIGITO}+                        printf("<ENTERO, %s>\n", yytext);
[ \t\r\n]+                       ;
.                                printf("<SIMBOLO_NO_RECONOCIDO, %s>\n", yytext);
%%
int main(void)
{
    yylex();
    return 0;
}
