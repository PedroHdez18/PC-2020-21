size = 4 # tamano de un entero
nrows = 8   # numero de filas de la matriz
    .data
matrix: .word 1, 3, 2, 5, 0, 4, 6, 7
endl:   .asciiz "\n"
cad1:   .asciiz "Elija opcion: <1> Modificar vector <0> Salir: "
cad2:   .asciiz "Introduzca el indice del vector [0 a 7]: "
cad22:   .asciiz "Introduzca el exponente: "
cad3:   .asciiz "\nOpcion introducida no valida. Vuelva a intentarlo.\n"
cad4:   .asciiz "\nIndice incorrecto. Vuelva a intentarlo.\n"

    .text
# funcion que imprime una matriz de enteros
# Argumentos de entrada: $a0 direccion de memoria de la matriz
#                        $a1 numero de elementos

vector:
  move $t0, $a0
  move $t1, $a1
  move $t7, $a1
  addi $t1, -1

  li $t4, 0
  li $t2, 0 #i=0
  for:
    lw $t3, matrix($t4)
    beq $t2, $t0, encontrado
    addi $t4, size
    addi $t2, 1
    blt $t2, $t0, for
    move $t7, $t3
  encontrado:
  li $t5, 0 #j=0
    for2:
      mul $t7, $t7, $t3
      addi $t5, 1
      blt $t5, $t1, for2

  move $v0, $t7
  jr $ra

printmatrix:
    move $t0,$a0
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
            blt $t2,$a1,cols_printmat
        li $a0,13
        li $v0,11
        syscall
  jr $ra # salto al jal con los valores


main:

  la $a0, matrix
  la $a1, nrows

  jal printmatrix

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
  la $a0, cad3
  syscall
  j main
  correcto:

  li $v0, 4
  la $a0, cad2
  syscall

  li $v0, 5
  syscall
  move $t0, $v0

  li $v0, 4
  la $a0, cad22
  syscall

  li $v0, 5
  syscall
  move $t1, $v0

  move $a0, $t0
  move $a1, $t1

  jal vector
  move $t0, $v0

  li $v0, 1
  move $a0 $t0
  syscall
  j main

  salir:
li $v0,10
syscall