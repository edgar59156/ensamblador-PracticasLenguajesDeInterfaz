
include "macros.asm"         ;Inclusion del archivo que contiene las macros
 
.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria

 ;Definicion de las etiquetas
presentacion DB 10,13 ,'CALCULADORA BASICA','$' 
opcion1 db 10,13 , '1.SUMAR A Y B ','$'  
opcion2 db 10,13 , '2.RESTAR A Y B ','$'
opcion3 db 10,13 , '3.MULTIPLICAR A Y B','$'
opcion4 db 10,13 , '4.DIVIDIR A Y B ','$'
opcion5 db 10,13 , '5.SALIR','$'
opcion db 10,13 , 'ELIJA SU OPCION : ','$' 
msg0 db 10,13 , 'Ingrese numero A: ','$'
msg1 db 10,13 , 'Ingrese numero B: ','$'  
espacio db 10,13,'','$'  
cont dw 0
r1 dw 0
r2 dw 0
resultado dw 0
aux dw 0 
digitos dw 100
u dw 0                              
d dw 0                                                        
n dw 0
a dw 0
b dw 0
c dw 0  

.CODE                        ;Define el segmento de codigo
   MOV AX,@DATA              ;Mueve al registro de proposito general AX lo que esta en DATA
   MOV DS,AX                 ;Mueve al registro DS, los datos de AX
    
    imprimir presentacion    ;Invoca a la macro para imprimir un mensaje
    imprimir espacio         ;Invoca a la macro para imprimir un mensaje
    imprimir opcion1         ;Invoca a la macro para imprimir un mensaje
    imprimir opcion2         ;Invoca a la macro para imprimir un mensaje
    imprimir opcion3         ;Invoca a la macro para imprimir un mensaje
    imprimir opcion4         ;Invoca a la macro para imprimir un mensaje
    imprimir opcion5         ;Invoca a la macro para imprimir un mensaje
   
   leer: 
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion             ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
  
   ;Capturar opcion e ir a la opcion seleccionada
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   
   ;CREAR UN ARCHIVO EN DISCO
   CMP al,49                 ;Compara al con 49
   JE case1                  ;Salta a la etiqueta
   ;.EDITAR Y GUARDAR UN ARCHIVO EN DISCO
   CMP al,50                 ;Compara al con 50
   JE case2                  ;Salta a la etiqueta
   ;SALIR
   CMP al,51                 ;Compara al con 51
   JE case3                  ;Salta a la etiqueta
   CMP al,52                 ;Compara al con 53
   JE case4                  ;Salta a la etiqueta
   CMP al,53                 ;Compara al con 53
   JE FIN                    ;Salta a la etiqueta
   CMP al,83                 ;Compara al con 83
   JE FIN                    ;Salta a la etiqueta
   CMP al,115                ;Compara al con 115
   JE FIN                    ;Salta a la etiqueta
 case1: 
;SUMAR  
   imprimir msg0             ;Invoca a la macro para imprimir un mensaje
   call capturanumero        ;Llama al procedimiento para capturar un numero
   mov ax,n                  ;Coloca el numero en ax
   mov r1,ax                 ;Mueve a la etiqueta el contenido del numero
   mov n,0                   ;coloca en 0, el contenido de la etiqueta n
   imprimir msg1             ;Invoca a la macro para imprimir un mensaje
   call capturanumero        ;llama al procedmiento para capturar un numero
   mov ax,n                  ;Coloca el numero en ax
   mov r2,ax                 ;Mueve a la etiqueta el contenido del numero
   mov n,0                   ;coloca en 0, el contenido de la etiqueta n
   sumar r1,r2,resultado     ;Invoca a la macro que calcula el resultado de la suma con los numeros
   imprimirnumero resultado  ;Invoca a la macro para imprimir el resultado
   jmp leer                  ;salta a la etiqueta

 case2: 
