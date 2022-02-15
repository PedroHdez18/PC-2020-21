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
endl: .asciiz "\n"

		.text

fr:
  #$a0=n
  #$f12 = x
  li.d $f6, 0.5
  bgt $a0, 1, forFr
  beq $a0, 0, retFr0
  beq $a0, 1, retFr1

  retFr0:
  li.d $f0, 0.5
  jr $ra

  retFr1:
  li.d $f0, 1.0
  jr $ra

  forFr:
    addi $sp, -16
    sw $a0,12($sp)
    sw $ra, 8($sp)
    sdc1 $f12, 0($sp)
    addi $a0, -1
    jal fr

    ldc1 $f12,0($sp)
    lw $ra, 8($sp)
    lw $a0, 12($sp)

    addi $sp, -8
    sdc1 $f0, 16($sp)
    sw $a0,12($sp)
    sw $ra, 8($sp)
    sdc1 $f12, 0($sp)

    addi $a0,-2
    jal fr

    ldc1 $f12, 0($sp)
    lw $ra, 8($sp)
    lw $a0, 12($sp)
    ldc1 $f4, 16($sp)
    addi $sp, 24

    mul.d $f0, $f0, $f12
    mul.d $f0, $f0, $f4
    jr $ra
fi:
  #$a0=n
  #$f4, $f12 = x
  mov.d $f4, $f12 #recibe el valor de x
  li.d $f6, 0.5 #registro con 0.5
  mul.d $f4, $f4, $f6 #result

  li.d $f8, 0.0 #aux
  li.d $f10, 1.0 #aux2

  beq $a0, $zero, return0
  beq $a0, 1, return1
  beq $a0, 2, return2

  li $t0, 2
  forFi:
    mul.d $f8, $f4, $f10
    mul.d $f8, $f8, $f12
    mov.d $f10, $f4
    mov.d $f4, $f8
  addi $t0, 1
  blt $t0, $a0, forFi

  mov.d $f0, $f4
  jr $ra
  return0:
    li.d $f0, 0.5
    jr $ra

  return1:
    li.d $f0, 1.0
    jr $ra

  return2:
    mov.d $f0, $f4
    jr $ra
######################MAIN###################
main:

li $v0, 4						#preparamos la escritura por consola
la $a0, titulo					#escribimos el titulo por consola
syscall							#llamada al sistema

#REGISTROS          #VARIABLES
#$a0 				n_val
#$f12				x_val

do:

	li $v0, 4					#preparamos la escritura por consola
	la $a0, intr_opc 			#escribimos el titulo por consola
	syscall 					#llamada al sistema

	li $v0, 5					#preparamos al sistema para recibir enteros por consola
	syscall						#llamada al sistema

	beq $v0, 1, if1				#if ($v0 == 1) if1
	beq $v0, 2, if2				#if ($v0 == 2) if2
	beq $v0, 0, fin_prog		#if ($v0 == 0) fin_prog


		li $v0, 4
		la $a0, msg_error
		syscall
		j do

#################_ITERATIVA_#################
	if1:

		li $v0, 4					#preparamos la escritura por consola
		la $a0, n_val				#escribimos n_val por consola
		syscall						#llamada al sistema

		li $v0, 5					#preparamos al sistema para recibir enteros poc consola
		syscall						#llamada al sistema
		move $t0, $v0				#cambiamos el valor introducido por pantalla a otro registro

		li $v0, 4					#preparamos la escritura por consola
		la $a0, x_val				#escribimos x_val por consola
		syscall						#llamada al sistema

		li $v0, 7					#preparamos al sistema para recibir flotantes por consola
		syscall 					#llamama al sistema
		mov.d $f12, $f0				#cambiamos el valor introducido por pantalla a otro registro

		li $v0, 4
		la $a0, result_fun
		syscall

    move $a0, $t0

    jal fi
    mov.d $f12, $f0
    li $v0, 3
    syscall

    li $v0, 4
    la $a0, endl
    syscall

    j do

#################_RECURSIVA_#################
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

		li $v0, 7					#preparamos al sistema para recibir flotantes por consola
		syscall 					#llamama al sistema
		mov.d $f12, $f0				#cambiamos el valor introducido por pantalla a otro registro

		li $v0, 4
		la $a0, result_fun
		syscall

    move $a0, $t0

    jal fr
    mov.d $f12, $f0
    li $v0, 3
    syscall

    li $v0, 4
    la $a0, endl
    syscall

    j do

fin_prog:

	li $v0, 10                      #prepara al sistema para salir
	syscall