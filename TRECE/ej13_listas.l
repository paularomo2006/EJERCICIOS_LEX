/* Ejercicio 13 - Listas separadas por comas (cada línea es una lista).
 * Elemento válido: identificador o entero. Cualquier otro token se reporta como ERROR.
 * Una variable 'esperando' recuerda si toca un elemento (1) o una coma (0), con lo
 * que también se detectan elementos vacíos (a,,b), comas finales y comas faltantes.
 *   flex ej13_listas.l && gcc lex.yy.c -o ej13 -lfl && ./ej13 < entradas/ej13.txt
 */
%{
#include <stdio.h>
int esperando = 1;                 /* 1: toca elemento; 0: toca coma o fin de línea */
int hay_tokens = 0, hubo_coma = 0; /* estado de la línea actual */
int elementos = 0, errores = 0, nlista = 0;

void error(const char *msg, const char *lex) { printf("  ERROR: %s '%s'\n", msg, lex); errores++; }

void elemento(const char *tipo, const char *lex)
{
    hay_tokens = 1;
    if (!esperando) error("falta coma antes de", lex);
    printf("  %-13s : %s\n", tipo, lex);
    elementos++;
    esperando = 0;
}

void ocupa_lugar(void) { hay_tokens = 1; esperando = 0; }   /* un token inválido ocupa un elemento */

void fin_lista(void)
{
    if (!hay_tokens) return;
    if (esperando && hubo_coma) error("la lista termina en coma", ",");
    printf("-> Lista %d: %d elemento(s) válidos, %d error(es)\n", ++nlista, elementos, errores);
    esperando = 1; hay_tokens = 0; hubo_coma = 0; elementos = 0; errores = 0;
}
%}
%option noyywrap
ID       [A-Za-z_][A-Za-z0-9_]*
ENTERO   [0-9]+
%%
{ID}                  elemento("IDENTIFICADOR", yytext);
{ENTERO}              elemento("ENTERO", yytext);
","                   { hay_tokens = 1; hubo_coma = 1;
                        if (esperando) error("elemento vacío antes de", ",");
                        esperando = 1; }
{ENTERO}\.{ENTERO}    { error("número real no permitido", yytext); ocupa_lugar(); }
{ENTERO}{ID}          { error("identificador mal formado", yytext); ocupa_lugar(); }
[ \t\r]+              ;
\n                    fin_lista();
.                     { error("símbolo no permitido", yytext); ocupa_lugar(); }
%%
int main(void)
{
    yylex();
    fin_lista();       /* por si la última línea no termina en salto de línea */
    return 0;
}
