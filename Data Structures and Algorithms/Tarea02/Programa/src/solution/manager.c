#include "manager.h"
#include <stdio.h>
#include <limits.h>
#include <math.h>

/* Funcion que compara dos valores para utilizar Quicksort */
int compare_float (const void *a, const void *b) {
  float fa = *(const float *) a;
  float fb = *(const float *) b;
  return (fa > fb) - (fa < fb);
}

/* Funcion que entrega valores intercepcion o no con una caja */
bool Intersection(BoundingBox b, Ray* r, float *NewTmin, float *NewTmax) {


    float tmin = -INFINITY;
    float tmax = INFINITY;


    if (ray_get_direction(r).X != 0) {
      float t1 = (b.x0 - ray_get_origin(r).X) / ray_get_direction(r).X;
      float t2 = (b.x1 - ray_get_origin(r).X)/ ray_get_direction(r).X;

      tmin = fmaxf(tmin, fminf(t1, t2));
      tmax = fminf(tmax, fmaxf(t1, t2));
    }

    else if (ray_get_origin(r).X <= b.x0 || ray_get_origin(r).X >= b.x1) {
      *NewTmin = tmin;
      *NewTmax = tmax;
    }

    if (ray_get_direction(r).Y != 0) {
      float t3 = (b.y0 - ray_get_origin(r).Y) / ray_get_direction(r).Y;
      float t4 = (b.y1 - ray_get_origin(r).Y)/ ray_get_direction(r).Y;

      tmin = fmaxf(tmin, fminf(t3, t4));
      tmax = fminf(tmax, fmaxf(t3, t4));
    }

    else if (ray_get_origin(r).Y <= b.y0 || ray_get_origin(r).Y >= b.y1) {
      *NewTmin = tmin;
      *NewTmax = tmax;
    }

    if (ray_get_direction(r).Z != 0) {
      float t5 = (b.z0 - ray_get_origin(r).Z) / ray_get_direction(r).Z;
      float t6 = (b.z1 - ray_get_origin(r).Z)/ ray_get_direction(r).Z;

      tmin = fmaxf(tmin, fminf(t5, t6));
      tmax = fminf(tmax, fmaxf(t5, t6));
    }

    else if (ray_get_origin(r).Z <= b.z0 || ray_get_origin(r).Z >= b.z1) {
      *NewTmin = tmin;
      *NewTmax = tmax;
    }

    *NewTmin = tmin;
    *NewTmax = tmax;

    return tmax > fmaxf(tmin,0.0);

}

/* Inicializacion del BoundingBox una vez que ya no estamos en la raíz */
BoundingBox BoundingBox_new(int depth, int side, float median, BoundingBox father) {

  BoundingBox NewBoundingBox;

  NewBoundingBox = father;

  //Hijo izquierdo
  if (side == 0) {

    //Corto en x
    if (depth%3 == 0) {
      NewBoundingBox.x1 = median;
    }

    //Corto en y
    else if (depth%3 == 1) {
      NewBoundingBox.y1 = median;
    }

    //Corto en z
    else if (depth%3 == 2) {
      NewBoundingBox.z1 = median;
    }

  }

  //Hijo derecho
  else if (side == 1) {

    //Corto en x
    if (depth%3 == 0) {
      NewBoundingBox.x0 = median;
    }

    //Corto en y
    else if (depth%3 == 1) {
      NewBoundingBox.y0 = median;
    }

    //Corto en z
    else if (depth%3 == 2) {
      NewBoundingBox.z0 = median;
    }
  }

  //Retornamos la caja
  return NewBoundingBox;
}

