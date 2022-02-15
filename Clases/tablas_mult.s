.data

titulo: .asciiz "Programa para repasar las tablas de multiplicar\n"
tablas: .asciiz "Que tabla quiere repasar?(Introduzca 0 si quiere salir del programa): "
fin:    .asciiz "FIN DE PROGRAMA."
final:  .asciiz "Has acertado el: "
per:      .asciiz "%\n"
x:  .asciiz "x"
?:  .asciiz "? "
#PORCENTAJE ES REGISTRO T1
.text

  main:

  li $v0,4
  la $a0,titulo
  syscall

  #li -> load immediate (numero)    
  #la -> load adress    (memorio)

  do:

    li $t2,0
    li $t1,100
    li $v0,4
    la $a0,tablas
    syscall
    li $v0,5  #pedir numero por teclado
    syscall
    move $t0,$v0  #guardas el numero introducido en $t0, quye estaba en $v0

    beqz $t0,fin_programa #si, $t0 == 0, escribir etiqueta fin_programa

    for:
      bge $t2,10,fin_for

        addi $t2,1
        li $v0,1
        move $a0,$t0
        syscall

        li $v0,4
        la $a0,x
        syscall

        li $v0,1
        move $a0,$t2
        syscall

        li $v0,4
        la $a0,?
        syscall

        li $v0,5
        syscall
        move $t4,$v0

        mult $t0,$t2
        mflo $t3

        beq $t4,$t3,acierto

        addi $t1,-10

        acierto:

      j for
    fin_for:

    li $v0,4
    la $a0,final
    syscall
    li $v0,1
    move $a0,$t1
    syscall
    li $v0,4
    la $a0,per
    syscall

  j do


  fin_programa:
  li $v0,4
  la $a0,fin
  syscall
  li $v0,10
  syscall