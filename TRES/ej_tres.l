/* Ejercicio 3 - tres.l : contador de líneas y caracteres.
 * Variables globales numlin y numcar, definidas en la sección de declaraciones.
 * Nota: aquí el salto de línea cuenta como carácter (igual que wc -c).
 * En las diapositivas la regla [\n] solo incrementa numlin.
 *   flex ej03_tres.l && gcc lex.yy.c -o ej03 -lfl && ./ej03 < entradas/ej03.txt
 */
%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
int numlin = 0, numcar = 0;
%}
%%
\n      { numlin++; numcar++; }
.       { numcar++; }
%%
int main()
{
    yylex();
    printf("Número de líneas: %d\n", numlin);
    printf("Número de caracteres: %d\n", numcar);
    return 0;
}
