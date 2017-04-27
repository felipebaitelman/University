#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <stdbool.h>
#include <math.h>
#include "heap.h"
#include "graph.h"

// A structure to represent a node in adjacency list
struct AdjListNode
{
    int dest;
    int weight;
    struct AdjListNode* next;
};

// A structure to represent an adjacency liat
struct AdjList
{
    struct AdjListNode *head;  // pointer to head node of list
};

// A structure to represent a graph. A graph is an array of adjacency lists.
// Size of array will be V (number of vertices in graph)
struct Graph
{
    int V;
    struct AdjList* array;
};

struct Result
{
    int* arr;
    int n;
    int* key;
};

typedef struct Result RealResult;

// A utility function to create a new adjacency list node
struct AdjListNode* newAdjListNode(int dest, int weight)
{
    struct AdjListNode* newNode =
            (struct AdjListNode*) malloc(sizeof(struct AdjListNode));
    newNode->dest = dest;
    newNode->weight = weight;
    newNode->next = NULL;
    return newNode;
}

// A utility function that creates a graph of V vertices
struct Graph* createGraph(int V)
{
    struct Graph* graph = (struct Graph*) malloc(sizeof(struct Graph));
    graph->V = V;

    // Create an array of adjacency lists.  Size of array will be V
    graph->array = (struct AdjList*) malloc(V * sizeof(struct AdjList));

     // Initialize each adjacency list as empty by making head as NULL
    for (int i = 0; i < V; ++i)
        graph->array[i].head = NULL;

    return graph;
}

// Adds an edge to an undirected graph
void addEdge(struct Graph* graph, int src, int dest, int weight)
{
    // Add an edge from src to dest.  A new node is added to the adjacency
    // list of src.  The node is added at the begining
    struct AdjListNode* newNode = newAdjListNode(dest, weight);
    newNode->next = graph->array[src].head;
    graph->array[src].head = newNode;

    // Since graph is undirected, add an edge from dest to src also
    newNode = newAdjListNode(src, weight);
    newNode->next = graph->array[dest].head;
    graph->array[dest].head = newNode;
}

struct Vertex
{
  int v;
  int key;
};

// A utility function to create a new Min Heap Node
struct Vertex* newVertex(int v, int key)
{
    struct  Vertex* NewVertex =
           (struct Vertex*) malloc(sizeof(struct Vertex));
    NewVertex->v = v;
    NewVertex->key = key;
    return NewVertex;
}

// A utility function used to print the constructed MST
void printArr(int arr[], int n, int key[], GraphParse* graph)
{
    for (int i = 0; i < n; ++i) {
      for (int e = 0; e < graph->edges; e++) {
        if ((graph->relations[e][3] == key[i] && graph->relations[e][1] == arr[i] && graph->relations[e][2] == i) || (graph->relations[e][3] == key[i] && graph->relations[e][1] == i && graph->relations[e][2] == arr[i])){
          printf("%i\n", graph->relations[e][0]);
        }
      }
    }
}


bool isInMaxHeap(Heap* maxHeap, int v)
{
  for (size_t i = 0; i < maxHeap->count; i++) {
    struct Vertex* vertex = maxHeap->array[i].content;
    if(vertex->v == v) return true;
  }
  return false;
}


// The main function that constructs Minimum Spanning Tree (MST)
// using Prim's algorithm
void PrimMST(struct Graph* graph, GraphParse* initialGraph)
{
    int V = graph->V;// Get the number of vertices in graph
    int parent[V];   // Array to store constructed MST
    int key[V];      // Key values used to pick minimum weight edge in cut


    Heap* maxHeap = heap_init(V);

    // Initialize min heap with all vertices. Key value of
    // all vertices (except 0th vertex) is initially infinite
    for (int v = 1; v < V; ++v)
    {
        parent[v] = -1;
        key[v] = 0;
        heap_insert(maxHeap, newVertex(v, key[v]), key[v]);
    }

    // Make key value of 0th vertex as 0 so that it
    // is extracted first
    key[0] = INFINITY;
    heap_insert(maxHeap, newVertex(0, key[0]), key[0]);

    // In the followin loop, min heap contains all nodes
    // not yet added to MST.
    while (!heap_is_empty(maxHeap))
    {
        // Extract the vertex with minimum key value
        struct Vertex* maxHeapNode = heap_extract(maxHeap);

        int u = maxHeapNode->v; // Store the extracted vertex number

        // Traverse through all adjacent vertices of u (the extracted
        // vertex) and update their key values
        struct AdjListNode* pCrawl = graph->array[u].head;
        while (pCrawl != NULL)
        {
            int v = pCrawl->dest;

            // If v is not yet included in MST and weight of u-v is
            // more than key value of v, then update key value and
            // parent of v
            if (isInMaxHeap(maxHeap, pCrawl->dest) && pCrawl->weight > key[v])
            {
                key[v] = pCrawl->weight;
                parent[v] = u;

                size_t var = 0;
                int index = pCrawl->dest;
                for (int i = 0; i < maxHeap->count; i++) {
                  struct Vertex* newVertex = maxHeap->array[i].content;
                  if (index == newVertex->v) {
                    var = *maxHeap->array[i].index;
                  }
                }

                heap_update_key(maxHeap, var, key[v]);
            }
            pCrawl = pCrawl->next;
        }
    }

    // print edges of MST
    printArr(parent, V, key, initialGraph);
}
