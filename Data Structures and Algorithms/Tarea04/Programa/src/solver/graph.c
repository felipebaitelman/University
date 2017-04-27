#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include "graph.h"


/* Lee el archivo incial */
void parse_puzzle(char* filename, GraphParse* NewGraph) {

  FILE* f = fopen(filename, "r");

  char buf[256];
  uint8_t vertex;
  uint8_t origin;
  uint8_t outputCapacity;
  uint8_t edges;

  //Recibe la letra "V"
  fscanf(f,"%s", buf);

  //Recibe el valor de V
  fscanf(f, "%hhu", &vertex);
  NewGraph->vertex = vertex;

  //Recibe la letra "F"
  fscanf(f,"%s", buf);

  //Recibe el valor de F
  fscanf(f, "%hhu", &origin);
  NewGraph->origin = origin;

  //Recibe la letra "K"
  fscanf(f,"%s", buf);

  //Recibe el valor de F
  fscanf(f, "%hhu", &outputCapacity);
  NewGraph->outputCapacity = outputCapacity;

  //Recibe la letra "E"
  fscanf(f,"%s", buf);

  //Recibe el valor de E
  fscanf(f, "%hhu", &edges);
  NewGraph->edges = edges;

  //Creamos el gráfico de relaciones
  NewGraph->relations = malloc(sizeof(uint8_t*)*edges);
  for (int e = 0; e < edges; e++) {
    NewGraph->relations[e] = malloc(sizeof(uint8_t)*4);
    for (int i = 0; i < 4; i++) {
      fscanf(f, "%hhu", &NewGraph->relations[e][i]);
    }
  }

  fclose(f);
}
