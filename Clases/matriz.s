#sumar los elementos de la columna 2
size = 4  #desplazamiento de 4 
nfil = 4
ncol = 5

.data
matriz:	.word 1, 2, 3, 4, 5
  		.word 6, 7, 8, 9, 10
  		.word 11, 12, 13, 14, 15  #14= matriz[2][3] = 5*4*2 + 3*4 = 40+12 = = 52
  		.word 16, 17, 18, 19, 20

#desplazamiento para acceder al elemento matriz[i][j] = ncol*size*i + j*size
#desplazamiento = lo que ocupan los anteriores
#una fila ocpupa 20, ncol*size
#despl = size(ncol*i+j)



.text

main:

 # j = 2
 # for (i  =0: i < nfil; i+++)
 # 	suma += matriz[i][j]
 # i = $t1 
 # j = $t2
 # suma = $s0

 li $t2, 2
 li $s0, 0
 li $t1, 0

 la $t5, matriz

 bucle:	bge $t1, nfil, finbucle

 	#poner en $t3 matrz[i][j]
 	mul $t4, $t1, ncol
 	add $t4, $t4, $t2
 	mul $t4, $t4, size
 	add $t4, $t4, $t5
 	
 	lw $t3, 0($t4)

 	add $s0, $s0, $t3
 	addi $t1, 1
 	j bucle
 finbucle:

move $a0, $s0

li $v0,1
syscall

li $v0,10
syscall