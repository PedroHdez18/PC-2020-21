#Pedro Hernandez Alonso
#alu0101423944@ull.edu.es
#Practica 5A. Principio de computadoras

# Pseudocódigo
# include <iostream>
# int main () {
# 	const int nrows = 4;
# 	const int ncols = 3;
# 	int matrix [nrows] [ncols] = {{11,12,13},
# 							  	  {21,22,23},
# 							  	  {31,32,33},
# 							 	  {41,42,43}};
# 	int opc;
# 	int x = 0, y = 0;
# 	int aux;
# 	do {
# 		//imprimir la matriz por consola
# 		for (int i = 0; i < nrows; i++){
# 			for (int j = 0; j < ncols; j++){
# 				std::cout << matrix[i][j] << " ";
# 			}
# 			std::cout << std::endl;
# 		}
# 		//preguntar por la opcion
# 		std::cout << "<1> Cambiar filas, <2> Cambiar columnas, <0> Salir: ";
# 		std::cin >> opc;
# 		if (opc == 0) break;
# 		else if (opc == 1){
# 			//intercambiar filas 
# 			do {
# 				std::cout << "Introduzca dos enteros, los indices de las filas a cambiar: ";
# 				std::cin >> x;
# 				std::cin >> y;
# 			} while ((x < 0)  ||  (x >= nrows)  || (y < 0)  || (y >= nrows));
# 				for (int j = 0; j < ncols; j++){
# 					aux = matrix[x][j];
# 					matrix[x][j] = matrix[y][j];
# 					matrix[y][j] = aux;
# 				}
# 		} else if (opc == 2){
# 			//intercambiar columnas
# 			do {
# 				std::cout << "Introduzca dos enteros, los indices de las columnas a cambiar: ";
# 				std::cin >> x;
# 				std::cin >> y;
# 			} while ((x < 0)  ||  (x >= ncols)  || (y < 0)  || (y >= ncols));
# 				for (int i = 0; i < nrows; i++){
# 					aux = matrix[i][x];
# 					matrix[i][x] = matrix[i][y];
# 					matrix[i][y] = aux;
# 				}	
# 		} else 
# 			std::cout << "Ha introducido una opcion invalida. Vuelve a repetir. \n";
# 	} while (true);
# 	std::cout << "Fin del programa\n";
# 	return 0;
# }


size = 4 #bytes que ocupa cada elemento

		.data

titulo:		.asciiz "PRACTICA 5. PRINCIPIOS DE COMPUTADORES.\n"
intr_opc: 	.asciiz "Introduzca opcion. <1> Intercambia filas, <2> Intercambia columnas, <0> Salir: "
intr_2_row:	.asciiz "Introduzca dos enteros con las filas que se deben intercambiar [0-3]: \n"
intr_2_col:	.asciiz "Introduzca dos enteros con las columnas que se deben intercambiar [0-2]: \n"
msg_error1:	.asciiz "Ha introuducido una opcion incorrecta, vuelva a introducirla. \n\n"
msg_error2:	.asciiz "Ha introducido valores erroneos, vuela a introducirlos. \n\n"
espacio: 	.asciiz " "
end_line:	.asciiz "\n"



matrix: 	.word	11, 12, 13
			.word	21, 22, 23
			.word	31, 32, 33
			.word	41, 42, 43

nrows:		.word	4
ncols:		.word	3

			.text

main:

do:

	li $v0, 4                       #prepara la escritura por consola
	la $a0, titulo                  #escribimos el titulo por consola
	syscall							#llamada al sistema


	#REGISTROS          #VARIABLES      
	#$t0				recorrer matriz
	#$t1				elemento de la matriz
	#$t2				variable bucle i
	#$t3				variable bucle j
	#$t4				variable detector final matriz
	#$t5				size
	#$t6				nrows -> 4
	#$t7				ncols -> 3
	#$t8 				x -> cambiar rows/cols
	#$t9 				y -> cambiar rows/cols


	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t4, 0
	li $t5, size
	lw $t6, nrows
	lw $t7, ncols	
	li $t8, 0


	bucle1:							#primer bucle

	li $t3, 0						#resetear la variable $t3 a 0 -> 0

		bucle2:						#segundo bucle

		lw $t1, matrix($t0)			#el t1 almacena el contenido de la celda dado por t0   lw->load word, cargar
		li, $v0, 1					#preparamos al sistema para escribir enteros por pantalla  
		move $a0, $t1				#std::cout << A[i][j];
		syscall						#llamamos al sistema

		li $v0, 4					#preparamos la escritura por pantalla
		la $a0, espacio				#std::cout << " ";
		syscall						#llamamos al sistema

		add $t0, $t0, $t5			#nos movemos de 4 en 4 bytes

		addi $t3, 1					#j++ -> $t3++
		blt $t3, $t7, bucle2		#if ($t3 < $t7) bucle2

		li $v0, 4					#preparamos la escritura por pantalla
		la $a0, end_line			#escribimos un endl
		syscall						#llamamos al sistema

		addi $t2, 1					#i++ -> $t2++
		blt $t2, $t6, bucle1		#if ($t2 < $t6) bucle1


eleg_opc:							#etiqueta eleg_opc

	li $v0, 4						#preparamos el sistema para escribir por pantalla
	la $a0, intr_opc				#imprimimos el intr_opc por pantalla
	syscall							#llamamos al sistema

	li $v0, 5						#preparamos al sistema para recibir enteros por consola
	syscall							#llamamos al sistema


