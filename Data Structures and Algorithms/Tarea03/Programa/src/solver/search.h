#include "../watcher/watcher.h"
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include "hashing.h"
#include "inttypes.h"
#include "../helper/multinomial.h"

/* Implementacion de DFS */
bool DFS(Puzzle* NewPuzzle, int depth, int* sides, int* nums) {

  NewPuzzle->depth = depth;

  int height = NewPuzzle->height;
  int width = NewPuzzle->width;

  /* Seccion del codigo que implementa Tabla de Hash */
  int search = hashSearch(NewPuzzle);

  if(search == 1){
    return false;
  }

  else if (search == 2){
    hashInsert(NewPuzzle);
  }
  /* Seccion del codigo que implementa Tabla de Hash */
  
  if (depth == 0) {
    if (MatrixSolved(NewPuzzle)) {
      return true;
    }
    else return false;
  }

  if (depth > 0) {

    //Recorremos filas
    for (int i = 0; i < height; i++) {

      if (NewPuzzle->rows[i] == true) {

        //Recorremos hacia la izquierda
        shiftMatrix(NewPuzzle, 0, i);
        if (!DFS(NewPuzzle, depth-1, sides, nums)) {
          shiftMatrix(NewPuzzle, 2, i);
        }
        else {
          sides[NewPuzzle->instructions] = 0;
          nums[NewPuzzle->instructions] = i;
          NewPuzzle->instructions++;
          return true;
        }

        //Recorremos hacia la derecha
        shiftMatrix(NewPuzzle, 2, i);
        if (!DFS(NewPuzzle, depth-1, sides, nums)) {
          shiftMatrix(NewPuzzle, 0, i);
        }
        else {
          sides[NewPuzzle->instructions] = 2;
          nums[NewPuzzle->instructions] = i;
          NewPuzzle->instructions++;
          return true;
        }
      }
    }

    //Recorremos columnas
    for (int j = 0; j < width; j++) {

      if (NewPuzzle->columns[j] == true) {

        //Recorremos hacia arriba
        shiftMatrix(NewPuzzle, 1, j);
        if (!DFS(NewPuzzle, depth-1, sides, nums)) {
          shiftMatrix(NewPuzzle, 3, j);
        }
        else {
          sides[NewPuzzle->instructions] = 1;
          nums[NewPuzzle->instructions] = j;
          NewPuzzle->instructions++;
          return true;
        }

        //Recorremos hacia abajo
        shiftMatrix(NewPuzzle, 3, j);
        if (!DFS(NewPuzzle, depth-1, sides, nums)) {
          shiftMatrix(NewPuzzle, 1, j);
        }
        else {
          sides[NewPuzzle->instructions] = 3;
          nums[NewPuzzle->instructions] = j;
          NewPuzzle->instructions++;
          return true;
        }
      }
    }
  }
  return false;
}

/* Implementacion de IDDFS*/
bool IDDFS(Puzzle* NewPuzzle, int* sides, int*nums) {

  NewPuzzle->instructions = 0;
  int depth = NewPuzzle->limit;
  bool solution = false;

  for (int i = 1; i <= depth; i++) {
    solution = DFS(NewPuzzle, i, sides, nums);
    if(solution){
      return solution;
    }
  }

  return solution;
}
