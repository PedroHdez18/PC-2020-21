#Pedro Hernandez Alonso
#alu0101423944@ull.edu.es

#Alejandro Rodriguez Mederos
#alu0101413938@ull.edu.es

#Practica 5A. Principio de computadoras

# Pseudocódigo
# #include <iostream>
# using namespace std;
# float fr (int n, float x){
#   if (n==0) {
#     return 0.5;
#   }else if(n==1){
#     return 1;
#   }else if(n>1){
#     return fr(n-1,x) * fr(n-2,x)*x;
#   }
# }
# float fi(int n, float x){
#   float result=0.5*x;
#   float aux=0;
#   float aux2=1;
#   if (n==0) {
#     return 0.5;
#   }else if(n==1){
#     return 1;
#   }else if(n==2){
#     return result;
#   }
#    for(int i=2;i<n;i++) {
#      aux = (result * aux2)*x;
#      aux2=result;
#      result = aux;
#    }
#   return result;
# }
# int main(){
#   int n, m, i{0}, sol1{0};
#   double A[30], sol2{0.5}, x;
#   do {
#     do {
#       cout << "Introduzca opcion. <1>Iterativa <2>Recursiva <0>Salir: ";
#       cin >> m;
#     } while (m>2 || m<0);
#     if (m == 1){
#       std::cout << "Introduzca el valor de n: ";
#       std::cin >> n;
#         A[i] = n;
#         i++;
#       std::cout << "Introduzca el valor de x: ";
#       std::cin >> x;
#         A[i] = x;
#         i++;
#       if (n == 0){
#         std::cout << "Resultado de la llamada de la funcion: " << sol2 << std::endl;
#           A[i] = sol2;
#           i++;
#       }else if (n > 1){
#         std::cout << "Resultado de la llamada de la funcion: " << fi(n,x) << std::endl;
#           A[i] = fi(n,x);
#           i++;
#       }else {
#         std::cout << "El valor introuducido es menor que 0, por favor introduzca un valor igual o mayor.";
#         exit(EXIT_SUCCESS);
#       }
#     }else if (m == 2){
#       std::cout << "Introduzca el valor de n: ";
#       std::cin >> n;
#         A[i] = n;
#         i++;
#       std::cout << "Introduzca el valor de x: ";
#       std::cin >> x;
#         A[i] = x;
#         i++;
#       if (n == 0){
#         std::cout << "Resultado de la llamada de la funcion: " << sol2 << std::endl;
#           A[i] = sol2;
#           i++;
#       }else if (n == 1){
#         std::cout << "Resultado de la llamada de la funcion: " << sol1 << std::endl;
#           A[i] = sol1;
#           i++;
#       }else if (n > 1){
#         std::cout << "Resultado de la llamada de la funcion: " << fr(n,x) << std::endl;
#           A[i] = fr(n,x);
#           i++;
#       }else {
#         std::cout << "El valor introuducido es menor que 0, por favor introduzca un valor igual o mayor.";
#         exit(EXIT_SUCCESS);
#       }
#     }else if (m == 0){
#       std::cout << "Tabla de resultado: " << endl;   
#       for (int j = 0; j < i;){
#         for (int k = 0; k < 3; ++k, ++j)
#           std::cout << A[j] << " ";
#         std::cout << std::endl;
#       }
#       exit(EXIT_SUCCESS);
#     }
#   } while (true);
#   return 0;
# }


size4 = 4
size8 = 8


		.data

matrix:      .space 200         #resevamos 200 bytes de memoria

titulo: 	   .asciiz "PRACTICA 5. PRINCIPIOS DE COMPUTADORES.\n"
intr_opc:	   .asciiz "Introduzca opcion. <1> Iterativa <2> Recursiva <0> Salir: "
msg_error:	 .asciiz "Ha introuducido una opcion incorrecta, vuelva a introducirla. \n"
tab_res:	   .asciiz "Tabla de resultados: \n"
n_val:		   .asciiz "Introduca el valor de n: "
x_val:		   .asciiz "Introduzca el valor de x: "
result_fun:	 .asciiz "Resultado de la llamada de la funcion: "
endl:        .asciiz "\n"
espacio:     .asciiz " "

		.text

