#ifndef graph_h
#define graph_h

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>

struct graphParse {
  uint8_t vertex;
  uint8_t origin;
  uint8_t outputCapacity;
  uint8_t edges;
  uint8_t** relations;
  uint8_t* output;
};

typedef struct graphParse GraphParse;

/* Lee el archivo incial */
void parse_puzzle(char* filename, GraphParse* NewGraph);


#endif /* end of include guard: graph_h */
