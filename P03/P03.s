#Pedro Hernandez Alonso
#alu0101423944@ull.edu.es
#practica 3. Principio de computadoras

# Pseudocódigo
# #include <iostream>
# int main() {
#   int i = 2;
#   float E_num = 1; 
#   float E_aux = 1; 
#   float aux = 1; 
#   float error;

#   std::cout << "Practica 3. PRINCIPIOS DE COMPUTADORES" << std::endl;
#   std::cout << "Introduce el error maximo permitido: ";
#   std::cin >> error;
  
#   do {
#     if (error < 0){
#         std::cout << "Introduzca un numero valido (positivos): ";
#         std::cin >> error;
#     }
#     E_num += 1/aux;
#     aux = aux*i;
#     if (E_num-E_aux <= error){
#       break;
#     }
#     E_aux = E_num;
#     ++i;
#   } while (true);
#   std::cout << "\nNumero e: " << E_num << std::endl;
#   std::cout << "Terminos calculados: " << i << std::endl;
# }


    .data
titulo:      .asciiz "PRACTICA 3. PRINCIPIOS DE COMPUTADORES.\n"
intr_error:  .asciiz "Introduzca el error maximo permitido: "
num_e:       .asciiz "Numero e: "
term_calc:   .asciiz "\nTerminos calculados: "
final:       .asciiz "\n\nFIN DEL PROGRAMA.\n"

    #VARIABLES          #REGISTROS        
    #error              $f4
    #E_num{1}           $f5
    #E_aux{1}           $f6
    #aux{1}             $f7
    #i{2.0}             $f8
    #1/aux              $f9
    #var.1{1}           $f10
    #aux*i              $f16
    #E_num-E_aux        $f20

    .text

main:

    li $v0, 4                       #prepara la escritura por consola
    la $a0, titulo                  #escribimos el titulo por consola
    syscall

    la $a0, intr_error              #escribimos intr_error por consola
    syscall

    li $v0, 6                       #flotante  /  cin
    syscall 
    mov.s $f4, $f0                  #mover el numero introducido por pantalla a otro registro

    li.s $f5,  1.0                  #inicializamos variables en presicion simple
    li.s $f6,  1.0                  #inicializamos variables en presicion simple
    li.s $f7,  1.0                  #inicializamos variables en presicion simple
    li.s $f8,  2.0                  #inicializamos variables en presicion simple
    li.s $f10, 1.0                  #inicializamos variables en presicion simple

    do:
        div.s $f9, $f10, $f7        #$f9  = $f10 /  $f7     1/aux
        add.s $f5,  $f5, $f9        #$f5  = $f5  +  $f9     E_num += 1/aux
        mul.s $f7, $f7, $f8         #$f7  = $f7  *  $f8      aux = aux*i
        sub.s $f20, $f5, $f6        #$f20 = $f5  -  $f6     $f20 = E_num-E_aux

        c.le.s $f20, $f4            #$f20 <= $f4            if (E_num-E_aux <= error)

        bc1t do_fin                 #complementaria de la funcion, salto condicional si cond es cierto

        mov.s $f6, $f5              #$f6  = $f5              E_aux = E_num

        add.s $f8, $f8, $f10        #$f8  = $f8  +  $f10    i = i + 1   /   ++i

        j do                        #salto al do
    do_fin:

    li $v0, 4                       #prepara la escritura por consola
    la $a0, num_e                   #escribimos num_e por consola
    syscall

    mov.s $f12, $f5                 #almacena el valor de $f5 en $f12
    li $v0, 2                       #prepara la escritura de floats por consola
    syscall 

    li $v0, 4                       #prepara la escritura por consola
    la $a0, term_calc               #escribimos term_calc por consola
    syscall 

    cvt.w.s $f0, $f8                #convierte #f10(float i) en $f0(int i)
    li $v0, 1                       #prepara ela escritura de enteros por consola
    mfc1 $a0, $f0                   #almacena  el valor de $f0 en $a0 
    syscall    

    li $v0, 4                       #prepera la escritura por consola
    la $a0, final                   #escribimos final por consola
    syscall                         

    li $v0, 10                      #prepara al sistema para salir
    syscall

# PREGUNTAS

# 1)  Linea 101-108

# 2)  Registros en punto flotante en precision simple porque usamos numeros con 
# decimales, debido al uso de la precision simple, no es necesario usar únicamente 
# los registros pares 

# 3)  Para transformar nuestro programa en doble precision tendríamos que tener en
# cuanta que todas las instrucciones, tanto aritméticas, de carga y almacenamiento y
# de salto y comparacion.
# Otro aspecto a tener en cuanta es que deberiamos usar registros pares, pues en
# precision doble los registros van de 2 en 2