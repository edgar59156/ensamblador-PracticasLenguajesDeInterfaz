.MODEL SMALL                        ;Define el modelo de memoria
.STACK                              ;Definie una Pila de 1k
.DATA                               ;Define el inico del segmento de datos para las variables de memoria
msg DB 10,13 ,'Ingrese numero: ','$';Se define una variable llamada msg
u dw 0                              ;Definicion de una variable en 0
d dw 0                              ;Definicion de una variable en 0
c dw 0                              ;Definicion de una variable en 0
um dw 0                             ;Definicion de una variable en 0
dm dw 0                             ;Definicion de una variable en 0
n dw 0                              ;Definicion de una variable en 0

.CODE                        ;Define el segmento de codigo
  
   mov ax,@data              ;Mueve a AX, el contenido del segmento data
   mov ds,ax                 ;Mueve a ds el contenido de ax
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,msg                ;mueve a dx el contenido de msg para mostrarlo
   int 21h                   ;ejecuta la interrupcion 21h

   ;leer primer digito decena de millar                    
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov b. dm, al             ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   mov ax, dm                ;mueve a AX el contenido de dm (16 bits)
   mov bx,10000              ;mueve a BX la constante 10 000
   mul bx                    ;multiplica BX con AX
   mov dm, ax                ;mueve el resultado guardado en AX a dm                      
   ADD n, ax                 ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer segundo digito unidad de millar
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. um, al             ;mueve a um el contenido de al (el caracter capturado con ajuste)
   mov ax, um                ;mueve a AX el contenido de um (16 bits)
   mov bx,1000               ;mueve a BX la constante 1000
   mul bx                    ;multiplica BX con AX
   mov um, ax                ;mueve el resultado guardado en AX a um
    ADD n, ax                ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer tercero digito centena
   mov ah,01h               ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. c, al             ;mueve a c el contenido de al (el caracter capturado con ajuste)
   mov ax, c                ;mueve a AX el contenido de c (16 bits)
   mov bx,100               ;mueve a BX la constante 100
   mul bx                   ;multiplica BX con AX
   mov c, ax                ;mueve el resultado guardado en AX a c
    ADD n, ax               ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer cuarto digito decena
   mov ah,01h               ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. d, al             ;mueve a d el contenido de al (el caracter capturado con ajuste)
   mov ax, d                ;mueve a AX el contenido de d (16 bits)
   mov bx,10                ;mueve a BX la constante 10
   mul bx                   ;multiplica BX con AX
   mov d, ax                ;mueve el resultado guardado en AX a d
    ADD n, ax               ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer digito digito unidad
   mov ah,01h              ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                 ;ejecuta la interrupcion 21h
   sub al,30h              ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. u, al            ;mueve a u el contenido de al (el caracter capturado con ajuste)
   mov ax, u               ;mueve a AX el contenido de u (16 bits)
   mov bx,1                ;mueve a BX la constante 1
   mul bx                  ;multiplica BX con AX
   mov u, ax               ;mueve el resultado guardado en AX a u
   ADD n, ax               ;Suma a n, el valor de AX (el resultado de la multiplicacion)
    
   

END                  ;Termina el programa