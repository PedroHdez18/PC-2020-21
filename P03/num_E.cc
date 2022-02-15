#include <iostream>
int main() {
  int i = 2;
  float E_num = 1; 
  float E_aux = 1; 
  float aux = 1; 
  float error;

  std::cout << "Practica 3. PRINCIPIOS DE COMPUTADORES" << std::endl;
  std::cout << "Introduce el error maximo permitido: ";
  std::cin >> error;

  do {
  	if (error < 0){
		std::cout << "Introduzca un numero valido (positivos): ";
		std::cin >> error;
	}
    E_num += 1/aux;
    aux = aux*i;
    if (E_num-E_aux <= error){
      break;
    }
    E_aux = E_num;
    ++i;
  } while (true);
  std::cout << "\nNumero e: " << E_num << std::endl;
  std::cout << "Terminos calculados: " << i << std::endl;
}




//     #REGISTERS     VARIABLE
//      #f10            error
//      #f9            E_num
//      #f4            E_aux
//      #f5            aux
//      #f6            i
//      #f7            1/aux
//      #f8            1.0
//      #f16           0.0
//      #f20           E_num - E_aux


//     .text
// main: 

//     li $v0, 4                               #Prepara la escritura por consola
//     la $a0, titulo                          #Escribimos el titulo por consola
//     syscall

//     error_1:                                #etiqueta                            
//     la $a0, intr_error        
//     syscall


//     li $v0, 6		                        #flotante presicion doble  /  cin
//     syscall
//     mov.s $f10,$f0	                        #mover el numero introducido por pantalla a otro registro

//     li.s $f9, 1.0                           #inicializamos variables
//     li.s $f4, 1.0                           #inicializamos variables
//     li.s $f5, 1.0                            #inicializamos variables
//     li.s $f6, 2.0                            #inicializamos variables
//     li.s $f8, 1.0                            #inicializamos variables

//     do:
//         div.s $f7, $f8, $f5             
//         add.s $f9, $f9, $f7             
//         mul.s $f5, $f5, $f6           
//         sub.s $f20, $f9, $f4        

//         c.le.s $f20, $f10              

//         bc1t do_fin                    

//         mov.s $f4, $f9                
//         add.s $f6, $f6, $f8          

//         j do                          
//     do_fin:

//     li $v0, 4                               #Prepara la escritura por consola
//     la $a0, num_e                           #Escribimos el num_e por consola
//     syscall

    
//     mov.s $f12,$f4
//     li $v0, 2                               #double a imprimir
//     syscall

//     li $v0, 4                               #Prepara la escritura por consola
//     la $a0, term_calc                       #Escribimos el term_calc por consola
//     syscall

//     cvt.w.s $f0, $f6                        #convierte #f16( double i) en $f0(int i)
//     li $v0, 1                               #prepara el sitema para imprimir enteros
//     mfc1 $a0, $f0                           #almacena en $a0 el valor de $f0(int i)
//     syscall                                 #llamada al sistema para imprimir $a0 

//     li $v0, 10                              #fin del programa
//     syscall


//   .data
//   titulo: .asciiz "Practica 3. PRINCIPIOS DE COMPUTADORES\n"
//   msgnumero: .asciiz "Introduce el error maximo permitido: "
//   msgnumeroe: .asciiz "\nNumero e: "
//   msgnumeroterminos: .asciiz "\nTerminos calculados: "
//   msgnumeroerror: .asciiz "\nEl error introducido es menor que 0 introduzca otro error mayor. \n"
//   final: .asciiz "\n\nFIN DEL PROGRAMA.\n"

//   .text

// main:
// #REGISTROS      VARIABLES
// # f4              error
// # f5                e
// # f6               aux
// # f7               E-e
// # f8               1/aux
// # f9                1
// # f10             i float
// # f16               E
// # f20              0.0

//   li $v0, 4                         #prepara el sistema para imprimir texto por consola
//   la $a0, titulo                    #almacena en $a0 titulo
//   syscall                           #llamada al sistema para imprimir $a0

