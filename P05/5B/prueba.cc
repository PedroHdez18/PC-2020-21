#include <iostream>

using namespace std;
int main() {

int m, n, i=0;

double x;

const int tam_vec = 3;

double A[tam_vec];
  do {
    cout << "Introduzca 1<0.5> 2<4> 0<Exit>: ";
    cin >> m;
    if (m!= 0){
      A[i] = m;
      ++i;
    }
    if (m==1) {
      n=1;
      A[i]=n;
      ++i;
      x=0.2;
      A[i]=x;
      
    }else if(m==0){
      for (int j = 0; j < 3; j++) {
        cout << A[j] << " ";
      }
      exit(EXIT_SUCCESS);
    }
  } while (true);
return 0;
}