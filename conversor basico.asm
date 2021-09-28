}+.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inicio del segmento de datos para las variables de memoria
;Definicion de etiquetas que apuntan a espacios de memoria
presentacion DB 10,13 ,'CONVERSOR BASICO ','$'
decbin DB 10,13 ,'1. DECIMAL -> BINARIO','$' 
bindec DB 10,13 ,'2. BINARIO -> DECIMAL','$' 
dechex DB 10,13 ,'3. DECIMAL -> HEXADECIMAL','$' 
hexdec DB 10,13 ,'4. HEXADECIMAL -> DECIMAL','$' 
salir DB 10,13 ,'5. SALIR','$'
opcion DB 10,13 ,'ELIJA SU OPCION: ','$'
operando1 DB 10,13 ,'INGRESE EL NUMERO : ','$' 
operando2 DB 10,13 ,'INGRESE OPERANDO 2 : ','$'
resultado DB 10,13 ,'RESULTADO : ','$' 
espacio DB 10,13 ,'  ','$'
r dw 0
r2 dw 0
n dw 0  
;Etiquetas para captura de decimal
u dw 0                              
d dw 0                              
c dw 0                             
um dw 0                             
dm dw 0 
rdec dw 0 
;Etiquetas para binario  
rbin dw 0
aux dw 0 
;Etiquetas para hexadecimal
residuo dw 0
cociente dw 0

;Etiquetas hexadecimal - decimal
rhex dw 0 
peso dw 0
                      

cont db 0

.CODE                        ;Define el segmento de codigo

 MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
 MOV DS,AX                ;Mueve al registro DS, los datos de AX
  
   mov ah,09h             ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,presentacion    ;mueve a dx el contenido de presentacion para mostrarlo
   int 21h                ;Ejecuta la interrupcuion 21h
   mov ah,09h             ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio         ;mueve a dx el contenido de espacio para mostrarlo
   int 21h                  ;Ejecuta la interrupcuion 21h
   mov ah,09h               ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,decbin              ;mueve a dx el contenido de multi para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,bindec               ;mueve a dx el contenido de divi para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,dechex               ;mueve a dx el contenido de conj para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,hexdec              ;mueve a dx el contenido de disyu para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,salir             ;mueve a dx el contenido de diyuex para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov ah,09h               ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio            ;mueve a dx el contenido de espacio para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   
   leer: 
   xor ax,ax
   mov cont,0                     ;Etiqueta
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion             ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
  
   ;Capturar opcion e ir a la opcion seleccionada
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   
   ;DECIMAL -> BINARIO
   CMP al,49                 ;Compara al con 42
   JE case1                  ;Salta a la etiqueta
   ;BINARIO -> DECIMAL   
   CMP al,50                 ;Compara al con 47
   JE case2                  ;Salta a la etiqueta
   ;DECIMAL -> HEXADECIMAL
   CMP al,51                 ;Compara al con 38
   JE case3                  ;Salta a la etiqueta
   ;HEXADECIMAL -> DECIMAL    
   CMP al,52                ;Compara al con 124
   JE case4                  ;Salta a la etiqueta
   ;SALIR
   CMP al,5                 ;Compara al con 88
   JE FIN                  ;Salta a la etiqueta

   
;DECIMAL -> BINARIO
case1:
   mov cont,0                ;Pone el contador en 0
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1          ;mueve a dx el contenido de operando1 para mostrarlo
   int 21h                   ;Ejecuta la interupcion 21h                   ;Ejecuta la interrupcuion 21h
   call capturardecimal      ;Llama al procedimiento
 
   Dividirm:    
       ;Ciclo para dividir el numero resultado de la opercion anterior para convertir a binario
  xor ax,ax                  ;Coloca en 0 el registro ax
  mov ax,rdec                ;Mueve a al, el contenido de n
  mov bx,2                   ;Mueve a bl, 2
  div bx                     ;Hace la division de al y bl
  mov rdec,ax                ;Mueve a n, el contenido de al
  push dx                    ;Mete a la pila, el contenido de dx
  INC cont                   ;Incrementa el contador
  CMP cont,15                 ;Compara el contador con 7
  JBE dividirm               ;Si es menor o igual, salta a la etiqueta

   ;Mostrar la cadena "Resultado: " y reinicio del contador usado para ciclos
   xor ax,ax                  ;Coloca en 0 el registro ax
   mov ah,09h               ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio            ;mueve a dx el contenido de espacio para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado          ;mueve a dx el contenido de msg para mostrarlo
   int 21h                   ;Ejecuta la interrupcion 21h
   mov cont,0                ;Coloca el contador en 0