//   error1:                           #etiqueta error1:
//   la $a0, msgnumero                 #almacena en $a0 msgnumero
//   syscall                           #llamada al sistema para imprimir $a0

//   li $v0, 6                         #prepara el sistema para leer numero flotante por consola
//   syscall                           #llamada al sistema para imprimir $v0
//   mov.s $f4, $f0                    #registro simple precision $f4 para la variable error

//   li.s $f20, 0.0                    #registro simple precision $f20 para guardar un 0.0
//   c.lt.s $f4, $f20                  #comprueba si $f4 es menor que $f20
//   bc1t error2                       #complementaria de la funcion c.le.s si se cumple salta a error2

//   j correcto                        #cuando el error sea mayor que 0 salta a correcto para comenzar el programa

//   error2:                           #etiqueta error2:
//   li $v0, 4                         #prepara el sistema para imprimir texto por consola
//   la $a0, msgnumeroerror            #almacena en $a0 msgnumeroerror
//   syscall                           #llamada al sistema para imprimir $a0
//   j error1                          #salto al error1:

// correcto:                           #salto al correcto:

//   li.s $f10, 2.0                    #registro simple precision $f10 para la variable i float = 2.0
//   li.s $f5, 1.0                     #registro simple precision $f5 para la variable e = 1.0
//   li.s $f9, 1.0                     #registro simple precision $f9 para guardar un 1.0
//   li.s $f6, 1.0                     #registro simple precision $f6 para la variable aux = 1.0
//   li.s $f16, 1.0                    #registro simple precision $f16 para la variable E = 1.0

//   do:                               #etiqueta do:
//     div.s $f8, $f9, $f6             #guarda en $f8(1/aux)  la division de $f9(1.0) entre $f6(aux)
//     add.s $f5, $f5, $f8             #guarda en $f5(e) la suma de $f5(e) entre $f8(1/aux)
//     mul.s $f6, $f6, $f10            #almacena en $f6(aux) la multiplicacion de $f6(aux) por $f10(i)
//     sub.s $f7, $f5, $f16            #almacena en $f7(E-e) la resta de $f5(e) con $f16(E)
    
//     c.le.s $f7, $f4                 #comprueba si $f7(E-e) es menor igual que $f4(error)
    
//     bc1t do_fin                     #complementaria de la funcion c.lt.s si se cumple salta a do_fin
    
//     mov.s $f16, $f5                 #almacena el valor de $f5(e) en $f16(E) con lo cual E pasa a valer e (E=e)
    
//     add.s $f10, $f10, $f9           #almacena en $f10(float n) la suma de $f10(float i) con $f9(1.0)
    
//     j do                            #salto al do:

//   do_fin:                           #fin del do:
//     li $v0, 4                       #prepera al sistema para escribir por consola
//     la $a0, msgnumeroe              #almacena en $a0 msnumeroe
//     syscall                         #llamada al sistema para imprimir por consola $a0

//     mov.s $f12, $f5                 #almacena en $f12 el valor de $f5(e)
//     li $v0, 2                       #prepara el sistema para escribir floats
//     syscall                         #llamada al sistema para imprimir por consola $f12

//     li $v0, 4                       #prepera al sistema para escribir por consola
//     la $a0, msgnumeroterminos       #almacena en $a0 msnumeroterminos
//     syscall                         #llamada al sistema para imprimir $a0

//     cvt.w.s $f0, $f10               #convierte #f10(float i) en $f0(int i)
//     li $v0, 1                       #prepara el sitema para imprimir enteros
//     mfc1 $a0, $f0                   #almacena en $a0 el valor de $f0(int i)
//     syscall                         #llamada al sistema para imprimir $a0

// li $v0, 4                           #prepera al sistema para escribir por consola
// la $a0, final                       #almacena en $a0 final
// syscall                             #llamada al sistema para imprimir $a0

// li $v0, 10                          #prepara al sistema para salir
// syscall                             #sale del programa