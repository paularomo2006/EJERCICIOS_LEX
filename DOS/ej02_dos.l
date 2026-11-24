/* Ejercicio 2 - dos.l : ejecución de órdenes (pare / inicio).
 *   flex ej02_dos.l && gcc lex.yy.c -o ej02 -lfl && ./ej02 < entradas/ej02.txt
 */
%{
#include <stdio.h>      /* necesario para printf */
%}
%%
pare     printf("Comando pare recibido\n");
inicio   printf("Comando inicio ejecutado\n");
%%
int main()
{
    yylex();
    return 0;
}
