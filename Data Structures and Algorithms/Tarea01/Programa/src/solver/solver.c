#include "../common/city.h"
#include <stdio.h>
#include "../common/stack.h"
#include <time.h>
#include <stdlib.h>



//Se crea una estructura auxiliar, para poder tener tuplas de edificios
struct BuildingTuple {
    Building* b1;
    Building* b2;
};

//Se define un metodo para incializar la estructura de tuplas
struct BuildingTuple* Building_Tuple_Create(Building* newb1, Building* newb2) {
    struct BuildingTuple* tuple = malloc(sizeof(struct BuildingTuple));
    tuple->b1 = newb1;
    tuple->b2 = newb2;
    return tuple;
}

//Typdef de la estructura de tuplas
typedef struct BuildingTuple Building_Pair;

// Funcion que resuelve el camino para un core de forma recursiva.
void SolveMapRecursive(Core* core_building, Building* new, Stack* solve, int goingBack, int previousIndex){

  Core* coreBuilding = core_building;
  Building* first = new -> linked[0];
  Building* next = NULL;
  int back = goingBack;

  //Setea una variable auxiliar para fijar el inicio del for.
  int preIndex = 0;
  if (back == 0) {
    preIndex = 0;
  }
  else {
    preIndex = previousIndex + 1;
  }

  //Si el indice actual es más grande que la cantidad de cores en la zona, se vuelve a entrar en la recursión.
  /*
  if(preIndex == first->zone->building_count)
  {
    Building_Pair* badTuple = stack_pop(solve);
    city_client_link_undo(badTuple->b1, badTuple->b2);
    SolveMapRecursive(coreBuilding, badTuple->b1, solve, 1, badTuple->b1->index);
  }
  */

  //Loop principal que permite iterar recursivamente.
  for (int i = 0 + preIndex;  i < (first->zone->building_count);  i++)  {
    if (first->zone->buildings[i] !=  NULL) {
      if (first !=  first->zone->buildings[i])  {
        next  = first->zone->buildings[i];

        //Si se entra al if, quiere decir que encontramos un core final con el cual unirnos.
        if ((next->color ==  coreBuilding->buildings[0]->color) && (!city_client_is_taken(next))) {
          Building_Pair*  newPair = Building_Tuple_Create(first, next);
          stack_push(solve, newPair);
          city_client_link(first, next);
          break;
        }

        //Si se entra al else, quiere decir que encontramos un core final con el cual unirnos.
        else {

          //Se sigue buscando un camino posible.
          if (!city_client_is_taken(next)) {
            if (city_client_is_blank(next)) {
              if (!(next -> cored)) {
                Building_Pair* newPair = Building_Tuple_Create(first, next);
                stack_push(solve, newPair);
                city_client_link(first, next);
                SolveMapRecursive(coreBuilding, next, solve, 0, first->index);
              }
              break;
            }
          }

          //Se decide que no quedan caminos por donde buscar, por lo que nos vamos hacia atrás.
          else {
            if (i == first->zone->building_count-1) {
              Building_Pair* badTuple = stack_pop(solve);
              city_client_link_undo(badTuple->b1, badTuple->b2);
              SolveMapRecursive(coreBuilding, badTuple->b1, solve, 1, badTuple->b1->index);
            }
          }
        }
      }
    }
  }
}

// Funcion que resuelve caminos partiendo desde un core utilizando una poda inteligente
void SolveMap(Core* core_building, Building* new, Stack* solve){

  Core* coreBuilding = core_building;
  Building* first = new -> linked[0];
  Building* next  = NULL;

  //Variable que determina si se cumple la condición para la poda. Si es cero quiere decir que no se podo.
  int k = 0;

  //Se entra para buscar si hay un core del mismo color en la zona donde estamos revisando.
  if (k == 0)
  {
    for (int i = 0; i < (first -> zone -> building_count); i++) {
      if (first ->  zone -> buildings[i] != NULL) {
        if (first != first ->  zone -> buildings[i]) {
          next  = first ->  zone -> buildings[i];
          if(next -> color == coreBuilding -> buildings[0] -> color && !city_client_is_taken(next))
          {
            Building_Pair* newPair = Building_Tuple_Create(first, next);
            stack_push(solve, newPair);
            city_client_link(first, next);
            city_client_link_print(first, next);
            k = 1;
          }
        }
      }
    }
  }

  //Se entra si no se encontro un core para buscar otros posibles caminos.
  if (k == 0)
  {
    for (int i = 0; i < (first -> zone -> building_count); i++) {
      if (first ->  zone -> buildings[i] != NULL) {
        if (first != first ->  zone -> buildings[i]) {
          next  = first ->  zone -> buildings[i];
          if(!city_client_is_taken(next)) {
            if (city_client_is_blank(next)) {
              if (!(next -> cored)) {
                Building_Pair* newPair = Building_Tuple_Create(first, next);
                stack_push(solve, newPair);
                city_client_link(first, next);
                city_client_link_print(first, next);
                SolveMap(coreBuilding, next, solve);
              }
              break;
            }
          }
        }
      }
    }
  }
}


int main(int argc, char const *argv[]) {
    /* Leemos la ciudad del input */
    Layout* layout = city_layout_read(stdin);

    /* Lo imprimimos para darle el estado inicial al watcher / judge */
    //city_layout_print(layout);

    /* TODO RESOLVER PROBLEMA */

    Core**  cores_input = layout->cores;

    //Stack para guardar las tuplas que se van linkeando
    Stack* stack_calls = stack_init(1000);

    city_layout_print(layout);

    for (int i = 0; i < layout->core_count - 1; i++) {
        SolveMap(cores_input[i], cores_input[i]->buildings[0], stack_calls);
    }

    stack_destroy(stack_calls);

    //city_layout_print(layout);


    /* TODO IMPRIMIR DECISIONES */

    /* Indicamos al watcher y al judge que ya terminamos */
    printf("END\n");

    /* Liberamos memoria */
    city_layout_destroy(layout);

    return 0;
}