beq $v0, 1, if1						#if ($v0 == 1) if1
beq $v0, 2, if2						#if ($v0 == 2) if2
beq $v0, 0, fin_prog				#if ($v0 == 0) fin_prog


li $v0, 4							#preparamos el sistema para escribir por pantalla
la $a0, msg_error1					#imprimimos el msh_error1 por pantalla
syscall								#llamamos al sistema
j eleg_opc							#salto a la etiqueta eleg_opc


if1: 								#filas   [0-3]		multi x12 y sumas 4

	li $v0, 4						#preparamos el sistema para escribir por pantalla
	la $a0, intr_2_row				#imprimimos el intr_2_row por pantalla
	syscall							#llamamos al sistema

	li $v0, 5						#preparamos al sistema para recibir enteros por consola
	syscall							#llamamos al sistema
	move $t8, $v0					#cambiamos el numero introducido por pantalla a otro registro 

	li $v0, 5						#preparamos al sistema para recibir enteros por consola
	syscall							#llamamos al sistema
	move $t9, $v0					#cambiamos el numero introducido por pantalla a otro registro 


	#Comprobamos si los numeros que se introducen para intercambiar las filas son validos
	blt $t8, 0, error1				#if ($t8 <= 0) error1
	bgt	$t8, 3, error1				#if ($t8 >= 3) error1
	blt $t9, 0, error1				#if ($t9 <= 0) error1
	bgt	$t9, 3, error1				#if ($t9 >= 3) error1

	li $t0, 0						#reescribimos registros
	li $t1, 0						#reescribimos registros
	li $t2, 0						#reescribimos registros
	li $t4, 0						#reescribimos registros
	mul $t4, $t7, $t5				#$t4 = $t7 * $t5    12 = ncols * size

	mul $t8, $t8, $t4				#$t8 = $t8 * $t4		12 porque el siguiente elemento de encuentra a 12 bits
	mul $t9, $t9, $t4				#$t8 = $t8 * $t4		12 porque el siguiente elemento de encuentra a 12 bits	

	for1:							#tercer bucle

		lw $t0, matrix($t8)			#el t0 almacena el contenido de la celda dado por t8
		lw $t1, matrix($t9)			#el t1 almacena el contenido de la celda dado por t9

		sw $t1, matrix($t8)			#cargamos en el vector de matrix
		sw $t0, matrix($t9) 		#cargamos en el vector de matrix

		add $t8, $t8, $t5			#$t8 = $t8 + $t5		sumas 4 porque el siguiente elemento se encuentra a 4 bytes
		add $t9, $t9, $t5			#$t9 = $t9 + $t5		

		addi $t2, $t2, 1			#$t2++

		blt $t2, $t7, for1			#if ($t2 < $t7) for

	j do 							#salto al do


if2:								#columnas [0-2] 		multi x4 y sumas 12

	li $v0, 4						#preparamos al sistema para recibir enteros por consola
	la $a0, intr_2_col 				#imprimimos el intr_2_row por pantalla
	syscall 						#llamada al sistema

	li $v0, 5						#preparamos al sistema para recibir enteros por consola
	syscall							#llamamos al sistema
	move $t8, $v0 					#cambiamos el numero introducido por pantalla a otro registro

	li $v0, 5						#preparamos al sistema para recibir enteros por consola
	syscall							#llamamos al sistema
	move $t9, $v0 					#cambiamos el numero introducido por pantalla a otro registro

	#Comprobamos si los numeros que se introducen para intercambiar las filas son validos
	blt $t8, 0, error2				#if ($t8 <= 0) error2
	bgt	$t8, 2, error2				#if ($t8 >= 2) error2
	blt $t9, 0, error2				#if ($t9 <= 0) error2
	bgt	$t9, 2, error2				#if ($t9 >= 2) error2

	li $t0, 0						#reescribimos registros
	li $t1, 0						#reescribimos registros
	li $t2, 0						#reescribimos registros
	li $t4, 0						#reescribimos registros
	mul $t4, $t7, $t5				#$t4 = $t7 * $t5    12 = ncols * size

	mul $t8, $t8, $t5				#$t8 = $t8 * $t5		12 porque el siguiente elemento de encuentra a 12 bits
	mul $t9, $t9, $t5				#$t8 = $t8 * $t5		12 porque el siguiente elemento de encuentra a 12 bits	

	for2:

		lw $t0, matrix($t8)			#el t0 almacena el contenido de la celda dado por t8
		lw $t1, matrix($t9)			#el t1 almacena el contenido de la celda dado por t9

		sw $t1, matrix($t8)   		#cargamos en el vector de matrix
		sw $t0, matrix($t9)			#cargamos en el vector de matrix

		add $t8, $t8, $t4			#$t8 = $t8 + $t4
		add $t9, $t9, $t4 			#$t9 = $t9 + $t4

		addi $t2, $t2, 1			#t2++

		blt $t2, $t6, for2 			#if ($t2 < $t6) for2

	j do 							#salto al do

#Etiquetas para los errores
error1: 							#etiqueta error 1

	li $v0, 4                       #prepara la escritura por consola
	la $a0, msg_error2 				#imprimimos el msg_error2 por pantalla
	syscall							#llamamos al sistema
	j if1 							#salto al if1

error2: 							#etiqueta error 2

	li $v0, 4                       #prepara la escritura por consola
	la $a0, msg_error2 				#imprimimos el msg_error2 por pantalla
	syscall							#llamamos al sistema
	j if2 							#salto al if2

fin_prog:							#etiqueta fin del programa
	
	li $v0, 10                      #prepara al sistema para salir
	syscall							#llamamos al sistema