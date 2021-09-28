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
NOaviso db 10,13, 'AVISO : LINEA NO ALMACENADA.','$'
linea db 10,13, 'ESTA ES UNA LINEA DE PRUEBA QUE SE ALMACENARA EN DISCO','$'
lineatexto db 10,13, 'LINEA DE TEXTO : ','$'
guardar db 10,13, 'DESEA GUARDAR ESTA LINEA EN EL ARCHIVO (S / N)?','$'
opcionnombre db 10,13 , 'INGRESE NOMBRE PARA EL ARCHIVO : ','$' 
espacio db 10,13,'','$' 
nombre db 'c:\               ', 0
vec db 50 dup('$')
leido db 100 dup (24h)
handle db 0
handler dw ? 
handle1 dw ?   

.CODE                        ;Define el segmento de codigo

 MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
 MOV DS,AX                ;Mueve al registro DS, los datos de AX
  
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,presentacion       ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion 
    mov ah,09h             ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio            ;mueve a dx el contenido de la etiqueta para mostrarla
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
   mov si,2
   capturanombre: 
    xor ax,ax                           ;Coloca en AX el valor 0000
    MOV AH, 01h                           ;Ejecuta en AH la funcion 01H que sirve para leer los caracteres ingresador
    INT 21h                               ;Inicia la interrupcion para mostrar el MS-DOS
    
    INC SI                                ;Incrementamos nuestro contador
    CMP AL,0DH                            ;Compara el caracter introducido, si se introdujo un enter
    JE crear                      ;Salta a la etiqueta LEER
    MOV nombre[SI],AL                     ;Mueve a el vector CADENA en la posicion SI el contenido de AL
    JMP capturanombre
    crear:
    mov ax,@data  ;Cargamos el segmento de datos para sacar el nombre del archivo.
    mov ds,ax
    mov ah,3ch ;instruccion para crear el archivo.
    mov cx,0   ;atributis del archivo
    mov dx,offset nombre ;crea el archivo con el nombre archivo2.txt indicado indicado en la parte .data
    int 21h
    mov handle1,ax
    mov si,0
    jmp leer
    
;EDITAR Y GUARDAR UN ARCHIVO EN DISCO
 case2: 
 mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
 lea dx,linea             ;mueve a dx el contenido de opcion para mostrarlo
 int 21h                   ;Ejecuta la interrupcuion 21h
 
 mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
 lea dx,lineatexto             ;mueve a dx el contenido de opcion para mostrarlo
 int 21h                   ;Ejecuta la interrupcuion 21h
 
capturar: 
mov ah,01h
int 21h
mov vec[si],al
inc si
cmp al,0dh
jne capturar

mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
 lea dx,guardar             ;mueve a dx el contenido de opcion para mostrarlo
 int 21h                   ;Ejecuta la interrupcuion 21h
  
 mov ah,01h
 int 21h 

 cmp al,83
 JE escribir
 
 mov si,0
 cmp al,78
 JE leer
 
escribir:
; Escritura de archivo  

    ;Abrir archivo
mov ah,3dh
mov al,01h ;lectura y escritura
mov dx,offset nombre
int 21h
jc fin     ;sale si la bandera de acarreo esta en error


mov bx,ax  ;mueve el handle que esta en ax a bx para escribir
mov cx,si  ;coloca en cx, el tamano de la cadena que se guardo
mov dx,offset vec   ;mueve a dx, la cadena que escribimos
mov ah,40h          ;peticion para escribir
int 21h
mov handle,bl       ;
mov bx,ax
mov ax,bx
cmp cx,ax
jne fin
mov ah,3eh
mov bl,handle
int 21h
jmp leer 
 
mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
lea dx,aviso             ;mueve a dx el contenido de opcion para mostrarlo
int 21h                   ;Ejecuta la interrupcuion 21h

 case3:
 ;mov ah,09h             ;Mueve a ah la funcion 09h para el desplegado de una cadena
; lea dx,espacio            ;mueve a dx el contenido de la etiqueta para mostrarla
; int 21h 
;    
; mov ah,3dh
; 
; mov dx,offset nombre
; mov al,0h
; int 21h
;
;mov bx,ax
;mov ah,3fh
;
;mov cx,50
;mov dx,offset vec
;int 21h
;mov ah,09h
;int 21h
;; Cierre de archivo
;mov ah,3eh
;int 21h

 xor ax,ax ;pone en cero al reg ax.
 mov ax,data ;mueve la posicion de segmento data al reg ax.
mov ds,ax ;mueve la posicion de ax al reg DS.

mov al, 0h ;modo de acceso para abrir arhivo, modo lectura/escritura
mov dx, offset nombre ;offset lugar de memoria donde esta la variable
mov ah, 3dh ;se intenta abrir el archivo
int 21h ;llamada a la interrupcion DOS
mov handler,ax
mov bx, handler
mov cx, 100h ;cantidad de caracteres que lee del archivo
mov dx, offset leido ; pasa al dx lo que hay en el archivo
mov ah, 3fh ;funcion para leer un fichero usando handler
int 21h
;cerramos archivo
mov bx, handler
mov ah, 3eh
int 21h
;imprimir el contenido de leido
mov ah,09h
lea dx, espacio ;Lee el menu de salir
int 21h ;interrupcion 
mov dx, offset leido ; ;cargamos lo leido a los datos
mov ah, 9
int 21h
xor ax,ax ;limpia ax. 









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