fr:
  #$a0=n
  #$f12 = x

  li.d $f6, 0.5                      #carga $f6 con 0.5
  bgt $a0, 1, forFr                  #if ($a0 > 1) forFr 
  beq $a0, 0, retFr0                 #if ($a0 == 0) retFr0
  beq $a0, 1, retFr1                 #if ($a0 == 1) retFr1

  #Caso trivial 1
  retFr0:                    
  li.d $f0, 0.5
  jr $ra

  #Caso trivial 2
  retFr1:
  li.d $f0, 1.0
  jr $ra

  forFr:                              #etiqueta forFr
    #Push
    addi $sp, -16                     #creamos espacio en la pila para 16 celdas
    sw $a0,12($sp)                    #guardamos $a0 en la casilla 12 
    sw $ra, 8($sp)                    #guardamos $ra en la casilla 8
    sdc1 $f12, 0($sp)                 #guardamos $f12 en la casilla 0 (ocupando 8) 

    addi $a0, -1                      #n-1
    jal fr                            #jump and link to fr

    #Pop
    ldc1 $f12,0($sp)                  #cargamos $f12 en la casilla 0 (ocupando 8)
    lw $ra, 8($sp)                    #cargamos $ra en la casilla 8
    lw $a0, 12($sp)                   #cargamos $a0 en la casilla 12

    #Segundo Push
    addi $sp, -8                      #creamos espacio en la pila para 8 celdas para n-1
    sdc1 $f0, 16($sp)                 #guardamos $f0 en la casilla 16    f0, es el resultado de la ultima llamda a la funcion y nos ahorramos un registro
    sw $a0,12($sp)                    #guardamos $a0 en la casilla 12
    sw $ra, 8($sp)                    #guardamos $ra en la casilla 8
    sdc1 $f12, 0($sp)                 #guardamos $f12 en la casilla 16 (guarda n-2)

    addi $a0,-2                       #n-2
    jal fr                            #jump and link to fr            

    #Segundo Pop
    ldc1 $f12, 0($sp)                 #cargamos $f12 en la casilla 0 (ocupando 8)      
    lw $ra, 8($sp)                    #cargamos $ra en la casilla 8 
    lw $a0, 12($sp)                   #cargamos $a0 en la casilla 12
    ldc1 $f4, 16($sp)                 #cargamos $f4 en la casilla 16 
    addi $sp, 24                      #vacias todas la casillas de la pila

    mul.d $f0, $f0, $f12              #$f0 = $f0 * $f12    resul_ult_fun = resul_ult_fun * valor_pila1
    mul.d $f0, $f0, $f4               #$f0 = $f0 * $f4     resul_ult_fun = resul_ult_fun * valor_pila2 
    jr $ra                            #jump register       vuelta la main

fi:
  #$a0=n
  #$f4, $f12 = x

  mov.d $f4, $f12                     #recibe el valor de x
  li.d $f6, 0.5                       #registro con 0.5
  mul.d $f4, $f4, $f6                 #result

  li.d $f8, 0.0                       #aux
  li.d $f10, 1.0                      #aux2

  beq $a0, $zero, return0             #if ($a0 == 0) return0
  beq $a0, 1, return1                 #if ($a0 == 1) return1
  beq $a0, 2, return2                 #if ($a0 == 2) return2

  li $t0, 2                           #cargamos un registro  i = 2

  forFi:                              #etiqueta forFi
    mul.d $f8, $f4, $f10              #$f8 = $f4 * $f10
    mul.d $f8, $f8, $f12              #$f8 = $f8 * $f12
    mov.d $f10, $f4                   #movemos $f4 a $f10
    mov.d $f4, $f8                    #movemos $f8 a $f4

  addi $t0, 1                         #i++
  blt $t0, $a0, forFi                 #if ($t0 < $a0) forFi

  mov.d $f0, $f4                      #movemos $f4 a $f0
  jr $ra                              #jump register       vuelta la main
  return0:                            #etiqueta return0
    li.d $f0, 0.5                     #cargamos un 0.5 en $f0
    jr $ra

  return1:                            #etiqueta return0
    li.d $f0, 1.0                     #cargamos un 1 en $f0
    jr $ra                            #jump register       vuelta la main

  return2:                            #etiqueta return0
    mov.d $f0, $f4                    #movemos $f4 en $f0
    jr $ra                            #jump register       vuelta la main


