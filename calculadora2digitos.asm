.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria
CADENA DB 'HOLA MUNDO $'     ;Se define una etiqueta llamada CADENA con el contenido "HOLA MUNDO"
u1 db 0
u2 db 0
r  dw 0 
n dw 0
n2 dw 0
d1 dw 0 
d2 dw 0
c1 dw 0
c2 dw 0 
msg1 db 10,13 , 'Suma: ','$'
msg2 db 10,13 , 'Resta: ','$'
msg3 db 10,13 , 'Multiplicacion: ','$'
msg4 db 10,13 , 'Division: ','$'
msg0 db 10,13 , 'Ingrese numero A: ','$'
msg00 db 10,13 , 'Ingrese numero B: ','$'     
MENSAJE DB 10,13, 'Bienvenido Que desea hacer?','$'     ;Define una etiqueta llamada MENSAJE
mensaje2 db 10,13, 'Teclee numero de alguna otra opcion','$'
numero DB 0                                             ;Define una etiqueta llamada numero con 0
opcion1 DB 10,13,'1) Sumar A y B','$'                   ;Define una etiqueta llamada opcion1
opcion2 DB 10,13,'2) Restar A y B','$'                  ;Define una etiqueta llamada opcion2
opcion3 DB 10,13,'3) Multiplicar A y B','$'             ;Define una etiqueta llamada opcion3
opcion4 DB 10,13,'4) Dividir A y B','$'
opcion5 DB 10,13,'5) Salir','$'

 espacio DB 10,13, ' ','$'                         ;Define una etiqueta llamada espacio

.CODE                        ;Define el segmento de codigo

    MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
    MOV DS,AX                ;Mueve al registro DS, los datos de AX
    MOV DX,OFFSET msg0       ;Mueve a dx el contenido de msg0
    MOV AH,9                 ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                  ;Se genera la interrupcion que nos muestra el MS-DOS

     ;leer tercero digito centena
   mov ah,01h               ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. c1, al            ;mueve a c1 el contenido de al (el caracter capturado con ajuste)
   mov ax, c1               ;mueve a AX el contenido de c1 (16 bits)
   mov bx,100               ;mueve a BX la constante 100
   mul bx                   ;multiplica BX con AX
   mov c1, ax               ;mueve el resultado guardado en AX a c1
    ADD n, ax               ;Suma a n, el valor de AX (el resultado de la multiplicacion)
    
    ;leer segundo digito decena
   mov ah,01h               ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. d1, al            ;mueve a d1 el contenido de al (el caracter capturado con ajuste)
   mov ax, d1               ;mueve a AX el contenido de d1 (16 bits)
   mov bx,10                ;mueve a BX la constante 10
   mul bx                   ;multiplica BX con AX
   mov d1, ax               ;mueve el resultado guardado en AX a d1
   ADD n, ax                ;Suma a n, el valor de AX (el resultado de la multiplicacion)
    
    
    ;leer primer digito unidades 
    mov ah,01h              ;Mueve a ah la funcion 01h para lectura del teclador
    int 21h                 ;ejecuta la interrupcion 21h
    sub al,30h              ;Coloca un ajuste de 30h al contenido de al(resta 30h o 48 en decimal)
    mov u1,al               ;mueve a u1, el contenido de al
    add b. n, al            ;Suma a n, el contenido de al
    
    
    MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
    MOV DS,AX                ;Mueve al registro DS, los datos de AX
    MOV DX,OFFSET msg00      ;mueve a dx el contenido de msg 
    MOV AH,9                 ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                  ;Se genera la interrupcion que nos muestra el MS-DOS
    
   ;leer el tercer digito centena 
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. c2, al            ;mueve a c el contenido de al (el caracter capturado con ajuste)
   mov ax, c2               ;mueve a AX el contenido de c (16 bits)
   mov bx,100               ;mueve a BX la constante 100
   mul bx                   ;multiplica BX con AX
   mov c2, ax               ;mueve el resultado guardado en AX a c2
   ADD c2, ax               ;Suma a c2, el valor de AX (el resultado de la multiplicacion)
   
 
      ;leer segundo digito decena
   mov ah,01h               ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                  ;ejecuta la interrupcion 21h
   sub al,30h               ;hace un ajuste de 30h al registro al (resta de 30h o 48 en decimal)
   mov b. d2, al            ;mueve a d2 el contenido de al (el caracter capturado con ajuste)
   mov ax, d2               ;mueve a AX el contenido de d2 (16 bits)
   mov bx,10                ;mueve a BX la constante 10
   mul bx                   ;multiplica BX con AX
   mov d2, ax               ;mueve el resultado guardado en AX a d2
   ADD n2, ax               ;Suma a n2, el valor de AX (el resultado de la multiplicacion)
    
    
    ;leer primer digito unidades 
    mov ah,01h              ;mueve a ah, la funcion 01h para capturar un caracter por teclado
    int 21h                 ;ejecuta la interrupcion 21h
    sub al,30h              ;hace un ajuste a al de 30h 0 48 en decimal para calcular el numero real
    mov u2,al               ;mueve a u2 el contenido de al
    add b. n2, al           ;suma a n2, el contenido de al
    
     ;Switch
     
     
    LEA DX,MENSAJE                        ;Lee el contenido de la etiqueta candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar MENSAJE   
    LEA DX,opcion1                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar opcion1    
    LEA DX,opcion2                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar opcion2    
    LEA DX,opcion3                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar opcion3    
    LEA DX,opcion4                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar opcion5       
    LEA DX,opcion5                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Ejecuta la  interrupcion 21h para motrar la cadena
    LEA DX,espacio                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Ejecuta la interrupcion 21h 

