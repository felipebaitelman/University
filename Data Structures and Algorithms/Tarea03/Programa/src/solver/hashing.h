#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "time.h"
#include "puzzle.h"
#include <gmp.h>

struct node {
  mpz_t key;
  int depth;
  struct node *Next;
};

typedef struct node Node;

char* StringId;

static Node* NodeChain[15485863];

/* Transforma la matriz a un identificador único utilizando la librería de los numeros grandes */
void transfromMatrixToNumber(Puzzle* NewPuzzle) {

  uint32_t contador = 0;
  for(int row = 0; row < NewPuzzle->height; row++) {
    for(int col = 0; col < NewPuzzle->width; col++) {

      if(NewPuzzle->rows[row] == true || NewPuzzle->columns[col] == true){
        StringId[contador] = NewPuzzle->matrix[row][col] + '0';
        contador++;
      }
    }
  }
  StringId[contador] = 0;
}

void initString(Puzzle* Puzzle){
  StringId = malloc(sizeof(char)*(Puzzle->width*Puzzle->height+1));
}

/* Recibe un id de una key y retorna un key */
int hash(mpz_t key){
  mpz_t keyBig;
  mpz_init(keyBig);
  mpz_mod_ui(keyBig, key, 15485863);
  int keyInt = mpz_get_ui(keyBig);
  mpz_clear(keyBig);
  return keyInt;
}

/* Insertar un elemento en la tabla de hash */
void hashInsert(Puzzle* Puzzle){

    /* Obtenemos el id de la matriz */
    mpz_t key;
    mpz_init(key);
    transfromMatrixToNumber(Puzzle);
    mpz_init_set_str(key,StringId,9);

    /* Obtenemos el key de la tabla de hash para el id */
    int value = hash(key);

    /* Si el arreglo esta vacío */
    if(NodeChain[value] == NULL) {
        NodeChain[value] = malloc(sizeof(Node));
        mpz_init(NodeChain[value]->key);
        mpz_set(NodeChain[value]->key, key);
        NodeChain[value]->depth = Puzzle->depth;
        NodeChain[value]->Next = NULL;
        mpz_clear(key);
    }

    /* Si ya hay un elemento */
    else {
        Node* NewNode = malloc(sizeof(Node));
        NewNode->Next = NodeChain[value];
        NodeChain[value] = NewNode;
        mpz_init(NewNode->key);
        mpz_set(NewNode->key, key);
        NewNode->depth = Puzzle->depth;
        mpz_clear(key);
    }

}

/* Buscar un elemento en la tabla de Hash */
int hashSearch(Puzzle* Puzzle){

  /* Obtenemos el id de la matriz */
  mpz_t id;
  mpz_init(id);
  transfromMatrixToNumber(Puzzle);
  mpz_init_set_str(id,StringId,9);

  /* Obtenemos el key de la tabla de hash para el id */
  int key = hash(id);

  Node* NewNode = NodeChain[key];

  while(NewNode!=NULL){
      if(mpz_cmp(NewNode->key, id) == 0){
        if(NewNode->depth < Puzzle->depth){
          NewNode->depth = Puzzle->depth;
          //El nodo nuevo existe y esta a menor profundidad que el ultimo encontrado
          mpz_clear(id);
          return 0;
        }
        else {
          //El nodo nuevo existe y esta a mayor profundidad que el ultimo encontrado
          mpz_clear(id);
          return 1;
        }
      }
      NewNode = NewNode->Next;
  }
  //El nodo nuevo no existe
  mpz_clear(id);
  return 2;
}
