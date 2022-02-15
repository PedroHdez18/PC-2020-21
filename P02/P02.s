#Pedro Hernandez Alonso
#alu0101423944@ull.edu.es
# practica 2. Principio de computadoras
# OBJETIVO: introduce el codigo necesario para reproducir el comportamiento del programa
# C++ que se adjunta como comentarios
# Debes documentar debidamente el uso de los registros que has elegido y la correspondencia
# con las variables que has utilizado.


	.data		# directiva que indica la zona de datos
titulo: 	.asciiz	"Calcula el bit de paridad par de un enteros de 32 bits.\nIntroduzca un 0 para salir del programa.\n "
msgnumero:	.asciiz	"\n\nIntroduzca un entero positivo para calcular su paridad par: "

msgresultado1:	.asciiz	"\nEl número de unos del numero introducido es  "
msgresultado2:	.asciiz	"\nEl bit de paridad par sera "
msgfin:			.asciiz "\nFIN DEL PROGRAMA."


	.text

main:
	# IMPRIME EL TITULO POR CONSOLA
	#    std::cout << "Encuentra el número de veces que aparece una cifra en un entero." << std::endl;
	la $a0, titulo
	syscall

	# EL MAYOR PORCENTAJE DEL CÓDIGO C++ SE ENCUENTRA DENTRO DE UNA ESTRUCTURA do { ...  } while (true).
	# IMPLEMENTA EN MIPS ESE BUCLE INFINITO, Y A CONTINUACIÓN DESARROLLA CADA UNA DE LAS SECCIONES QUE 
	# SE ENCUENTRAN EN SU INTERIOR.

	# INTRODUCE EN ESTA SECCION EL CÓDIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	# TEN EN CUENTA QUE break NO ES SINO UN SALTO A LA SIGUIENTE INSTRUCCION QUE ESTE FUERA DEL BUCLE
	# do { ...  } while (true).

	#        std::cout << "Introduzca un entero positivo para calcular su paridad par: ";
	#        std::cin >> numero;
	#        if (numero == 0) break;
	do:								#comienzo del do			
		li $v0,4					#escribir por consola texto						
		la $a0, msgnumero      	 	#cout 
		syscall
		li $v0,5                	#cin  ,leer por consola
		syscall
		move $t2, $v0           	#v0 -> v0

		beqz $t2, end_do  	#if ($t2 == 0) break;   branch equal zero

	# INTRODUCE EN ESTA SECCION EL CODIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	# El desplazamiento a la derecha de un registro entero en MIPS se hace mediante la
	# instruccion srl reg_destino, reg_origen, bits_a_desplazar

	# int unos = 0; // numero de unos que tiene numero
	#for (int i = 0; i < 32 ; i++) {
	#            int lsb = (numero & 1); // lsb contendrá un 1
	#            unos += lsb;
	#            numero = numero >> 1;
	#        }
	#
	#        std::cout << "El número de unos del numero introducido es " << unos << std::endl;
		move $t4,$zero			    #declaramos una nueva variale (unos)
		move $t6,$zero				#declaramos una nueva variale (i)

		for: 
			bgeu $t6,32, end_for	#branch greater or Equal (>=)
			rem $t8, $t2,2 	        #obtenemos el resto de $t2 entre 2 y lo guardamos en $t8
			beq $t8, $zero, end_if 	#if ($t8 == 0) break;
				addi $t4,1 			#if ($t8 == 0); {$t4+1}
			end_if:					#si $t8 == 0 -> end_if;    sino addi$t4,1;
			srl $t2, $t2,1			#Shift Right Logical, elimina de der a izq bits de un numero binairo
			addi $t6,1 				#++$t6  ->  ++i
			j for  					#salto al principio del for  (jump)
		end_for:					#terminamos el for

		li $v0,4					#escribir por consola
		la $a0, msgresultado1       #cout 
		syscall
		li $v0,1 					#preparamos a la consaola para que escriba enteros	
		move $a0, $t4               #cout  $t4 (unos)
		syscall

		# INTRODUCE EN ESTA SECCION EL CÓDIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
		# Existen diferentes maneras de realizar el código paridad_par = ((unos % 2) != 0);
		# puedes usar condicionales u operaciones lógicas (practica pensando como se puede hacer de una forma u otra)

		#        int paridad_par = ((unos % 2) != 0);
		#        std::cout << "El bit de paridad par sera " << paridad_par << std::endl;
		rem $s2, $t4, 2 			#reduciendo	en algunos casos las iteraciones que se	hacen para contar los unos que tiene el	número declaramos la variable $s2 (paridad_par)
		move $s4, $zero				#declaramos  $s4 = 0 
		beqz $s2, end_if2		#if ($s2 == 0) break;
			addi $s4,1				#si $s4 == 0 -> end_if;    sino addi$s4,1;
			j end_if2				#salto al principio del if2  (jump)		
		end_if2:

		li $v0,4					#escribir por consola
		la $a0, msgresultado2       #cout 
		syscall
		li $v0,1 					#preparamos a la consaola para que escriba enteros	
		move $a0, $s4				#cout  $s2 (paridad_par)
		syscall

		# las siguientes instrucciones  imprimen la cadena de fin y finalizan el programa
		j do 						#while (true);
	end_do:							#termina el do
	li $v0,4
	la $a0, msgfin					#cout 
	syscall
	li $v0,10
	syscall
 
