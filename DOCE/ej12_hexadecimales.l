/* Ejercicio 12 - Números hexadecimales tipo 0x1A3F y su valor decimal.
 * Patrón válido: 0 [xX] seguido de >= 1 dígito hexadecimal.
 * Patrón de error: 0x seguido de cualquier alfanumérico (0x1G, 0x). Con igual
 * longitud gana el primero (válido); con más caracteres gana el de error.
 *   flex ej12_hexadecimales.l && gcc lex.yy.c -o ej12 -lfl && ./ej12 < entradas/ej12.txt
 */
%{
#include <stdio.h>
int valor_hex(char c) { return (c <= '9') ? c - '0' : (c | 0x20) - 'a' + 10; }
%}
%option noyywrap
HEXDIG   [0-9A-Fa-f]
%%
0[xX]{HEXDIG}+       {
                         unsigned long long v = 0;
                         int i, desborda = 0;
                         for (i = 2; i < yyleng; i++) {
                             if (v >> 60) desborda = 1;
                             v = (v << 4) | (unsigned long long)valor_hex(yytext[i]);
                         }
                         if (desborda) printf("HEXADECIMAL %-14s = (excede 64 bits)\n", yytext);
                         else          printf("HEXADECIMAL %-14s = %llu\n", yytext, v);
                     }
0[xX][0-9A-Za-z]*    printf("HEX_INVALIDO %s\n", yytext);
.|\n                 ;
%%
int main(void)
{
    yylex();
    return 0;
}
