	.data


	.text
main:

//IF   ELSE
	#  if (a<b) {
	#	a++;
	# }
	#else {
	#	b++;
	# }

	#a = $t0 	b=$t1

	bge $t0,$t1,sino	        #g3 -> >= greater equal
		addi $to,1
		j fin_si
	sino:
		addi $t1,
	fin_si

//WHILE
	#while (a<b) {
	#		a++;	
	# }
	#a = $t0 	b=$t1

	bucle: bge $t0,$t1,fin_bucle
			addi $t0,1
			j bucle
	fin _bucle

//FOR
	for (i=0; i < 0; i++) {

	}
    # 
    # 
    # 
    #   i = 0
    #   while(i < a) {
    #       i++;
    #   }
    #


	#salir del programa 

	li $vo,10
	syscall