LEER:                                     ;Etiqueta que define el segmento de codigo LEER     
    MOV AH, 01h                           ;Ejecuta en AH la funcion 01H que sirve para leer los caracteres ingresador
    INT 21h                               ;Inicia la interrupcion 21h 
    sub al,30h                            ;Hace un ajuste para que el numero que esta en Al este en decimal
    MOV numero,AL                         ;Mueve a el vector CADENA en la posicion SI el contenido de AL    
Switch:                                   ;Etiqueta
    CMP numero,1                          ;Compara el numero con 1
    JE  case1                             ;Si es igual, va a la etiqueta case1
    CMP numero,2                          ;Compara el numero con 2
    JE  case2                             ;Si es igual, va a la etiqueta case2
    CMP numero,3                          ;Compara el numero con 3
    JE  case3                             ;Si es igual, va a la etiqueta case3     
    CMP numero,4                          ;Compara el numero con 3
    JE  case4                             ;Si es igual, va a la etiqueta case3      
    CMP numero,5                          ;Compara el numero con 3
    JE  salir 
Case1:     
    
    ;Suma
    mov ax,n                              ;Mueve a ax el contenido de n
    add ax,n2                             ;Suma a ax el contenido de n2
                                          
    mov r, ax                             ;Mueve a r el contenido de ax
    
    mov ah,09h                            ;mueve a ah la funcion 09h 
    lea dx, msg1                          ;mueve a dx el contenido de msg1
    int 21h                               ;ejecuta la interrupcion 21h para desplegar el contenido

    mov ax,r                              ;mueve a ax, el conteindo de r
    AAM                                   ;Hace el ajuste BCD para separar el contenido del registro y poder mostrarlo
    mov bx,ax                             ;mueve a bx el contenido de ax
    
    Call impR
                                          ;Ejecuta el procedimiento impR 
    JMP LEER
Case2:    
    
    ;Resta
    
     mov al,b. n                          ;Mueve a al el contenido de n
     sub al,b. n2                         ;Resta al contenido de al, el continido de n2 
     mov b. r,al                          ;Mueve a r, el contenido de al
     
     mov ah,09h                           ;Mueve a ah, la funcion 09h 
     lea dx,msg2                          ;Mueve a dx, el contenido de msg2
     int 21h                              ;ejecuta la interrupcion 21h
     
     mov ax,r                             ;mueve a ax, el contenido de r
     AAM                                  ;Hace el ajuste BCD 
     mov bx,ax                            ;Mueve a bx, el contenido de ax
    
     call impR                            ;Llama al procedimiento impR
    
    ;;mostar tercer digito
;     xor ax,ax
;       
;     mov bl,10
;     mov al,bh
;     div bl
;     mov ah,02h
;     mov dl,al 
;     add dl,30h
;     int 21h 
;                   
;    ;mostrar el segundo digito
;           
;
;     xor ax,ax     
;     mov bl,10
;     mov al,bh
;     div bl
;     
;     mov dl,ah
;     mov ah,02h
;     add dl,30h
;     int 21h       
;   
;    ;mostrar tercer digito
;    mov ax,r
;    AAM
;    mov bx,ax 
;     xor ax,ax 
;    mov ah,02h
;    mov dl,bl 
;    add dl,30h  
;    int 21h
    JMP LEER                              ;Salta a la etiqueta leer
Case3:
      
     ;Multiplicacion
     
     mov ax,n                             ;Mueve a ax, el contenido de n
     mov bx,n2                            ;Mueve a bx, el contenido de n2
     mul bx                               ;Multiplica a ax, con bx
     mov b. r,ax                          ;Mueve a r, el contenido de ax (resultado de la multiplicacion)
     
     mov ah,09h                           ;Mueve a ah, la funcion 09h
     lea dx,msg3                          ;Mueve a dx, el contenido de msg3
     int 21h                              ;Ejecuta la interrupcion 21h
          
     mov ax,r                             ;mueve a ax, el contenido de r
     AAM                                  ;Hace el ajuste BCD
     mov bx,ax                            ;Mueve a bx, el contenido de ax
    
     CALL impR                            ;Llama al procedimiento impR
    
   ; 