mostrarm:
      
   pop ax                    ;Mete al a pila, el contenido de ax
   mov dx,ax                 ;Mueve a dl, el contenido de ah (residuo de la division)
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,30h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h
   INC cont                  ;Incrementa el contador
   CMP cont,15                ;Compara el contador con 7
   JBE mostrarm              ;Si es menor o igual, salta a la etiqueta
  mov ah,09h               ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio            ;mueve a dx el contenido de espacio para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
  JMP leer                  ;Salta a la etiqueta 
      
;BINARIO -> DECIMAL
case2:   
   mov cont,0                ;Coloca el contador en 0
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1          ;mueve a dx el contenido de msg para mostrarlo
   int 21h                   ;Ejecuta la interrupcion 21h
   call capturarbinario              ;Llama al procedimiento
  ;Mostrar la cadena "Resultado: " y reinicio del contador usado para ciclos
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado          ;mueve a dx el contenido de msg para mostrarlo
   int 21h                   ;Ejecuta la interrupcion 21h
   mov cont,0                ;Coloca el contador en 0
   call impDecimal
   JMP leer                  ;Salta a la etiqueta


;DECIMAL -> HEXADECIMAL
case3:   
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1          ;mueve a dx el contenido de msg para mostrarlo
   int 21h                   ;Ejecuta la interrupcion 21h
   call capturardecimal              ;Llama al procedimiento   
   mov ax, rdec 
   mov cociente,ax
dividir:   
   mov ax,cociente
   mov bx,16 
   div bx
   mov cociente,ax
   mov b. residuo,dl 
   push dx
   xor dx,dx
   
   CMP ax,16
   JAE  dividir 
   push ax
 
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado          ;mueve a dx el contenido de msg para mostrarlo
   int 21h                   ;Ejecuta la interrupcion 21h   
   mov cont,0

 mostrar: 

   pop ax
   
   CMP ax,15
   JE impri15
   
   cmp AX,14
   JE imp14
   
   cmp ax,13
   JE imp13
   
   cmp ax,12
   JE imp12
   
   cmp ax,11
   JE imp11
   
   cmp ax,10
   JE imp10
   
   cmp ax,9
   JE imp9 
   
   cmp ax,8
   JE imp8
   
   cmp ax,7
   JE imp7
   
   cmp ax,6
   JE imp6 
   
   cmp ax,5
   JE imp5
   
   cmp ax,4
   JE imp4
   
   cmp ax,3
   JE imp3 
   
   cmp ax,2
   JE imp2
   
   cmp ax,1
   JE imp1
   
   cmp ax,0
   JE imp0
   
impri15:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,46h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h   
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar

imp14:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,45h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h   
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
 
imp13:                
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,44h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   
   JMP mostrar
   
imp12:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,43h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
   
imp11:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,42h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
   
imp10:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,41h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
    
imp9:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,39h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
        
imp8:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,38h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
imp7:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,37h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
imp6:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,36h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
imp5:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,35h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
imp4:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,34h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
imp3:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,33h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
imp2:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,32h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
imp1:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,31h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
imp0:
   mov dl,0
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,30h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 
   inc cont
   cmp cont,4
   je  fdec
   JMP mostrar
                                       
   fdec: 
   JMP leer
;HEXADECIMAL -> DECIMAL
case4:   
   mov rhex,0                ;Coloca el contador en 0
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,operando1          ;mueve a dx el contenido de msg para mostrarlo
   int 21h                   ;Ejecuta la interrupcion 21h
    
   mov peso,4096
   call capturarHexadecimal1   ;Llama al procedimiento
   
   
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,resultado          ;mueve a dx el contenido de msg para mostrarlo
   int 21h                   ;Ejecuta la interrupcion 21h
   mov cont,0                ;Coloca el contador en 0
   mov ax, rhex
   mov rbin,ax
   call impDecimal

   JMP leer                  ;Salta a la etiqueta
   
 
 ;Procedimientos
