#include "../watcher/watcher.h"
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include "search.h"
#include "inttypes.h"
#include "../helper/multinomial.h"
#include <gmp.h>
#include <time.h>

/* Main */
int main(int argc, char *argv[]) {

  /* Permite imprimir el tiempo */
  // clock_t start = clock(), diff;
  /* Permite imprimir el tiempo */

  /* Creamos un nuevo puzle */
  Puzzle* NewPuzzle = malloc(sizeof(Puzzle));

  /* Parseamos el puzzle inicial */
  parse_puzzle(argv[1], NewPuzzle);

  /* Definimos la actividad de las columnas */
  defineColumnRowActivity(NewPuzzle);

  /* Inicializamos el string identificador de matrices */
  initString(NewPuzzle);

  /* Instrucciones que resuelven el puzzle */
  int* sides = malloc(sizeof(int)*NewPuzzle->limit);
  int* nums = malloc(sizeof(int)*NewPuzzle->limit);;


  /* Resolvemos el puzle utilizando IDDFS */
  IDDFS(NewPuzzle, sides, nums);

  /* Imprimimos las instrucciones */
  printInstructions(sides, nums, NewPuzzle->instructions);

  /* WATCHER */
  // watcher_open(argv[1]);
  //
  // int value = 0;
  //
  // for(int row = 0; row < NewPuzzle->height; row++)
  // {
  //   for(int col = 0; col < NewPuzzle->width; col++)
  //   {
  //     watcher_update_cell(
  //       row,
  //       col,
  //       NewPuzzle->matrix[row][col]);
  //     value++;
  //   }
  // }
  //watcher_close();
  /* WATCHER */


  free(NewPuzzle->activeColumns);
  free(NewPuzzle->activeRows);
  free(NewPuzzle->columns);
  free(NewPuzzle->rows);
  free(NewPuzzle->matrix);
  free(NewPuzzle->matrixFinal);
  free(sides);
  free(nums);
  free(StringId);
  free(NewPuzzle);

  /* Permite imprimir el tiempo */
  // diff = clock() - start;
  // int msec = diff * 1000 / CLOCKS_PER_SEC;
  // printf("Time taken %d seconds %d milliseconds", msec/1000, msec%1000);
  /* Permite imprimir el tiempo */

  return 0;
}
