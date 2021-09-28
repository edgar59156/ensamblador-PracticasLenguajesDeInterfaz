.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria

 ;Definicion de las etiquetas
presentacion DB 10,13 ,'PROGRAMA QUE COMPARA DOS CADENAS Y DESPLIEGA EL NUMERO DE COINCIDENCIAS','$' 
opcion1 db 10,13 , 'Digite N (2 cifras max): ','$'
espacio db 10,13 , ' ','$'


cadenaAux db 50 dup('$')
cadena1 db 50 dup('$')
cadena2 db 50 dup('$') 

leido db 100 dup (24h) 
handle dw ? 
u dw 0                              ;Definicion de una variable en 0
d dw 0                              ;Definicion de una variable en 0
                             ;Definicion de una variable en 0
n dw 0
a dw 0
b dw 1
c dw 0
aux dw 0
cont dw 0 
aux2 dw 10000

.CODE                        ;Define el segmento de codigo

   MOV AX,@DATA              ;Mueve al registro de proposito general AX lo que esta en DATA
   MOV DS,AX                 ;Mueve al registro DS, los datos de AX
           
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,presentacion       ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion  
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion1            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
   
   call capturaCadena
   call calculaFibonacci
   
   
   
capturaCadena PROC
   cap:   
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
capturaCadena ENDP
RET

calculaFibonacci PROC
    calcular:
    mov aux2,10000
    mov ax,a
    mov bx,b
    add ax,bx 
    mov  c,ax
    mov  a,bx
    mov  b,ax
    call imprimirSerie

    inc cont
    mov cx,n
    cmp cont,cx
    JB calcular
    JE fin
calculaFibonacci ENDP

imprimirSerie PROC 
   ;Obtiene el digito decenas
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
     
;Obtiene el digito centenas    
   iterar:
   xor ax,ax                                                    
   mov ax, c
   xor dx,dx
   mov bx,aux2
   div bx
   mov aux,0 
   mov aux, ax
   mov dx,ax
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,30h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 

;Multiplica por el digtio de centenas a un auxiliar y luego lo resta a el resultado binario  
   
   xor ax,ax
   mov ax,aux2
   mov bx,aux
   mul bx
   mov aux, ax
   mov ax,c
   sub ax, aux
   mov c, ax  
   
   mov ax,aux2 
   mov bx,10
   div bx
   mov aux2,ax
   cmp aux2,0
   JE salir
   cmp aux2,1
   JAE iterar
   
    salir:
imprimirSerie ENDP   
  RET
 fin:
END                           ;Termina el programa