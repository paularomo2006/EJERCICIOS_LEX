/* Ejercicio 5 - Clasificación de caracteres (mayúsculas, minúsculas, dígitos, espacios).
 * Es la etapa previa a formar tokens: cada carácter se asigna a una clase
 * (letra, dígito, espacio, otro) y recién después se agrupan en lexemas.
 * Las letras acentuadas UTF-8 (2 bytes: 0xC3 + byte) se cuentan como una sola letra.
 *   flex ej05_clasificacion.l && gcc lex.yy.c -o ej05 -lfl && ./ej05 < entradas/ej05.txt
 */
%{
#include <stdio.h>
int mayus = 0, minus = 0, digitos = 0, espacios = 0, saltos = 0, otros = 0;
%}
%option noyywrap
%%
[A-Z]                         mayus++;
[a-z]                         minus++;
[0-9]                         digitos++;
[ \t]                         espacios++;
\n                            saltos++;
\xC3[\x80-\x96\x98-\x9E]      mayus++;    /* À-Þ en UTF-8 (sin ×) */
\xC3[\x9F-\xB6\xB8-\xBF]      minus++;    /* ß-ÿ en UTF-8 (sin ÷) */
.                             otros++;
%%
int main(void)
{
    yylex();
    printf("+-------------------------+-------+\n");
    printf("| Clase de carácter       | Total |\n");
    printf("+-------------------------+-------+\n");
    printf("| Letras mayúsculas       | %5d |\n", mayus);
    printf("| Letras minúsculas       | %5d |\n", minus);
    printf("| Dígitos                 | %5d |\n", digitos);
    printf("| Espacios (' ' y tab)    | %5d |\n", espacios);
    printf("| Saltos de línea         | %5d |\n", saltos);
    printf("| Otros (signos, etc.)    | %5d |\n", otros);
    printf("+-------------------------+-------+\n");
    return 0;
}
