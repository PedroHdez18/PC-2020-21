size = 4 # tamano de un entero
nrows = 3   # numero de filas 
ncols = 2   # numero de columnas 
    .data
matrix: .float 1.0, 2.0, 3.0, 4.0, 5.0, 3.0
cad0: 	.asciiz "PRACTICA 4  Pedro Hernandez Alosno"
cad1:   .asciiz "Elija opcion: <1> Modificar matriz <0> Salir: "
cad2:   .asciiz "\nIntroduzca valor que se debe sustituir: "
cad3:   .asciiz "\nIntroduzca valor de reemplazo: "
cad4:   .asciiz "\nNumero de sustituciones realizadas: "
cad5:   .asciiz "\nOpcion introducida no valida. Vuelva a intentarlo.\n"
cad6: 	.asciiz "\n"


    .text
# funcion que imprime una matriz de flotantes simple precision
# Argumentos de entrada: $a0 direccion de memoria de la matriz
#                        $a1 numero de filas
#						 $a2 numero de columnas
printmatrix:
    move $t0,$a0 
    li $t1,0
    filas_printmat:
       	li $t2,0
		cols_printmat:
			l.s $f12,0($t0)
			li $v0,2
			syscall
	        li $a0,32
	        li $v0,11
	        syscall
			addi $t2,1
			addi $t0,4
			blt $t2,$a2,cols_printmat
	    li $a0,13
	    li $v0,11
	    syscall     
        addi $t1,1
        blt $t1,$a1,filas_printmat
        jr $ra


reemplaza:

move $t0, $a0
    mov.s $f6, $f12
    mov.s $f7, $f13



jr $ra


main:

do:

	li $v0, 4 
	la $a0, cad0
	syscall
	la $a0, cad6
	syscall

	la $a0, matrix
	la $a1, nrows
	la $a2, ncols

	jal printmatrix

	opc:
	li $v0, 4 
	la $a0, cad1
	syscall


	li $v0, 5
  	syscall
  	move $t0, $v0


  	beq $t0, 0, salir
  	beq $t0, 1, correcto



  	error:
  	li $v0, 4
  	la $a0, cad5
  	syscall
 	j opc

 	correcto:
  	li $v0, 4
  	la $a0, cad2
  	syscall

  	li $v0, 6
  	syscall 
  	mov.s $f12, $f0

  	li $v0, 4
  	la $a0, cad3
  	syscall

    li $v0, 6
  	syscall 
  	mov.s $f13, $f0


	la $a0, matrix
	la $a1, nrows
	la $a2, ncols 


  	jal reemplaza
	

    salir:
        li $v0,10
        syscall