PROC capturarBinario
   ;leer bit 16
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov ah,al
   mov bx,32768                ;Coloca en bl, 128
   mul bx                    ;Multiplica al y bl
   mov rbin, ax 
   ;leer bit 15
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov ah,al
   mov bx,16384                ;Coloca en bl, 128
   mul bx                    ;Multiplica al y bl
   add rbin, ax 
   ;leer bit 14
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov ah,al
   mov bx,8192                ;Coloca en bl, 128
   mul bx                   ;Multiplica al y bl
   add  rbin, ax 
   ;leer bit 13
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov ah,al
   mov bx,4096                ;Coloca en bl, 128
   mul bx                    ;Multiplica al y bl
   add  rbin, ax 
   ;leer bit 12
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov ah,al
   mov bx,2048                ;Coloca en bl, 128
   mul bx                    ;Multiplica al y bl
   add rbin, ax 
   ;leer bit 11
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov ah,al
   mov bx,1024                ;Coloca en bl, 128
   mul bx                    ;Multiplica al y bl
   add rbin, ax 
   ;leer bit 10
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov ah,al
   mov bx,512                ;Coloca en bl, 128
   mul bx                    ;Multiplica al y bl
   add  rbin, ax 
   
   ;leer bit 9
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov ah,al
   mov bx,256                ;Coloca en bl, 128
   mul bx                    ;Multiplica al y bl
   add rbin, ax 
   
   ;leer bit 8
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,128                ;Coloca en bl, 128
   mul bl                    ;Multiplica al y bl
   add b. rbin, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 7               
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,64                 ;Coloca en bl, 64
   mul bl                    ;Multiplica al y bl
   add b. rbin, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 6
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,32                 ;Coloca en bl, 32
   mul bl                    ;Multiplica al y bl
   add b. rbin, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 5
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,16                 ;Coloca en bl, 16
   mul bl                    ;Multiplica al y bl
   add b. rbin, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)     
   ;leer bit 4
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,8                  ;Coloca en bl, 8
   mul bl                    ;Multiplica al y bl
   add b. rbin, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 3
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,4                  ;Coloca en bl, 4
   mul bl                    ;Multiplica al y bl
   add b. rbin, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 2
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov bl,2                  ;Coloca en bl, 2
   mul bl                    ;Multiplica al y bl
   add b. rbin, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   ;leer bit 1
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   add b. rbin, al              ;mueve a dm el contenido de al (el caracter capturado con ajuste)
  
ENDP

RET


PROC capturarDecimal 
    mov rdec,0
    ;leer primer digito decena de millar                    
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal) 
   mov b. dm, al             ;mueve a dm el contenido de al (el caracter capturado con ajuste)
   mov ax, dm                ;mueve a AX el contenido de dm (16 bits)
   mov bx,10000              ;mueve a BX la constante 10 000
   mul bx                    ;multiplica BX con AX
   mov dm, ax                ;mueve el resultado guardado en AX a dm                      
   ADD rdec, ax                 ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer segundo digito unidad de millar
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   sub al,30h                ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. um, al             ;mueve a um el contenido de al (el caracter capturado con ajuste)
   mov ax, um                ;mueve a AX el contenido de um (16 bits)
   mov bx,1000               ;mueve a BX la constante 1000
   mul bx                    ;multiplica BX con AX
   mov um, ax                ;mueve el resultado guardado en AX a um
    ADD rdec, ax                ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer tercero digito centena
   mov ah,01h               ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. c, al             ;mueve a c el contenido de al (el caracter capturado con ajuste)
   mov ax, c                ;mueve a AX el contenido de c (16 bits)
   mov bx,100               ;mueve a BX la constante 100
   mul bx                   ;multiplica BX con AX
   mov c, ax                ;mueve el resultado guardado en AX a c
    ADD rdec, ax               ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer cuarto digito decena
   mov ah,01h               ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. d, al             ;mueve a d el contenido de al (el caracter capturado con ajuste)
   mov ax, d                ;mueve a AX el contenido de d (16 bits)
   mov bx,10                ;mueve a BX la constante 10
   mul bx                   ;multiplica BX con AX
   mov d, ax                ;mueve el resultado guardado en AX a d
    ADD rdec, ax               ;Suma a n, el valor de AX (el resultado de la multiplicacion)
   
   ;leer digito digito unidad
   mov ah,01h              ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                 ;ejecuta la interrupcion 21h
   sub al,30h              ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. u, al            ;mueve a u el contenido de al (el caracter capturado con ajuste)
   mov ax, u               ;mueve a AX el contenido de u (16 bits)
   mov bx,1                ;mueve a BX la constante 1
   mul bx                  ;multiplica BX con AX
   mov u, ax               ;mueve el resultado guardado en AX a u
   ADD rdec, ax               ;Suma a n, el valor de AX (el resultado de la multiplicacion)

   mov u,0
   mov d,0
   mov c,0
   mov um,0
   mov dm,0


ENDP
RET 

PROC capturarHexadecimaL1
  
