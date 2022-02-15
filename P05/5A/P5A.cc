#include <iostream>

int main () {

	const int nrows = 4;
	const int ncols = 3;

	int matrix [nrows] [ncols] = {{11,12,13},
							  	  {21,22,23},
							  	  {31,32,33},
							 	  {41,42,43}};
	int opc;
	int x = 0, y = 0;
	int aux;

	do {

		//imprimir la matriz por consola
		for (int i = 0; i < nrows; i++){
			for (int j = 0; j < ncols; j++){
				std::cout << matrix[i][j] << " ";
			}
			std::cout << std::endl;
		}

		//preguntar por la opcion
		std::cout << "<1> Cambiar filas, <2> Cambiar columnas, <0> Salir: ";
		std::cin >> opc;

		if (opc == 0) break;
		else if (opc == 1){
			//intercambiar filas 
			do {
				std::cout << "Introduzca dos enteros, los indices de las filas a cambiar: ";
				std::cin >> x;
				std::cin >> y;
			} while ((x < 0)  ||  (x >= nrows)  || (y < 0)  || (y >= nrows));

				for (int j = 0; j < ncols; j++){
					aux = matrix[x][j];
					matrix[x][j] = matrix[y][j];
					matrix[y][j] = aux;
				}

		} else if (opc == 2){
			//intercambiar columnas
			do {
				std::cout << "Introduzca dos enteros, los indices de las columnas a cambiar: ";
				std::cin >> x;
				std::cin >> y;
			} while ((x < 0)  ||  (x >= ncols)  || (y < 0)  || (y >= ncols));

				for (int i = 0; i < nrows; i++){
					aux = matrix[i][x];
					matrix[i][x] = matrix[i][y];
					matrix[i][y] = aux;
				}
				
		} else 
			std::cout << "Ha introducido una opcion invalida. Vuelve a repetir. \n";

	} while (true);
	std::cout << "Fin del programa\n";

	return 0;
}