#################_MAIN_#################
main:

li $v0, 4						                  #preparamos la escritura por consola
la $a0, titulo					              #escribimos el titulo por consola
syscall							                  #llamada al sistema

li $t1, size4
li $t2, size8
li $t3, 0
li $t4, 0
li $t5, 0
li $t6, 0

#REGISTROS          #VARIABLES
#$a0 				n_val
#$f12				x_val

do:

	li $v0, 4					                #preparamos la escritura por consola
	la $a0, intr_opc 			            #escribimos el titulo por consola
	syscall 					                #llamada al sistema
        
	li $v0, 5				         	        #preparamos al sistema para recibir enteros por consola
	syscall						                #llamada al sistema
        
	beq $v0, 1, if1			              #if ($v0 == 1) if1
	beq $v0, 2, if2				            #if ($v0 == 2) if2
	beq $v0, 0, imp_matrix		        #if ($v0 == 0) fin_prog
        
        
		li $v0, 4                       #preparamos la escritura por consola
		la $a0, msg_error               #escribimos el msg_error por consola
		syscall                         #llamada al sistema
		j do                            #salto al do


#################_ITERATIVA_#################
	if1:

    li $v0, 4                       #preparamos la escritura por consola
		la $a0, n_val				            #escribimos n_val por consola
		syscall						              #llamada al sistema
        
		li $v0, 5					              #preparamos al sistema para recibir enteros poc consola
		syscall						              #llamada al sistema
		move $t0, $v0				            #cambiamos el valor introducido por pantalla a otro registro
        
    sw $t0, matrix($t3)             #metemos en $t0 en la matrix en la celda de $t3
    add $t3, $t3, $t1               #le añadimos 4   entero de 4 en 4
        
		li $v0, 4				       	        #preparamos la escritura por consola
		la $a0, x_val				            #escribimos x_val por consola
		syscall						              #llamada al sistema 
        
		li $v0, 7					              #preparamos al sistema para recibir flotantes por consola
		syscall 				       	        #llamama al sistema
		mov.d $f12, $f0				          #cambiamos el valor introducido por pantalla a otro registro
        
    sdc1 $f12, matrix($t3)            #metemos $f12 en la matrix en la celde de $t3
    add $t3, $t3, $t2               #le añadimos 8   doble de 8 en 8
        
    li $v0, 4                       #preparamos la escritura por consola
    la $a0, result_fun              #escribimos result_fun por consola
    syscall                         #llamada al sistema
        
    move $a0, $t0                   #movemos el $t0 a $a0 para pasarlo a la funcion
        
    jal fi                          #jump and link to fi
    mov.d $f12, $f0                 #movemos el $f0 que llega de la funcion a $f12 para retornarlo
    li $v0, 3                       #preparamos al sistema pra imprimir floats en double precision
    syscall                         #llamada al sistema
        
    sdc1 $f12, matrix($t3)          #metemos $f12 en la matrix en la celde de $t3
    add $t3, $t3, $t2               #le añadimos 8   doble de 8 en 8
        
    li $v0, 4                       #preparamos la escritura por consola
    la $a0, endl                    #imprimimos un salto de linea
    syscall                         #llamada al sistema
        
    j do                            #salto al do


