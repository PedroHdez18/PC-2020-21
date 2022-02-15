size = 4 # tamano de un entero
nrows = 2   # numero de filas de la matriz
ncols = 3   # numero de columnas
    .data
matrix: .word 1, -1, -2, -2, 5, -3
cad1:   .asciiz "Elija opcion: <1> Modificar columna <0> Salir: "
cad2:   .asciiz "Introduzca el indice de la columna [0 a ncols-1]: "
cad3:   .asciiz "\nOpcion introducida no valida. Vuelva a intentarlo.\n"
cad4:   .asciiz "\nIndice incorrecto. Vuelva a intentarlo.\n"
fin: 		.asciiz "\nFIN DEL PROGRAMA"
endl: 	.asciiz "\n"
    .text
# funcion que imprime una matriz de enteros
# Argumentos de entrada: $a0 direccion de memoria de la matriz
#                        $a1 numero de filas
#						 $a2 numero de columnas

detectar:
	mul $t0, $a3, size
	li $t7, 0
	li $t2,0 #i

		for2:
			lw $t8,matrix($t0)
			blt $t8, 0, suma
			j nosum
			suma:
			addi $t7, 1
			nosum:
			addi $t0,12
			addi $t2,1
			blt $t2,$a1,for2

	move $v0, $t7
	jr $ra

printmatrix:
    move $t0,$a0
    li $t1,0

    filas_printmat:
       	li $t2,0
		cols_printmat:
			lw $a0,0($t0)
			li $v0,1
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


main:
	la $a0, matrix
	la $a1, nrows
	la $a2, ncols

	jal printmatrix

title:
	li $v0, 4
	la $a0, cad1
	syscall

	li $v0, 5
	syscall
	move $t5, $v0
	j do

	error:
		li $v0, 4
		la $a0, cad3
		syscall
	j title

	do:
		blt $t5, 0, error
		bgt $t5, 1, error
		beq $t5, 0, final
#######COMPROBAR-INDICE##########
		la $t3, ncols
		sub $t3, $t3, 1
	opcion:
		li $v0, 4
		la $a0, cad2
		syscall

		li $v0, 5
		syscall
		move $t6, $v0
	j do2

		error2:
			li $v0, 4
			la $a0, cad4
			syscall
			j opcion

		do2:
		blt $t6, 0, error2
		bgt $t6, $t3, error2

		move $a3, $t6

		jal detectar
		move $t7, $v0

		li $v0, 1
		move $a0, $t7
		syscall

		li $v0, 4
		la $a0, endl
		syscall

		j main

final:
	li $v0, 4
	la $a0, fin
	syscall

li $v0,10
syscall