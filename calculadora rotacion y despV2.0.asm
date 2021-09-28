.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inicio del segmento de datos para las variables de memoria
presentacion DB 10,13 ,'CALCULADORA BASICA ','$'
multi DB 10,13 ,'(*) MULTIPLICACION EN POTENCIAS DE 2 (2^n)','$' 
divi DB 10,13 ,'(/) DIVISION EN POTENCIAS DE 2 (2^n)','$' 
conj DB 10,13 ,'(&) CONJUNCION ','$' 
disyu DB 10,13 ,'(|) DISYUNCION ','$' 
diyuex DB 10,13 ,'(X) DISYUNCION EXCLUSIVA ','$'
salir DB 10,13 ,'(S) SALIR ','$'
opcion DB 10,13 ,'ELIJA SU OPCION: ','$'
operando1 DB 10,13 ,'INGRESE OPERANDO 1 : ','$' 
operando2 DB 10,13 ,'INGRESE OPERANDO 2 : ','$'
resultado DB 10,13 ,'RESULTADO : ','$' 
espacio DB 10,13 ,'  ','$'
r dw 0
r2 dw 0
n dw 0  
cont db 0

.CODE                        ;Define el segmento de codigo

 MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
 MOV DS,AX                ;Mueve al registro DS, los datos de AX
  
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,presentacion                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
    mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,multi                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,divi                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,conj                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,disyu                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,diyuex                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,salir                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
    mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio                ;mueve a dx el contenido de msg para mostrarlo
   int 21h 
   leer:
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion                ;mueve a dx el contenido de msg para mostrarlo
   int 21h    
   ;Capturar opcion e ir a la opcion seleccionada
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   
   ;Multiplicacion *
   CMP al,42
   JE case1
   ;Division /
   CMP al,47
   JE case2  
   ;Conjuncion & (Mayus + 7)
   CMP al,38
   JE case3 
   ;Disyuncion (|) tecla a lado del 1     
   CMP al,124
   JE case4 
   ;Disyuncion exclusiva X mayuscula  
   CMP al,88
   JE case5
   ;Salir S mayuscula   
   CMP al,83
   JE fin

   
   
   
   
;Multiplicacion   
case1:
   mov cont,0
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1                ;mueve a dx el contenido de msg para mostrarlo
   int 21h 
   call leerOP1
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando2                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   call leerOP2 
   
   mov ax,r
   mov cl,b. r2
   sal ax,cl
   mov n, ax
   
   
   Dividirm:    
       ;Ciclo para dividir el numero resultado de la opercion anterior para convertir a binario
  xor ax,ax  
  mov al,b. n
  mov bl,2
  div bl
  xor dx,dx
  mov dl,ah
  mov b. n,al
  push dx    
  INC cont
  CMP cont,7
  JBE dividirm 

   ;Mostrar la cadena "Resultado: " y reinicio del contador usado para ciclos
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado          ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov cont,0

mostrarm:    
   pop ax
   mov dl,al                              ;Mueve a dl, el contenido de ah (residuo de la division)
   mov ah,02h                             ;Mueve a ah, la funcion 02h
   add dl,30h                             ;Hace un ajuste de 30h a dl
   int 21h
   INC cont
   CMP cont,7
   JBE mostrarm    
   JMP leer   

   
      
;Division
case2:   
   mov cont,0
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1                ;mueve a dx el contenido de msg para mostrarlo
   int 21h 
   call leerOP1
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando2                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   call leerOP2 
   
   mov ax,r
   mov cl,b. r2
   sar ax,cl
   mov n, ax
   
   Dividird:    
       ;Ciclo para dividir el numero resultado de la opercion anterior para convertir a binario
  xor ax,ax  
  mov al,b. n
  mov bl,2
  div bl
  xor dx,dx
  mov dl,ah
  mov b. n,al
  push dx    
  INC cont
  CMP cont,7
  JBE dividird 

   ;Mostrar la cadena "Resultado: " y reinicio del contador usado para ciclos
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado          ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov cont,0

mostrard:    
   pop ax
   mov dl,al                              ;Mueve a dl, el contenido de ah (residuo de la division)
   mov ah,02h                             ;Mueve a ah, la funcion 02h
   add dl,30h                             ;Hace un ajuste de 30h a dl
   int 21h
   INC cont
   CMP cont,7
   JBE mostrard    
   JMP leer   

   
   
   
