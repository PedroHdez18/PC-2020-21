#include <iostream>


int factorial (int n) {
	int i, resultado;
	resultado = 1;
	for (i = n; i > 1; i--){
		resultado *= i;
	}
	return resultado;
}


int main (void) {
	int n;
	std::cin >> n;
	int resultado;
	resultado = factorial(n);
	std::cout << resultado << std::endl;

}