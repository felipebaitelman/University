#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h> 
#include "graph.h"
#include "prim.h"

/* Función para imprimir */
void printGraph(GraphParse* NewGraph) {
  printf("V %hhu\n",NewGraph->vertex);
  printf("F %hhu\n",NewGraph->origin);
  printf("K %hhu\n",NewGraph->outputCapacity);
  printf("E %hhu\n",NewGraph->edges);

  for (int e = 0; e < NewGraph->edges; e++) {
    for (int i = 0; i < 4; i++) {
      printf("%hhu " "",NewGraph->relations[e][i]);
    }
    printf("\n");
  }
}

/* Main */
int main(int argc, char *argv[]) {

  /* Creamos un nuevo puzle */
  GraphParse* NewGraph = malloc(sizeof(GraphParse));

  /* Parseamos el gráfico inicial */
  parse_puzzle(argv[1], NewGraph);

  /* Imprimimos el gráfico */
  //printGraph(NewGraph);

  int V = NewGraph->vertex;
  struct Graph* graph = createGraph(V);

  for (int e = 0; e < NewGraph->edges; e++) {
    addEdge(graph, NewGraph->relations[e][1], NewGraph->relations[e][2], NewGraph->relations[e][3]);
  }

  PrimMST(graph, NewGraph);



  return 0;


}