;Conjuncion
case3:   
   mov cont,0
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1                ;mueve a dx el contenido de msg para mostrarlo
   int 21h 
   call leerOP1
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando2                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   call leerOP2 
   mov ax,r
   mov bx,r2
   and ax,bx
   mov n,ax
   
Dividir:    
       ;Ciclo para dividir el numero resultado de la opercion anterior para convertir a binario
  xor ax,ax  
  mov al,b. n
  mov bl,2
  div bl
  xor dx,dx
  mov dl,ah
  mov b. n,al
  push dx    
  INC cont
  CMP cont,7
  JBE dividir 

   ;Mostrar la cadena "Resultado: " y reinicio del contador usado para ciclos
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado          ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov cont,0

mostrar1:    
   pop ax
   mov dl,al                              ;Mueve a dl, el contenido de ah (residuo de la division)
   mov ah,02h                             ;Mueve a ah, la funcion 02h
   add dl,30h                             ;Hace un ajuste de 30h a dl
   int 21h
   INC cont
   CMP cont,7
   JBE mostrar1    
   JMP leer   


;Disyuncion
case4:   
   mov cont,0
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1                ;mueve a dx el contenido de msg para mostrarlo
   int 21h 
   call leerOP1
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando2                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   call leerOP2 
   mov ax,r
   mov bx,r2
   or ax,bx
   mov n,ax


dividir2:   
   xor ax,ax  
   mov al,b. n
   mov bl,2
   div bl
   xor dx,dx
   mov dl,ah
   mov b. n,al
   push dx    
   INC cont
   CMP cont,7
   JBE dividir2
     
   ;Mostrar la cadena "Resultado: " y reinicio del contador usado para ciclos
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado          ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov cont,0

mostrar2:    
   pop ax
   mov dl,al                              ;Mueve a dl, el contenido de ah (residuo de la division)
   mov ah,02h                             ;Mueve a ah, la funcion 02h
   add dl,30h                             ;Hace un ajuste de 30h a dl
   int 21h
   INC cont
   CMP cont,7
   JBE mostrar2  
   JMP leer 
   
     
;Disyuncion exclusiva
case5:
   mov cont,0   
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1          ;mueve a dx el contenido de msg para mostrarlo
   int 21h 
   call leerOP1
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando2          ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   call leerOP2 
   mov ax,r
   mov bx,r2
   xor ax,bx
   mov n,ax

dividir3:      
   xor ax,ax  
   mov al,b. n
   mov bl,2
   div bl
   xor dx,dx
   mov dl,ah
   mov b. n,al
   push dx    
   INC cont
   CMP cont,7
   JBE dividir3  
   
   ;Mostrar la cadena "Resultado: " y reinicio del contador usado para ciclos   
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado                ;mueve a dx el contenido de msg para mostrarlo
   int 21h
   mov cont,0

mostrar3:    
   pop ax
   mov dl,al                              ;Mueve a dl, el contenido de ah (residuo de la division)
   mov ah,02h                             ;Mueve a ah, la funcion 02h
   add dl,30h                             ;Hace un ajuste de 30h a dl
   int 21h
   INC cont
   CMP cont,7
   JBE mostrar3  
   JMP leer           
 
 
 
 ;Procedimientos
PROC leerOP1
     
   ;leer bit 8
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,128
   mul bl
   mov b. r, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 7
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,64
   mul bl
   add b. r, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 6
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,32
   mul bl
   add b. r, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 5
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,16
   mul bl
   add b. r, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)  
     
   ;leer bit 4
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,8
   mul bl
   add b. r, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
  
   ;leer bit 3
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,4
   mul bl
   add b. r, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 2
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,2
   mul bl
   add b. r, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 1
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   add b. r, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)

RET  
ENDP

PROC leerOP2
     
   ;leer bit 8
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,128
   mul bl
   mov b. r2, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
  
   ;leer bit 7
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,64
   mul bl
   add b. r2, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 6
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,32
   mul bl
   add b. r2, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 5
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,16
   mul bl
   add b. r2, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)  
     
     
   ;leer bit 4
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,8
   mul bl
   add b. r2, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
  
   ;leer bit 3
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,4
   mul bl
   add b. r2, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 2
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,2
   mul bl
   add b. r2, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 1
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   add b. r2, al                 ;mueve a dm el contenido de al (el caracter capturado con ajuste)

RET  
ENDP 

 
 fin:

END                          ;Termina el programa