;    ;mostar tercer digito
;     xor ax,ax
;       
;     mov bl,10
;     mov al,bh
;     div bl
;     mov ah,02h
;     mov dl,al 
;     add dl,30h
;     int 21h 
;                   
;    ;mostrar el segundo digito
;           
;
;     xor ax,ax     
;     mov bl,10
;     mov al,bh
;     div bl
;     
;     mov dl,ah
;     mov ah,02h
;     add dl,30h
;     int 21h       
;   
;    ;mostrar tercer digito
;    mov ax,r
;    AAM
;    mov bx,ax 
;     xor ax,ax 
;    mov ah,02h
;    mov dl,bl 
;    add dl,30h  
;    int 21h
   JMP LEER                                ;Salata a la etiqueta leer
Case4:
     
     ;Division
     xor ax,ax                             ;Hace una "limplieza" de ax (pone ax en 0)
     mov bl,b. n2                          ;Mueve a bl, el contenido de n2
     mov al,b. n                           ;Mueve a al, el contenido de n
     div bl                                ;Hace la la division de al/bl
     mov b. r,al                           ;Mueve el contenido de al, a r
     
                                           ;Mueve a ah la funcion 09h
     mov ah,09h                            ;Mueve a dx, el contenido de msg4
     lea dx,msg4                           ;Ejecuta la interrupcion 21h
     int 21h
     
     mov ax,r                              ;Mueve a ax, el contenido de r
     AAM                                   ;Hace el ajuste BCD
     mov bx,ax                             ;Mueve a bx, el contenido de ax
    
     CALL impR                             ;Llama al procedimiento impR
    
    ;;mostar tercer digito
;     xor ax,ax
;       
;     mov bl,10
;     mov al,bh
;     div bl
;     mov ah,02h
;     mov dl,al 
;     add dl,30h
;     int 21h 
;                   
;    ;mostrar el segundo digito
;           
;
;     xor ax,ax     
;     mov bl,10
;     mov al,bh
;     div bl
;     
;     mov dl,ah
;     mov ah,02h
;     add dl,30h
;     int 21h       
;   
;    ;mostrar tercer digito
;    mov ax,r
;    AAM
;    mov bx,ax 
;     xor ax,ax 
;    mov ah,02h
;    mov dl,bl 
;    add dl,30h  
;    int 21h
                                            ;Salta a la etiqueta leer
    JMP LEER

PROC impR                                   ;Define el inicio del procedimiento impR
 
 ;mostar tercer digito
     xor ax,ax                              ;Hace una "Limpieza" de ax
       
     mov bl,10                              ;Mueve a bl, 10
     mov al,bh                              ;Mueve a al, el contenido de bh
     div bl                                 ;Divide al/bl
     mov ah,02h                             ;Mueve a ah, la funcion 02h
     mov dl,al                              ;Mueve a dl, el contenido de al (resultado de la division)
     add dl,30h                             ;Hace un ajuste de 30h al contenido de dl
     int 21h                                ;Ejecuta la interruocion 21h
                   
    ;mostrar el segundo digito
           

     xor ax,ax                              ;Hace una "Limpieza" de ax
     mov bl,10                              ;Mueve a bl, 10
     mov al,bh                              ;Mueve a al, el contenido de bh
     div bl                                 ;Divide al/bl
     
     mov dl,ah                              ;Mueve a dl, el contenido de ah (residuo de la division)
     mov ah,02h                             ;Mueve a ah, la funcion 02h
     add dl,30h                             ;Hace un ajuste de 30h a dl
     int 21h                                ;Ejecuta la interrupcion 21h
   
    ;mostrar tercer digito
    mov ax,r                                ;Mueve a ax, el contenido de r
    AAM                                     ;Hace el ajuste BCD 
    mov bx,ax                               ;Mueve a bx, el contenidod de ax
    xor ax,ax                               ;Hace una "Limpieza" de ax
    mov ah,02h                              ;Mueve a ah, la funcion 02h
    mov dl,bl                               ;Mueve a dl, el contenido de bl
    add dl,30h                              ;Hace un ajuste de 30h a dl
    int 21h                                 ;Ejecuta la interrupcion 21h
    
    
    LEA DX,mensaje2                         ;Mueve a dx, el contenido de mensaje2
    MOV AH,09                               ;mueve a ah, la funcion 09h
    INT 21H                                 ;Ejecuta la interrupcion 21h
    
    LEA DX,espacio                          ;Mueve a dx, el contenido de espacion
    MOV AH,09                               ;Mueve a ah, la funcion 09h
    INT 21H                                 ;Ejecuta la interrucion 21h
    

                                     
EndP                                        ;Define el fin del procedimiento
RET                                          ;Retorna a donde fue llamado el procedimiento

salir:

END 