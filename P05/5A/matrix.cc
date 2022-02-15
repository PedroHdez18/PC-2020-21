//Matrices
//Intercambio de de filas y/o columnas

#include <iostream>

int main () {

const int nrows = 4;
const int ncols = 3;
int opc;

int x = 0, y = 0;
int aux = 0; 

int matrix [nrows] [ncols] = {{11,12,13},
							  {21,22,23},
							  {31,32,33},
							  {41,42,43}};

std::cout << "Practica 5. Matrices. Intercambio de filas  y/0 columnas";
std::cout << std::endl;

for (int i = 0; i < nrows; i++){
	for (int j = 0; j < ncols; j++){
		std::cout << matrix [i][j] << " ";
	}
	std::cout << std::endl;
}

std::cout << "Introduzca opcion. <1> Intercambia filas, <2> Intercambia columnas, <0> Salir: ";
std::cin >> opc;
std::cout << std::endl;

switch(opc){
	case 1:
	  std::cout << "Introduzca dos enteros con las filas que se deben intercambiar [0-3]: ";
	  std::cin >> x >> y; 
	  for (int i = 0; i < ncols; ++i){
	      aux = matrix [x][i];
	  	  matrix [x][i] = matrix [y][i];
	  	  matrix [y][i] = aux;
	  }
	  for (int i = 0; i < nrows; i++){
	    for (int j = 0; j < ncols; j++){
		  std::cout << matrix [i][j] << " ";
	    }
	    std::cout << std::endl;
      }
} 
	return 0;
}