/* Inicializacion del BoundingBox en la raíz */
BoundingBox BoundingBox_init(Triangle** triangles, int TriangleCount) {

  BoundingBox NewBoundingBox;

  //Listas para las posiciones X, Y y Z de todos los vectores
  float* PosXList;
  PosXList = malloc(sizeof(float)*3*TriangleCount);
  float* PosYList;
  PosYList = malloc(sizeof(float)*3*TriangleCount);
  float* PosZList;
  PosZList = malloc(sizeof(float)*3*TriangleCount);

  //Rellenar las lista de posiciones
  for (int i = 0; i < TriangleCount; i++) {

    Vector v1;
    Vector v2;
    Vector v3;

    triangle_get_vertices(triangles[i], &v1, &v2, &v3);

    PosXList[(3*i)+1] = v1.X;
    PosXList[(3*i)+1] = v2.X;
    PosXList[(3*i)+2] = v3.X;

    PosYList[(3*i)+0] = v1.Y;
    PosYList[(3*i)+1] = v2.Y;
    PosYList[(3*i)+2] = v3.Y;

    PosZList[(3*i)+0] = v1.Z;
    PosZList[(3*i)+1] = v2.Z;
    PosZList[(3*i)+2] = v3.Z;
  }

  //Ordenamos las listas
  qsort(PosXList, 3*TriangleCount, sizeof(float), compare_float);
  qsort(PosYList, 3*TriangleCount, sizeof(float), compare_float);
  qsort(PosZList, 3*TriangleCount, sizeof(float), compare_float);

  //Asignamos los atributos de la caja
  NewBoundingBox.x0 = PosXList[0];
  NewBoundingBox.y0 = PosYList[0];
  NewBoundingBox.z0 = PosZList[0];
  NewBoundingBox.x1 = PosXList[3*TriangleCount-1];
  NewBoundingBox.y1 = PosYList[3*TriangleCount-1];
  NewBoundingBox.z1 = PosZList[3*TriangleCount-1];

  //Liberamos las listas
  free(PosXList);
  free(PosYList);
  free(PosZList);

  //Retornamos la caja
  return NewBoundingBox;
}

/* Metodo para calcular la mediana */
float Get_Median(Triangle** triangles, int TriangleCount, int depth) {

  //Mediana que retornaremos
  float median;

  //Listas para las posiciones X, Y y Z de todos los vectores
  float* PosList = malloc(sizeof(float)*3*TriangleCount);

  //Rellenar las listas de posiciones
  for (int i = 0; i < TriangleCount; i++) {
    Vector v1;
    Vector v2;
    Vector v3;
    triangle_get_vertices(triangles[i], &v1, &v2, &v3);

    if (depth%3 == 0){
      PosList[(3*i)+0] = v1.X;
      PosList[(3*i)+1] = v2.X;
      PosList[(3*i)+2] = v3.X;
    }
    else if (depth%3 == 1){
      PosList[(3*i)+0] = v1.Y;
      PosList[(3*i)+1] = v2.Y;
      PosList[(3*i)+2] = v3.Y;
    }
    else if (depth%3 == 2){
      PosList[(3*i)+0] = v1.Z;
      PosList[(3*i)+1] = v2.Z;
      PosList[(3*i)+2] = v3.Z;
    }
  }

  //Ordenamos las listas
  qsort(PosList, 3*TriangleCount, sizeof(float), compare_float);

  //Cantidad par de vertices
  if((3*TriangleCount)%2 == 0) {
    median = (PosList[3*TriangleCount/2] + PosList[(3*TriangleCount/2)-1])/2;
  }

  //Cantidad impar de vertices
  else {
    median = PosList[(3*TriangleCount-1)/2];
  }

  free(PosList);

  return median;
}

/* Metodo para asegurarnos que el punto de interseccio efectivamente esta en la caja */
bool PointInBox(BoundingBox NewBox, Ray* NewRay){

  //Numero auxiliar para darnos un mayor rango de hit
  float epsilon = 0.001;

  //Rayo entrante
  Vector v = ray_get_intersection_point(NewRay);

  //Comparaciones con todas las coordenadas
  if ((v.X >= NewBox.x0 - epsilon) && (v.X <= NewBox.x1 + epsilon) && (v.Y >= NewBox.y0 - epsilon) && (v.Y <= NewBox.y1
    + epsilon) && (v.Z >= NewBox.z0 - epsilon) && (v.Z <= NewBox.z1 + epsilon)) {
    return true;
  }

  else return false;
}

