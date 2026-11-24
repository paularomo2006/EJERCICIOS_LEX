/* Ejercicio 10 - Detección de correos electrónicos simples (nombre@dominio.com).
 * CORREO_VALIDO : usuario @ etiqueta(.etiqueta)* . TLD de >= 2 letras
 * CORREO_INVALIDO: tiene usuario@dominio pero le falta un TLD válido.
 * Ambos patrones pueden coincidir con la misma longitud: gana el primero (el válido).
 *   flex ej10_correos.l && gcc lex.yy.c -o ej10 -lfl && ./ej10 < entradas/ej10.txt
 */
%{
#include <stdio.h>
int validos = 0, invalidos = 0;
%}
%option noyywrap
USUARIO    [A-Za-z0-9._%+-]+
ETIQUETA   [A-Za-z0-9-]+
%%
{USUARIO}@{ETIQUETA}(\.{ETIQUETA})*\.[A-Za-z]{2,}     { printf("CORREO_VALIDO   : %s\n", yytext); validos++; }
{USUARIO}@({ETIQUETA}(\.{ETIQUETA})*)?                { printf("CORREO_INVALIDO : %s\n", yytext); invalidos++; }
.|\n                                                  ;
%%
int main(void)
{
    yylex();
    printf("\nTotal: %d válido(s), %d inválido(s)\n", validos, invalidos);
    return 0;
}