;RESTAR
imprimir msg0                ;Invoca a la macro para imprimir un mensaje
   call capturanumero        ;Llama al procedimiento para capturar un numero
   mov ax,n                  ;Coloca el numero en ax
   mov r1,ax                 ;Mueve a la etiqueta el contenido del numero
   mov n,0                   ;coloca en 0, el contenido de la etiqueta n
   imprimir msg1             ;Invoca a la macro para imprimir un mensaje
   call capturanumero        ;llama al procedmiento para capturar un numero
   mov ax,n                  ;Coloca el numero en ax
   mov r2,ax                 ;Mueve a la etiqueta el contenido del numero
   mov n,0                   ;coloca en 0, el contenido de la etiqueta n
   restar r1,r2,resultado    ;Invoca a la macro que calcula el resultado de la suma con los numeros
   imprimirnumero resultado  ;Invoca a la macro para imprimir el resultado
   jmp leer                  ;salta a la etiqueta
case3:
imprimir msg0
   call capturanumero        ;llama al procedmiento para capturar un numero
   mov ax,n                  ;Coloca el numero en ax
   mov r1,ax                 ;Mueve a la etiqueta el contenido del numero
   mov n,0                   ;coloca en 0, el contenido de la etiqueta n
   imprimir msg1             ;Invoca a la macro para imprimir un mensaje
   call capturanumero        ;llama al procedmiento para capturar un numero
   mov ax,n                  ;Coloca el numero en ax
   mov r2,ax                  ;Mueve a la etiqueta el contenido del numero
   mov n,0                    ;coloca en 0, el contenido de la etiqueta n
   multiplicar r1,r2,resultado ;Invoca a la macro que calcula el resultado de la suma con los numeros
   imprimirnumero resultado  ;Invoca a la macro para imprimir el resultado
   jmp leer                   ;salta a la etiqueta
case4:
imprimir msg0
   call capturanumero       ;llama al procedmiento para capturar un numero
   mov ax,n                  ;Coloca el numero en ax
   mov r1,ax                 ;Mueve a la etiqueta el contenido del numero
   mov n,0                  ;coloca en 0, el contenido de la etiqueta n
   imprimir msg1            ;Invoca a la macro para imprimir un mensaje
   call capturanumero       ;llama al procedmiento para capturar un numero
   mov ax,n                 ;Coloca el numero en ax
   mov r2,ax                ;Mueve a la etiqueta el contenido del numero
   mov n,0                  ;coloca en 0, el contenido de la etiqueta n
   dividir b.r1,b.r2,resultado ;Invoca a la macro que calcula el resultado de la suma con los numeros
   imprimirnumero resultado  ;Invoca a la macro para imprimir el resultado
   jmp leer                  ;salta a la etiqueta
 
 
;PROCEDIMIENTOS
;------------------------------------------------------------------------------------------------- 
 capturanumero PROC
   cap:   
   ;leer  digito decena
   mov ah,01h               ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. d, al             ;mueve a d el contenido de al (el caracter capturado con ajuste)
   mov ax, d                ;mueve a AX el contenido de d (16 bits)
   mov bx,10                ;mueve a BX la constante 10
   mul bx                   ;multiplica BX con AX
   mov d, ax                ;mueve el resultado guardado en AX a d
   ADD n, ax                ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer digito  unidad
   mov ah,01h              ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                 ;ejecuta la interrupcion 21h
   sub al,30h              ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. u, al            ;mueve a u el contenido de al (el caracter capturado con ajuste)
   mov ax, u               ;mueve a AX el contenido de u (16 bits)
   mov bx,1                ;mueve a BX la constante 1
   mul bx                  ;multiplica BX con AX
   mov u, ax               ;mueve el resultado guardado en AX a u
   ADD n, ax               ;Suma a n, el valor de AX (el resultado de la multiplicacion)
capturanumero ENDP
RET
 

 fin:
END                          ;Termina el programa