/* Inicializacion del KdNode */
KdNode* kdNode_new(struct triangle** triangles, int count, int depth, Scene* NewScene, BoundingBox Box) {

  //Pedimos espacio en memoria para el nuevo nodo
  KdNode* NewKdNode = malloc(sizeof(KdNode));

  NewKdNode->TriangleCount = count;
  NewKdNode->bbox = Box;
  NewKdNode->TriangleList = triangles;
  NewKdNode->left = NULL;
  NewKdNode->right = NULL;

  //Si la lista de triangulos recibida tiene meneos de 50 triangulos retornamos
  if (count < 50) {
    return NewKdNode;
  }

  //Calculamos la mediana para este corte
  float median = Get_Median(NewKdNode->TriangleList, count, depth);
  printf("%f\n",median);
  //Calculamos las cajas para nuestros hijos
  BoundingBox LeftBox = BoundingBox_new(depth, 0, median, Box);
  BoundingBox RightBox = BoundingBox_new(depth, 1, median, Box);

  //Creamos nuestra lista de triángulos izquierdos y derechos
  int l = 0;
  int r = 0;
  int m = 0;

  //Creamos dos arreglos de triángulos, los que se van a la derecha y los que se van a la izquierda
  Triangle** LeftTriangles =  malloc(count*sizeof(Triangle*));
  Triangle** RightTriangles = malloc(count*sizeof(Triangle*));

  //Llenamos arreglos LeftTraingles y RightTriangles
  l = 0;
  r = 0;
  m = 0;
  for (int i = 0; i < count ; i++) {
    Vector v1;
    Vector v2;
    Vector v3;
    triangle_get_vertices(NewKdNode ->TriangleList[i], &v1, &v2, &v3);
    //printf("el valor del depht es %i \n", depth%3);
    if (depth%3 == 0){
      if (v1.X < median && v2.X < median && v3.X < median) {
        LeftTriangles[l] = triangles[i];
        l++;
      }
      else if ((v1.X > median) && (v2.X > median) && (v3.X > median)) {
        RightTriangles[r] = triangles[i];
        r++;
      }
      else {
        LeftTriangles[l] =triangles[i];
          l++;
        RightTriangles[r] = triangles[i];
        r++;
        m++;
      }
    }
    //Dividimos según mediana eje Y
    else if (depth%3 == 1){
      if ((v1.Y < median) && (v2.Y < median) && (v3.Y < median)) {
        LeftTriangles[l] = triangles[i];
        l++;
      }
      else if ((v1.Y > median) && (v2.Y > median) && (v3.Y > median)) {
        RightTriangles[r] = triangles[i];
        r++;
      }
      else {
        LeftTriangles[l] = triangles[i];
        l++;
        RightTriangles[r] = triangles[i];
        r++;
        m++;
      }
    }
    //Dividimos según mediana eje Z
    else if (depth%3 == 2){
      if ((v1.Z < median) && (v2.Z < median) && (v3.Z < median)) {
        LeftTriangles[l] = triangles[i];
        l++;
      }
      else if ((v1.Z > median) && (v2.Z > median) && (v3.Z > median)) {
        RightTriangles[r] = triangles[i];
        r++;
      }
      else {
        LeftTriangles[l] = triangles[i];
        l++;
        RightTriangles[r] = triangles[i];
        r++;
        m++;
      }
    }
  }

  //Condicion de termino o de creación de nuevas ramas derecha e izquierda
  if (m < 0.7*count) {
    NewKdNode->left = kdNode_new(LeftTriangles, l, depth + 1, NewScene, LeftBox);
    NewKdNode->right = kdNode_new(RightTriangles, r, depth + 1, NewScene, RightBox);
  }

  //Retorno
  return NewKdNode;
}

/* Imprmir triangulos */
bool printTriangles(KdNode* NewKdNode, Ray* NewRay) {

  for(int i = 0; i < NewKdNode->TriangleCount; i++) {
      ray_intersect(NewRay, NewKdNode->TriangleList[i]);
  }

  if(ray_get_intersected_object(NewRay) != NULL && PointInBox(NewKdNode->bbox,NewRay)) {
    return true;
  }

  else return false;

}

