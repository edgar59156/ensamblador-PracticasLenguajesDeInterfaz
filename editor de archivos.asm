.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria
presentacion DB 10,13 ,'EDITOR DE TEXTO','$' 
opcion1 db 10,13 , '1.CREAR UN ARCHIVO EN DISCO','$'  
opcion2 db 10,13 , '2.EDITAR Y GUARDAR UN ARCHIVO EN DISCO','$'
opcion3 db 10,13 , '3.LISTAR EL CONTENIDO DEL ARCHIVO EN PANTALLA','$'
opcion4 db 10,13 , '4.ELIMINAR EL ARCHIVO EN DISCO','$'
opcion5 db 10,13 , '5.SALIR','$'
opcion db 10,13 , 'ELIJA SU OPCION : ','$' 
aviso db 10,13, 'AVISO : LINEA ALMACENADA.','$'
NOaviso db 10,13, 'AVISO : LINEA ALMACENADA.','$'
linea db 10,13, 'ESTA ES UNA LINEA DE PRUEBA QUE SE ALMACENARA EN DISCO','$'
lineatexto db 10,13, 'DESEA GUARDAR ESTA LINEA EN EL ARCHIVO (S / N)?','$'
guardar db 10,13, 'DESEA GUARDAR ESTA LINEA EN EL ARCHIVO (S / N)?','$'
opcionnombre db 10,13 , 'INGRESE NOMBRE PARA EL ARCHIVO : ','$'  
nombre db 'elpepe.txt', 0
vec db 50 dup('$')
leido db 100 dup (24h)
handle db 0    

.CODE                        ;Define el segmento de codigo

 MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
 MOV DS,AX                ;Mueve al registro DS, los datos de AX
  
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,presentacion       ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
      mov ah,09h             ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion1            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
      mov ah,09h             ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion2       ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
      mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion3       ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
      mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion4       ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
      mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion5       ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
   
   
   leer: 
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion             ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
  
   ;Capturar opcion e ir a la opcion seleccionada
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   
   ;CREAR UN ARCHIVO EN DISCO
   CMP al,49                 ;Compara al con 42
   JE case1                  ;Salta a la etiqueta
   ;.EDITAR Y GUARDAR UN ARCHIVO EN DISCO
   CMP al,50                 ;Compara al con 47
   JE case2                  ;Salta a la etiqueta
   ;LISTAR EL CONTENIDO DEL ARCHIVO EN PANTALLA
   CMP al,51                 ;Compara al con 38
   JE case3                  ;Salta a la etiqueta
   ;ELIMINAR EL ARCHIVO EN DISCO
   CMP al,52                ;Compara al con 124
   JE case4                  ;Salta a la etiqueta
   ;SALIR
   CMP al,53                 ;Compara al con 88
   JE FIN                  ;Salta a la etiqueta
 
 case1: 
 ;Solicitar nombre
    
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcionnombre             ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   ;capturanombre: 
;    xor ax,ax                           ;Coloca en AX el valor 0000
;    MOV AH, 01h                           ;Ejecuta en AH la funcion 01H que sirve para leer los caracteres ingresador
;    INT 21h                               ;Inicia la interrupcion para mostrar el MS-DOS
;    MOV nombre[SI],AL                     ;Mueve a el vector CADENA en la posicion SI el contenido de AL
;    INC SI                                ;Incrementamos nuestro contador
;    CMP AL,0DH                            ;Compara el caracter introducido, si se introdujo un enter
;    JA capturanombre                      ;Salta a la etiqueta LEER
    crear:
    mov ax,@data  ;Cargamos el segmento de datos para sacar el nombre del archivo.
    mov ds,ax
    mov ah,3ch ;instrucción para crear el archivo.
    mov cx,0
    mov dx,offset nombre ;crea el archivo con el nombre archivo2.txt indicado indicado en la parte .data
    int 21h
    jmp leer
 
;EDITAR Y GUARDAR UN ARCHIVO EN DISCO
 case2: 
mov ah,01h
int 21h
mov vec[si],al
inc si
cmp al,0dh
ja case2
jb case2
mov ah,3dh
mov al,1h
mov dx,offset nombre
int 21h
jc fin
; Escritura de archivo
mov bx,ax
mov cx,si
mov dx,offset vec
mov ah,40h
int 21h
mov handle,bl
mov bx,ax
mov ax,bx
cmp cx,ax
jne fin
mov ah,3eh
mov bl,handle
int 21h
jmp leer 


 case3:   
mov ah,3dh
mov al,0h
mov dx,offset nombre
int 21h

mov bx,ax

; Leer archivo
mov ah,3fh
; mov bx,ax
; mov bx,ax

mov cx,50
mov dx,offset vec
; mov dl,vec[si]
int 21h
mov ah,09h
int 21h

; Cierre de archivo
mov ah,3eh
int 21h
jmp leer
 
 
 case4:
; Cierre de archivo
mov ah,3eh
int 21h
; Eliminar archivo
mov ah,41h
mov dx,offset nombre
int 21h
jmp leer 


 
 fin:

END                          ;Termina el programa