#################_RECURSIVA_#################
	if2:

    li $v0, 4                       #preparamos la escritura por consola
		la $a0, n_val				            #escribimos n_val por consola
		syscall					       	        #llamada al sistema
        
		li $v0, 5     					        #preparamos al sistema para recibir enteros poc consola
		syscall						              #llamada al sistema
		move $t0, $v0				            #cambiamos el valor introducido por pantalla a otro registro

    sw $t0, matrix($t3)             #metemos en $t0 en la matrix en la celda de $t3
    add $t3, $t3, $t1               #le añadimos 4   entero de 4 en 4
        
		li $v0, 4					              #preparamos la escritura por consola
		la $a0, x_val				            #escribimos x_val por consola
		syscall						              #llamada al sistema
        
		li $v0, 7					              #preparamos al sistema para recibir flotantes por consola
		syscall 					              #llamama al sistema
		mov.d $f12, $f0				          #cambiamos el valor introducido por pantalla a otro registro
        
    sdc1 $f12, matrix($t3)          #metemos $f12 en la matrix en la celde de $t3
    add $t3, $t3, $t2               #le añadimos 8   doble de 8 en 8
        
    li $v0, 4                       #preparamos la escritura por consola
		la $a0, result_fun              #escribimos result_fun por consola
		syscall                         #llamada al sistema
        
    move $a0, $t0                   #movemos el $t0 a $a0 para pasarlo a la funcion
        
    jal fr                          #jump and link to fi
    mov.d $f12, $f0                 #movemos el $f0 que llega de la funcion a $f12 para retornarlo
    li $v0, 3                       #preparamos al sistema pra imprimir floats en double precision
    syscall                         #llamada al sistema
        
    sdc1 $f12, matrix($t3)          #metemos $f12 en la matrix en la celde de $t3
    add $t3, $t3, $t2               #le añadimos 8   doble de 8 en 8
        
    li $v0, 4                       #preparamos la escritura por consola
    la $a0, endl                    #imprimimos un salto de linea
    syscall                         #llamada al sistema
        
    j do                            #salto al do


  imp_matrix:                       #etiqueta imp_matrix
  
    li $v0, 4                       #preparamos la escritura por consola
    la $a0, tab_res                 #escribimos tab_res por consola
    syscall

    div $t0, $t3, 20                #$t0 = $t3 / 20  para contar el numero de filas
    li $t3, 0                       #reescribimos $t3 en 0


    for_matrix:                     #etiqueta for_matrix

      bge $t3, $t0, fin_prog        #if ($t3 > $t0) fin_prog, 

      beq $t3, 10, fin_prog         #if ( $t3 == 10) fin_prog, 10 num max de iteraciones 

      for_matrix2:                  #etiqueta for_matrix2

        lw $t4, matrix($t5)         #cargamos el elemento entero de la matrix (N)

        li $v0, 1                   #preparamos al sistema para imprimir un entero
        move $a0, $t4               #imprimimos el entero
        syscall                     #llamada al sistema

  
        li $v0, 4                   #preparamos la escritura por consola
        la $a0, espacio             #imprimimos un espacio entre los elementos de la matrix
        syscall                     #llamada al sistema

        add $t5, $t5, $t1           #sumamos 4 (entero) al $t5 que recorre las celdas de la matrix

        ldc1 $f12, matrix($t5)      #cargamos el elemento doble precision de la matrix (X)

        li $v0, 3                   #preparamos al sistema para imprimir un doble precision
        syscall                     #llamada al sistema
 
        li $v0, 4                   #preparamos la escritura por consola
        la $a0, espacio             #imprimimos un espacion entre los elementos de la matrix
        syscall                     #llamada al sistema

        add $t5, $t5, $t2           #sumamos 8 (d.precision) al $t5 que recorre las celdas de la matrix
 
        ldc1 $f12, matrix($t5)      #cargamos el elemento doble precision de la matrix (X)

        li $v0, 3                   #preparamos al sistema para imprimir un doble precision
        syscall                     #llamada al sistema

        li $v0, 4                   #preparamos la escritura por consola
        la $a0, endl                #imprimimos un salto de linea entre los elementos de la matrix
        syscall 

        add $t5, $t5, $t2           #sumamos 8 (d.precision) al $t5 que recorre las celdas de la matrix

        addi $t3, $t3, 1            #sumamos 1 al registo que guarda los valores de las celdas

        j for_matrix                #salto al for_matrix


fin_prog:                           #etiqueta fin del programa
        
	li $v0, 10                        #prepara al sistema para salir
	syscall                           #llamada al sistema