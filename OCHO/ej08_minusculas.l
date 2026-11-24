/* Ejercicio 8 - Normalización léxica: mayúsculas -> minúsculas.
 * Solo se reescribe lo que coincide con una regla; todo lo demás pasa sin cambios
 * gracias a la regla por defecto de Flex (ECHO).
 * Sumar 'a'-'A' (=32) a una mayúscula ASCII da su minúscula.
 * Para Á É Í Ó Ú Ñ (UTF-8: 0xC3 + byte 0x80-0x9E) se suma 0x20 al segundo byte.
 *   flex ej08_minusculas.l && gcc lex.yy.c -o ej08 -lfl && ./ej08 < entradas/ej08.txt
 */
%{
#include <stdio.h>
%}
%option noyywrap
%%
[A-Z]                          putchar(yytext[0] + ('a' - 'A'));
\xC3[\x80-\x96\x98-\x9E]       { putchar(0xC3); putchar(yytext[1] + 0x20); }
%%
int main(void)
{
    yylex();
    return 0;
}
