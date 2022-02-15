#Pedro Hernandez Alonso
#alu0101423944@ull.edu.es

#Alejandro Rodriguez Mederos
#_____PON TU ALU____
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
#   int n;
#   float x;
#   int m;
#   do {
#     cout << "Introduzca opcion. <1>Iterativa <2>Recursiva <0>Salir: ";
#     cin >> m;
#     if(m==0){
#       cout << "Tabla de resultado: " << endl;
#       exit(EXIT_SUCCESS);
#     }
#     cout << "Introduzca el valor de n: ";
#     cin >> n;
#     cout << "Introduzca el valor de x: ";
#     cin >> x;
#     if (n==0) {
#       cout << "Resultado de la llamada de la funcion: 0.5" << endl;
#     }else if(n==1){
#       cout << "Resultado de la llamada de la funcion: 1" << endl;
#     }else if(n>1){
#       if (m==2) {
#         cout << "Resultado de la llamada de la funcion: " << fr(n,x) << endl;
#       }else if (m==1){
#         cout << "Resultado de la llamada de la funcion: " << fi(n,x) << endl;
#       }else{
#         cout << "La opcion elegida es incorrecta." << endl;
#         exit(EXIT_SUCCESS);
#       }
#     }else{
#       cout << "El valor introuducido es menor que 0, porfavor introduzca un valor igual o mayor.";
#       exit(EXIT_SUCCESS);
#     }
#   } while (true);
#   return 0;
# }


		.data

titulo: 	.asciiz "PRACTICA 5. PRINCIPIOS DE COMPUTADORES.\n"
intr_opc:	.asciiz "Introduzca opcion. <1> Iterativa <2> Recursiva <0> Salir: "
msg_error:	.asciiz "Ha introuducido una opcion incorrecta, vuelva a introducirla. \n"
tab_res:	.asciiz "Tabla de resultados: \n"
n_val:		.asciiz "Introduca el valor de n: "
x_val:		.asciiz "Introduzca el valor de x: "
result_fun:	.asciiz "Resultado de la llamada de la funcion: "
endl: 		.asciiz "\n"

		.text

fi:
    li $v0, 2
    mov.s $f4, $f12                 # se carga en $f4 el valor $a0(n)
    mov.s $f5, $f13                 # se carga en $f5 el valor $a1(x)

    li.s $f6, 0.5                      # se inicializa $t6 con 0.5
    mul.s    $f7, $f6, $f5            # el registro $f7(result) se carga con la multiplicacion de $f6(0.5) y $f5(x)
    li.s $f8, 0.0                        #    se inicializa $f8(aux) con 0.0
    li.s $f9, 1.0                        # se inicializa $f9(aux2) con 1.0
    li $t0, 2                                # se inicializa $t0(i) con 2
    cvt.w.s $f0, $f4
    mfc1 $t1, $f0
    li.s $f11, 2.0
#DETECTAR
    c.eq.s $f4, $f8
    bc1t return0
    c.eq.s $f4, $f9
    bc1t return1
    c.eq.s $f4, $f11
    bc1t return2

        loopFi:
            mul.s $f10, $f7, $f9
            mul.s $f12, $f10, $f5
            mov.s $f9, $f7
            mov.s $f7, $f8
        addi $t0, 1
        blt $t0, $t1 loopFi

    mov.s $f0, $f7                     # cargar el resultado en $f0
    jr $ra                                    # return

return0:
    li.s $f0, 0.5
    jr $ra                                    # return
return1:
    li.s $f0, 1.0
    jr $ra                                    # return
return2:
    mov.s $f0, $f7
    jr $ra                                    # return


main:

li $v0, 4							#preparamos la escritura por consola
la $a0, titulo						#escribimos el titulo por consola
syscall								#llamada al sistema


	#REGISTROS          #VARIABLES  
	#$t0 				n_val
	#f4					x_val

li 	 $t0, 0
li.s $f4, 0.0



do:

	li $v0, 4						#preparamos la escritura por consola
	la $a0, intr_opc 				#escribimos el titulo por consola
	syscall 						#llamada al sistema

	li $v0, 5						#preparamos al sistema para recibir enteros por consola
	syscall							#llamada al sistema
	#move $__, $v0					#cambiamos el valor introducido por pantalla a otro registro

	beq $v0, 1, if1					#if ($v0 == 1) if1
	beq $v0, 2, if2					#if ($v0 == 2) if2
	beq $v0, 0, fin_prog			#if ($v0 == 0) fin_prog

	bne $v0, 1, error_opc			#if ($v0 != 1) error_opc
	bne $v0, 2, error_opc			#if ($v0 != 2) error_opc
	bne $v0, 0, error_opc			#if ($v0 != 0) error_opc

	error_opc:

		li $v0, 4
		la $a0, msg_error
		syscall
		j do


	if1:

		li $v0, 4																#preparamos la escritura por consola
		la $a0, n_val														#escribimos n_val por consola
		syscall																	#llamada al sistema

		li $v0, 6																#preparamos al sistema para recibir enteros por consola
		syscall																	#llamada al sistema
		mov.s $f12, $f0													#cambiamos el valor introducido por pantalla a otro registro

		li $v0, 4																#preparamos la escritura por consola
		la $a0, x_val														#escribimos x_val por consola
		syscall																	#llamada al sistema

		li $v0, 6																#preparamos al sistema para recibir flotantes por consola
		syscall 																#llamama al sistema
		mov.s $f13, $f0													#cambiamos el valor introducido por pantalla a otro registro

		li $v0, 4
		la $a0, result_fun
		syscall

		jal fi
		mov.s $f14, $f0
		li $v0, 2
		syscall

		li $v0, 4
		la $a0, endl
		syscall
		
		j do


	if2: 

		li $v0, 4					#preparamos la escritura por consola
		la $a0, n_val				#escribimos n_val por consola
		syscall						#llamada al sistema

		li $v0, 5					#preparamos al sistema para recibir enteros poc consola
		syscall						#llamada al sistema
		move $t0, $v0				#cambiamos el valor introducido por pantalla a otro registro

		li $v0, 4					#preparamos la escritura por consola
		la $a0, x_val				#escribimos x_val por consola
		syscall						#llamada al sistema

		li $v0, 6					#preparamos al sistema para recibir flotantes por consola
		syscall 					#llamama al sistema
		mov.s $f4, $f0				#cambiamos el valor introducido por pantalla a otro registro







		li $v0, 4
		la $a0, result_fun
		syscall


fin_prog:
	
	li $v0, 10                      #prepara al sistema para salir
	syscall