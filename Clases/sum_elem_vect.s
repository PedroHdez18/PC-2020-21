

size = 4
n = 10

.data
vect:	.word 	2, 1, 4, 3, 6, 5, 8, 7, 10, 9   #vector definido
#vect:	.space(100)  				   #lo que ocupa 100 bytes, 25

.text

main:


# suma = 0
# for (i = 0; i <n; i++)
# 	suma += vect[i]

# suma es $s0, i es $t1

li $s0, 0
li $t1, 0

for: bge $t1, n, finfor

	#voy a caragr en $t2 vect[i]
	la $t3, vect
	mul $t4, $t1, size
	add $t5, $t4, $t3
	lw $t2, 0($t5)
	add $s0, $s0, $t2
	addi $t1, 1
	j for
finfor:

move $a0, $s0

li $v0,1
syscall

	
li $v0,10
syscall