caphex:  
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h

   CMP al,70
   JE addF
   CMP al,69
   JE addE 
   CMP al,68
   JE addD  
   CMP al,67
   JE addC
   CMP al,66
   JE addB
   CMP al,65
   JE addA
   CMP al,57
   JE add9
   CMP al,56
   JE add8
   CMP al,55
   JE add7
   CMP al,54
   JE add6
   CMP al,53
   JE add5
   CMP al,52
   JE add4
   CMP al,51
   JE add3
   CMP al,50
   JE add2
   CMP al,49
   JE add1
   CMP al,48
   JE add0
   
 addF: 
  Mov ax,15
  Mov bx,peso 
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
 
  
  
 addE:
   Mov ax,14
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro

 addD:
   Mov ax,13
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro

 addC:
   Mov ax,12
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
 
 addB:
   Mov ax,11
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
 addA:
   Mov ax,10
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
  
 add9:
   Mov ax,9
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
 add8:
   Mov ax,8
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
 add7:
   Mov ax,7
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
 add6:
   Mov ax,6
  Mov bx,peso 
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
  
 add5:
   Mov ax,5
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
 add4:
   Mov ax,4
  Mov bx,peso 
  Mul bx
  add rhex,ax
  inc cont

  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
 add3:
   Mov ax,3
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro

 add2:
   Mov ax,2
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
  cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
  
 add1:
   Mov ax,1
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
 cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
  
 add0:
   Mov ax,0
  Mov bx,peso
  Mul bx
  add rhex,ax
  inc cont
  
 cmp cont,1
  je incre1
  cmp cont,2
  je incre2
  cmp cont,3
  je incre3
  cmp cont,4
  je fpro
  

  incre1:
  mov peso,256
  jmp caphex
  incre2:
  mov peso,16 
  jmp caphex
  incre3:
  mov peso,1
  jmp caphex
fpro:
ENDP
RET


PROC impDecimal

;Obtiene el digito decenas de millares 
   xor ax,ax                                                    
   mov ax, rbin
   xor dx,dx
   mov bx,10000
   div bx 
   mov b. aux, al
   mov dl,al
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,30h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 

;Multiplica por el digtio de decenas de millares a un auxiliar y luego lo resta a el resultado binario
   mov ax,10000
   mov bx,aux
   mul bx
   mov aux, ax
   mov ax,rbin
   sub ax, aux
   mov rbin, ax   

;Obtiene el digito decenas de millares 
   xor ax,ax                                                    
   mov ax, rbin
   xor dx,dx
   mov bx,1000
   div bx
   mov aux,0 
   mov b. aux, al
   mov dl,al
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,30h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 

;Multiplica por el digtio de unidades de millar a un auxiliar y luego lo resta a el resultado binario  
   mov ax,1000
   mov bx,aux
   mul bx
   mov aux, ax
   mov ax,rbin
   sub ax, aux
   mov rbin, ax   

;Obtiene el digito centenas    
   xor ax,ax                                                    
   mov ax, rbin
   xor dx,dx
   mov bx,100
   div bx
   mov aux,0 
   mov b. aux, al
   mov dl,al
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,30h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 

;Multiplica por el digtio de centenas a un auxiliar y luego lo resta a el resultado binario  
   mov ax,100
   mov bx,aux
   mul bx
   mov aux, ax
   mov ax,rbin
   sub ax, aux
   mov rbin, ax   

;Obtiene el digito decenas   
   xor ax,ax                                                    
   mov ax, rbin
   xor dx,dx
   mov bx,10
   div bx  
   mov aux,0
   mov b. aux, al
   mov dl,al
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,30h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 

;Multiplica por el digtio de decenas a un auxiliar y luego lo resta a el resultado binario   
   mov ax,10
   mov bx,aux
   mul bx
   mov aux, ax
   mov ax,rbin
   sub ax, aux
   mov rbin, ax   

;Obtiene el digito unidades       
   xor ax,ax                                                    
   mov ax, rbin
   xor dx,dx
   mov bx,1
   div bx  
   mov aux,0
   mov b. aux, al
   mov dl,al
   mov ah,02h                ;Mueve a ah, la funcion 02h
   add dl,30h                ;Hace un ajuste de 30h a dl
   int 21h                   ;Ejecuta la interrupcion 21h 

;Multiplica por el digtio de unidades a un auxiliar y luego lo resta a el resultado binario  
   mov ax,1
   mov bx,aux
   mul bx
   mov aux, ax
   mov ax,rbin
   sub ax, aux
   mov rbin, ax   



ENDP
RET

      
 fin:

END                          ;Termina el programa