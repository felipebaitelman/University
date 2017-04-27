#ifndef T2_LIB_MANAGER
#define T2_LIB_MANAGER

#include <stdbool.h>
#include "scene.h"

struct BoundingBox{
  float x0;
  float y0;
  float z0;
  float x1;
  float y1;
  float z1;
};
/* Representa la estructura de una caja en el espacio */
typedef struct BoundingBox BoundingBox;

struct KdNode {
  struct KdNode* left;
  struct KdNode* right;
  struct KdNode* father;
  Triangle** TriangleList;
  BoundingBox bbox;
  float median;
  int TriangleCount;
};
/* Representa la estructura que formara el arbol */
typedef struct KdNode KdNode;

struct manager {
  Triangle** triangles;
  size_t triangle_count;
  KdNode* root;
};
/** Representa la estructura encargada de administrar los triángulos */
typedef struct manager Manager;

/*#########################################################################*/
/* No modifiques la firma de estas 3 funciones, ya que son la forma que    */
/* tiene el raytracer para interactuar con tu estructura. Es la interfaz   */
/*#########################################################################*/

/** Inicializa y configura el administrador de triángulos de la escena */
Manager* manager_init(Scene* scene);

/** Encuentra el triangulo más cercano que intersecte con el rayo
    Retorna TRUE en caso de intersectar con algo, FALSE si no */
bool     manager_get_closest_intersection(Manager* manager, Ray* ray);

/** Libera todos los recursos asociados al administrador de triángulos */
void     manager_destroy(Manager* manager);

#endif /* end of include guard: T2_LIB_STRUCTURE */
