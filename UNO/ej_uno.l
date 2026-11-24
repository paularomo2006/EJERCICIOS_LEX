/* Ejercicio 1 - uno.l : programa mínimo en Lex/Flex.
 * Solo contiene el separador %%: no hay reglas, así que Flex aplica la
 * regla por defecto (copiar la entrada a la salida: ECHO).
 * main() y yywrap() los aporta la biblioteca libfl (por eso se enlaza con -lfl).
 *   flex ej01_uno.l && gcc lex.yy.c -o ej01 -lfl && ./ej01
 */
%%
