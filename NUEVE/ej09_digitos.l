/* Ejercicio 9 - Frecuencia de cada dígito (0-9) con tabla final.
 * El arreglo cuenta[] se indexa con el valor del dígito: yytext[0] - '0'.
 *   flex ej09_digitos.l && gcc lex.yy.c -o ej09 -lfl && ./ej09 < entradas/ej09.txt
 */
%{
#include <stdio.h>
int cuenta[10] = {0};
%}
%option noyywrap
%%
[0-9]       cuenta[yytext[0] - '0']++;
.|\n        ;      /* cualquier otro carácter se descarta */
%%
int main(void)
{
    int d, total = 0;
    yylex();
    printf("+--------+------------+\n");
    printf("| Dígito | Frecuencia |\n");
    printf("+--------+------------+\n");
    for (d = 0; d < 10; d++) {
        printf("|   %d    | %10d |\n", d, cuenta[d]);
        total += cuenta[d];
    }
    printf("+--------+------------+\n");
    printf("| TOTAL  | %10d |\n", total);
    printf("+--------+------------+\n");
    return 0;
}
