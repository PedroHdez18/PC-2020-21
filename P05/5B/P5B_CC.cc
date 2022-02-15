#include <iostream>

using namespace std;

float fr (int n, float x){
  if (n==0) {
    return 0.5;
  }else if(n==1){
    return 1;
  }else if(n>1){
    return fr(n-1,x) * fr(n-2,x)*x;
  }
}

float fi(int n, float x){
  float result=0.5*x;
  float aux=0;
  float aux2=1;
  if (n==0) {
    return 0.5;
  }else if(n==1){
    return 1;
  }else if(n==2){
    return result;
  }
   for(int i=2;i<n;i++) {
     aux = (result * aux2)*x;
     aux2=result;
     result = aux;
   }
  return result;
}

int main(){
  int n, m, i{0}, sol1{0};
  double A[30], sol2{0.5}, x;

  do {

    do {

      cout << "Introduzca opcion. <1>Iterativa <2>Recursiva <0>Salir: ";
      cin >> m;

    } while (m>2 || m<0);


    if (m == 1){

      std::cout << "Introduzca el valor de n: ";
      std::cin >> n;
        A[i] = n;
        i++;

      std::cout << "Introduzca el valor de x: ";
      std::cin >> x;
        A[i] = x;
        i++;

      if (n == 0){
        std::cout << "Resultado de la llamada de la funcion: " << sol2 << std::endl;
          A[i] = sol2;
          i++;
      }else if (n > 1){
        std::cout << "Resultado de la llamada de la funcion: " << fi(n,x) << std::endl;
          A[i] = fi(n,x);
          i++;
      }else {
        std::cout << "El valor introuducido es menor que 0, por favor introduzca un valor igual o mayor.";
        exit(EXIT_SUCCESS);
      }
    }else if (m == 2){

      std::cout << "Introduzca el valor de n: ";
      std::cin >> n;
        A[i] = n;
        i++;

      std::cout << "Introduzca el valor de x: ";
      std::cin >> x;
        A[i] = x;
        i++;

      if (n == 0){
        std::cout << "Resultado de la llamada de la funcion: " << sol2 << std::endl;
          A[i] = sol2;
          i++;
      }else if (n == 1){
        std::cout << "Resultado de la llamada de la funcion: " << sol1 << std::endl;
          A[i] = sol1;
          i++;
      }else if (n > 1){
        std::cout << "Resultado de la llamada de la funcion: " << fr(n,x) << std::endl;
          A[i] = fr(n,x);
          i++;
      }else {
        std::cout << "El valor introuducido es menor que 0, por favor introduzca un valor igual o mayor.";
        exit(EXIT_SUCCESS);
      }
    }else if (m == 0){
      std::cout << "Tabla de resultado: " << endl;
      
      for (int j = 0; j < i;){
        for (int k = 0; k < 3; ++k, ++j)
          std::cout << A[j] << " ";
        std::cout << std::endl;
      }
      exit(EXIT_SUCCESS);
    }
  } while (true);
  return 0;
}