/* Funcion que recorre el arbol producido */
bool SearchTheTree(KdNode* NewKdNode, Ray* NewRay) {

  bool actual;
  float tminActual;
  float tmaxActual;

  actual = Intersection(NewKdNode->bbox, NewRay, &tminActual, &tmaxActual);

  //El rayo no intercepta la caja
  if(actual == false) {
    return false;
  }

  //Estamos parados en una hoja
  if (NewKdNode->left == NULL && NewKdNode->right == NULL) {
    return printTriangles(NewKdNode, NewRay);
  }

  //Bajamos y recorremos el arbol
  if (NewKdNode->left != NULL && NewKdNode->right != NULL) {

    bool left;
    float tminLeft;
    float tmaxLeft;
    bool right;
    float tminRight;
    float tmaxRight;

    left = Intersection(NewKdNode->left->bbox, NewRay, &tminLeft, &tmaxLeft);
    right = Intersection(NewKdNode->right->bbox, NewRay, &tminRight, &tmaxRight);

    //No intersecta ninguna de las dos cajas
    if(left == false && right == false) {
      return false;
    }

    //Intersecta izquierda y no derecha
    else if(left == true && right == false) {
      return SearchTheTree(NewKdNode->left, NewRay);
    }

    //Intersecta derecha y no izquierda
    else if(left == false && right == true) {
      return SearchTheTree(NewKdNode->right, NewRay);
    }

    //Intersecta las dos cajas
    else if(left == true && right == true) {

      //El rayo choca con ambas y esta mas cerca de la izquierda que de la derecha
      if(tminLeft < tminRight){
        if(SearchTheTree(NewKdNode->left, NewRay) == true) return true;
        return SearchTheTree(NewKdNode->right, NewRay);
      }

      //El rayo choca con ambas y esta mas cerca de la derecha que de la izquierda
      if (tminLeft > tminRight) {
        if(SearchTheTree(NewKdNode->right, NewRay)) return true;
        return SearchTheTree(NewKdNode->left, NewRay);
      }

      //Intersecta a las dos cajas a la misma distancia mínima
      else if(tminLeft == tminRight) {

        //Tmax izquierdo es más pequeño que derecho
        if(tmaxLeft < tmaxRight){
          if(SearchTheTree(NewKdNode->left, NewRay)) return true;
          return SearchTheTree(NewKdNode->right, NewRay);
        }

        //Tmax izquierdo es más grande que derecho
        else {
          if(SearchTheTree(NewKdNode->right, NewRay)) return true;
          return SearchTheTree(NewKdNode->left, NewRay);
        }
      }
    }

  }
  return false;
}

/* Inicializa y configura el administrador de triángulos de la escena */
Manager* manager_init(Scene* scene) {

  /* Solicitamos memoria para el manager */
  Manager* manager = malloc(sizeof(Manager));

  manager -> triangle_count = scene_get_triangle_count(scene);

  manager -> triangles = scene_get_triangles(scene);

  //Caja para el nodo raíz
  BoundingBox RootBox = BoundingBox_init(manager -> triangles, manager -> triangle_count);

  //Inicializamos el arbol de KdNodes
  manager -> root = kdNode_new(manager -> triangles, manager -> triangle_count, 0, scene, RootBox);

  return manager;
}

/* Encuentra el triangulo más cercano que intersecte con el rayo, retorna TRUE en caso de intersectar con algo, FALSE si no */
bool manager_get_closest_intersection(Manager* manager, Ray* ray) {

  /* Inicialmente el triángulo guardado en el rayo es NULL
     Por lo que en caso de no intesectar con nada se mantendrá NULL
     Si intersecta con algo quedará guardado en el rayo, en caso de que
     ese objeto esté más cerca que el objeto que estaba guardado antes.
     Para obtener el triangulo más cercano simplemente probamos con
     TODOS los triángulos. El que quede guardado finalmente en el rayo
     será el más cercano */

    /* Recorrer todo */
    // /** Recorremos el arreglo de triángulos */
    // for(int i = 0; i < manager -> triangle_count; i++)
    // {
    //   /* Probamos intersectar con todos */
    //   ray_intersect(ray, manager -> triangles[i]);
    // }
    //
    // /* Si luego de todo eso hay un triangulo guardado en el rayo */
    // if(ray_get_intersected_object(ray) != NULL) return true;
    //
    // else return false;

    /* Usar un bounding box */
    // float tmin, tmax;
    // if (Intersection(manager->root->bbox,ray, &tmin, &tmax) == false){
    //    return false;
    // }
    // /** Recorremos el arreglo de triángulos */
    // for(int i = 0; i < manager -> triangle_count; i++)
    // {
    //   /* Probamos intersectar con todos */
    //   ray_intersect(ray, manager -> triangles[i]);
    // }
    //
    // /* Si luego de todo eso hay un triangulo guardado en el rayo */
    // if(ray_get_intersected_object(ray) != NULL) return true;
    //
    // else return false;

    /* Usar varios Bounding Boxes */
    return SearchTheTree(manager->root, ray);




}

/** Libera todos los recursos asociados al administrador de triángulos */
void manager_destroy(Manager* manager) {
  free(manager);
}
