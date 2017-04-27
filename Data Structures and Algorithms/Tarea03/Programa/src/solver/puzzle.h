#include "../watcher/watcher.h"
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include "inttypes.h"
#include "../helper/multinomial.h"

struct puzzle {
  uint8_t height;
  uint8_t width;
  uint8_t limit;
  uint8_t* activeColumns;
  uint8_t* activeRows;
  uint8_t** matrix;
  uint8_t** matrixFinal;
  uint8_t activeColumnQuantity;
  uint8_t activeRowQuantity;
  int instructions;
  int depth;
  bool* columns;
  bool* rows;
};

typedef struct puzzle Puzzle;

/* Lee el archivo incial */
void parse_puzzle(char* filename, Puzzle* NewPuzzle) {


  FILE* f = fopen(filename, "r");

  char buf[256];
  uint8_t height;
  uint8_t width;
  uint8_t limit;
  uint8_t activeColumnsAmount;
  uint8_t activeRowsAmount;

  //Recibe la palabra "HEIGHT"
  fscanf(f,"%s", buf);

  //Recibe el valor de HEIGHT
  fscanf(f, "%hhu", &height);
  NewPuzzle->height = height;

  //Recibe la palabra "WIDTH"
  fscanf(f,"%s", buf);

  //Recibe el valor de WIDTH
  fscanf(f, "%hhu", &width);
  NewPuzzle->width = width;

  //Recibe cantidad de columnas activas
  fscanf(f, "%hhu", &activeColumnsAmount);
  NewPuzzle->activeColumnQuantity = activeColumnsAmount;

  //Creamos arreglo con columnas activas
  NewPuzzle->activeColumns = malloc(sizeof(uint8_t)*activeColumnsAmount);
  for(int i = 0; i < activeColumnsAmount; i++)
  {
    fscanf(f, "%hhu", &NewPuzzle->activeColumns[i]);
  }

  //Recibe cantidad de filas activas
  fscanf(f, "%hhu", &activeRowsAmount);
  NewPuzzle->activeRowQuantity = activeRowsAmount;

  //Creamos arreglo con filas activas
  NewPuzzle->activeRows = malloc(sizeof(uint8_t)*activeRowsAmount);
  for(int i = 0; i < activeRowsAmount; i++)
  {
    fscanf(f, "%hhu", &NewPuzzle->activeRows[i]);
  }

  //Creamos la matriz inicial
  NewPuzzle->matrix = malloc(sizeof(uint8_t*)*height);
  for (int row = 0; row < height; row++) {
    NewPuzzle->matrix[row] = malloc(sizeof(uint8_t)*width);
    for (int col = 0; col < width; col++) {
      fscanf(f, "%hhu", &NewPuzzle->matrix[row][col]);
    }
  }

  //Recibe la palabra "LIMIT"
  fscanf(f,"%s", buf);

  //Recibe el valor de LIMIT
  fscanf(f, "%hhu", &limit);
  NewPuzzle->limit = limit;

  //Creamos la matriz final
  NewPuzzle->matrixFinal = malloc(sizeof(uint8_t*)*height);
  for (int row = 0; row < height; row++) {
    NewPuzzle->matrixFinal[row] = malloc(sizeof(uint8_t)*width);
    for (int col = 0; col < width; col++) {
      fscanf(f, "%hhu", &NewPuzzle->matrixFinal[row][col]);
    }
  }

  fclose(f);
}

/* Define arreglo de filas y columnas con su actividad*/
void defineColumnRowActivity(Puzzle* NewPuzzle) {

  NewPuzzle->rows = calloc(sizeof(bool),NewPuzzle->height);
  NewPuzzle->columns = calloc(sizeof(bool),NewPuzzle->width);

  for (int i = 0; i < NewPuzzle->height; i++) {
    NewPuzzle->rows[i] = false;
  }

  for (int j = 0; j < NewPuzzle->width; j++) {
    NewPuzzle->columns[j] = false;
  }

  for (int k = 0; k < NewPuzzle->activeRowQuantity; k++) {
    int row = NewPuzzle->activeRows[k];
    NewPuzzle->rows[row] = true;
  }

  for (int l = 0; l < NewPuzzle->activeColumnQuantity; l++) {
    int col = NewPuzzle->activeColumns[l];
    NewPuzzle->columns[col] = true;
  }

}

/* Realiza un shift en la matriz, recibiendo la dirección (Side) y la fila/columna respectiva (Num) */
void shiftMatrix(Puzzle* NewPuzzle, int Side, int Num) {

  //Left
  if (Side == 0) {
    uint8_t aux =  NewPuzzle->matrix[Num][0];
    for (int i = 0; i < NewPuzzle->width-1; i++) {
      NewPuzzle->matrix[Num][i] = NewPuzzle->matrix[Num][i+1];
    }
    NewPuzzle->matrix[Num][NewPuzzle->width-1] = aux;
  }

  //Up
  else if (Side == 1) {
    uint8_t aux =  NewPuzzle->matrix[0][Num];
    for (int i = 0; i < NewPuzzle->height-1; i++) {
      NewPuzzle->matrix[i][Num] = NewPuzzle->matrix[i+1][Num];
    }
    NewPuzzle->matrix[NewPuzzle->height-1][Num] = aux;
  }


  //Right
  else if (Side == 2) {
    uint8_t aux =  NewPuzzle->matrix[Num][NewPuzzle->width-1];
    for (int i = NewPuzzle->width-1; i > 0; i--) {
      NewPuzzle->matrix[Num][i] = NewPuzzle->matrix[Num][i-1];
    }
    NewPuzzle->matrix[Num][0] = aux;
  }

  //Down
  else if (Side == 3) {
    uint8_t aux =  NewPuzzle->matrix[NewPuzzle->height-1][Num];
    for (int i = NewPuzzle->height-1; i > 0; i--) {
      NewPuzzle->matrix[i][Num] = NewPuzzle->matrix[i-1][Num];
    }
    NewPuzzle->matrix[0][Num] = aux;
  }
}

/* Compara una matriz con su solucion final */
bool MatrixSolved(Puzzle* NewPuzzle) {
  int height = NewPuzzle->height;
  int width = NewPuzzle->width;
  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {
      if (NewPuzzle->matrix[i][j] != NewPuzzle->matrixFinal[i][j]) {
        return false;
      }
    }
  }
  return true;
}

/* Compara dos matrices */
bool compareMatrices(Puzzle* Puzzle1, Puzzle* Puzzle2) {
  uint8_t** matrix1 = Puzzle1->matrix;
  uint8_t** matrix2 = Puzzle2->matrix;

  int height = Puzzle1->height;
  int width = Puzzle1->width;

  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {
      if (matrix1[i][j] != matrix2[i][j]) {
        free(matrix1);
        free(matrix2);
        return false;
      }
    }
  }
  free(matrix1);
  free(matrix2);
  return true;
}

/* Imprimo las desiciones */
void printInstructions(int* sides, int* nums, int instructionQuantity) {

  for (int i = instructionQuantity-1; i >= 0; i--) {

    char dir;

    if (sides[i] == 0) {
      dir = 'L';
    }

    else if (sides[i] == 1) {
      dir = 'U';
    }

    else if (sides[i] == 2) {
      dir = 'R';
    }

    else {
      dir = 'D';
    }

    printf("%c %i\n", dir, nums[i]);
  }
}
