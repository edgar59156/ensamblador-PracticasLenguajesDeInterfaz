.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria

 ;Definicion de las etiquetas
presentacion DB 10,13 ,'EDITOR DE TEXTO','$' 
opcion1 db 10,13 , '1.CREAR UN ARCHIVO EN DISCO','$'  
opcion2 db 10,13 , '2.EDITAR Y GUARDAR UN ARCHIVO EN DISCO','$'
opcion3 db 10,13 , '3.LISTAR EL CONTENIDO DEL ARCHIVO EN PANTALLA','$'
opcion4 db 10,13 , '4.ELIMINAR EL ARCHIVO EN DISCO','$'
opcion5 db 10,13 , '5.SALIR','$'
opcion db 10,13 , 'ELIJA SU OPCION : ','$' 
aviso db 10,13, 'AVISO : LINEA ALMACENADA.','$'  
aviso2 db 10,13, 'AVISO : ARCHIVO CREADO','$'
NOaviso db 10,13, 'AVISO : LINEA NO ALMACENADA.','$'
linea db 10,13, 'ESTA ES UNA LINEA QUE SE ALMACENARA EN DISCO','$'
lineatexto db 10,13, 'LINEA DE TEXTO : ','$'
guardar db 10,13, 'DESEA GUARDAR ESTA LINEA EN EL ARCHIVO (S / N) ? ','$'
opcionnombre db 10,13 , 'INGRESE NOMBRE PARA EL ARCHIVO : ','$' 
espacio db 10,13,'','$' 
nombre db 'c:\               ', 0
capturado db 50 dup('$')
leido db 100 dup (24h)
handler dw ? 
handle1 dw ? 
handle2 dw ? 
cont dw 0  

.CODE                        ;Define el segmento de codigo
  
  imprimir MACRO msg   
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,msg                ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion     
   ENDM
  
   abrir MACRO
    
    ENDM
   MOV AX,@DATA              ;Mueve al registro de proposito general AX lo que esta en DATA
   MOV DS,AX                 ;Mueve al registro DS, los datos de AX       

   imprimir presentacion
   imprimir espacio
   imprimir opcion1
   imprimir opcion2
   imprimir opcion3
   imprimir opcion4
   imprimir opcion5
          
   leer: 
    
    imprimir opcion
    
   ;Capturar opcion e ir a la opcion seleccionada
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h                   ;ejecuta la interrupcion 21h
   
   ;CREAR UN ARCHIVO EN DISCO
   CMP al,49                 ;Compara al con 49
   JE case1                  ;Salta a la etiqueta
   ;.EDITAR Y GUARDAR UN ARCHIVO EN DISCO
   CMP al,50                 ;Compara al con 50
   JE case2                  ;Salta a la etiqueta
   ;LISTAR EL CONTENIDO DEL ARCHIVO EN PANTALLA
   CMP al,51                 ;Compara al con 51
   JE case3                  ;Salta a la etiqueta
   ;ELIMINAR EL ARCHIVO EN DISCO
   CMP al,52                 ;Compara al con 52
   JE case4                  ;Salta a la etiqueta
   ;SALIR
   CMP al,53                 ;Compara al con 53
   JE FIN                    ;Salta a la etiqueta
   CMP al,83                 ;Compara al con 83
   JE FIN                    ;Salta a la etiqueta
   CMP al,115                ;Compara al con 115
   JE FIN                    ;Salta a la etiqueta
 case1: 
;CREAR UN ARCHIVO EN DISCO 
 ;Solicitar nombre  
   imprimir opcionnombre
   mov si,2                  ;coloca en si, 2 para comenzar a contar despues de c:\
   call capturanombre        ;llama al procedimiento
 crear:                      ;etiqueta
   mov ah,3ch                ;instruccion para crear el archivo.
   mov cx,0                  ;atributos del archivo
   mov dx,offset nombre      ;crea el archivo con el nombre 
   int 21h                   ;ejecuta la interrupcion
   mov handle1,ax            ;mueve el manejador, a handle1
   mov si,0                  ;coloca en si,0   
   imprimir aviso2
   jmp leer                  ;salta a la etiqueta
    

 case2: 
;EDITAR Y GUARDAR UN ARCHIVO EN DISCO        
   imprimir opcionnombre
   mov si,2                  ;coloca en si, 2 para comenzar a contar despues de c:\
   xor ax,ax                 ;limpia AX          
   call capturanombre        ;llama al procedimiento
 
mostarlineas: 
  imprimir linea
  imprimir lineatexto
  mov si,cont                ;coloca en si, el valor de cont  
capturar: 
  mov ah,01h                 ;Coloca en ah, la funcion 01h para captura por teclado
  int 21h                    ;ejecuta la interrupcion 
  mov capturado[si],al       ;mueve a la etiqueta en la posicion de si, lo que esta en al
  inc si                     ;incrementa si
  cmp al,0dh                 ;compara si se presiono un enter
  jne capturar               ;si no se presino, regresa a capturar 
 imprimir guardar
  
  mov ah,01h                 ;Coloca en ah, la funcion 01h para captura por teclado
  int 21h                    ;ejecuta la interrupcion 
  add cont,si                ;suma el valor de si, a cont
  cmp al,83                  ;compara si se presiono una S
  JE escribir                ;Si se presiono va a escribir
  cmp al,78                  ;compara si se presiono una N
  JE leer                    ;Si si, va a leer
 
escribir:
; Escritura de archivo  
 ;Abrir archivo
  mov ah,3dh                 ;Instruccion para abrir un archivo
  mov al,01h                 ;lectura y escritura
  mov dx,offset nombre       ;mueve a dx, el contenido de nombre
  int 21h                    ;Ejecuta la interrupcion
  jc fin                     ;sale si la bandera de acarreo esta en error
;Escribir en el archivo
  mov ah,40h                 ;instruccion para escribir
  mov bx,handle1             ;mueve el mueve a bx, el contenido de handle
  mov cx,si                  ;coloca en cx, el tamano de la cadena que se guardo
  mov dx,offset capturado    ;mueve a dx, la cadena que escribimos
  int 21h                    ;ejecuta la interrupcion
  jc fin                     ;va a fin si ocurrio un error
;Mostrar el aviso  
  imprimir aviso
;Cerrar el archivo
  mov ah,3eh                 ;instruccion para cerrar el archivo
  mov bx,handle1             ;mueve a bx, el contenido del manejador
  int 21h                    ;ejecuta la interrupcion
  jmp leer                   ;salta a leer
 case3:
;LISTAR EL CONTENIDO DEL ARCHIVO EN PANTALLA
 ;capturar nombre
   
   imprimir opcionnombre
   
   mov si,2                  ;coloca en si, 2 para comenzar a contar despues de c:\ 
   xor ax,ax                 ;limpia ax          
   call capturanombre        ;llama al procedimiento

listar:   
;abrir el archvo
    mov ah, 3dh              ;se intenta abrir el archivo
    mov al, 00               ;modo de acceso para abrir arhivo, modo lectura
    mov dx, offset nombre    ;offset lugar de memoria donde esta la variable
    int 21h                  ;llamada a la interrupcion       
    jc fin                   ;si hay un error, va a fin
;leer el archivo
    mov handle2,ax           ;mueve a handle, el contenido de ax
    mov ah, 3fh              ;funcion para leer un fichero usando handler
    mov bx, handle2          ;coloca en bx, el contenido del handle
    mov cx, 100              ;mueve a cx la cantidad de caracteres que lee del archivo
    lea dx, leido            ; pasa al dx lo que hay en el archivo
    int 21h                  ;ejecuta la interrupcion
;cerramos archivo
    mov bx, handle2          ;coloca en bx, el contenido de handle
    mov ah, 3eh              ;instruccion para cerrar el archivo
    int 21h                  ;ejecuta la interrupcion
;imprimir el contenido de leido
    mov ah,09h               ;mueve a ah, la funcion 09 para desplegar una cadena
    lea dx, espacio          ;mueve a dx el contenido de espacio para mostrarlo
    int 21h                  ;ejecuta la interrupcion
    
    imprimir leido
    xor ax,ax                ;limpia ax. 
    jmp leer                 ;regresa a leer
 
 case4:
;ELIMINAR UN ARCHIVO DE DISCO
   mov si,2                  ;coloca en si, 2 para comenzar a contar despues de c:\ 
   imprimir opcionnombre
   call capturanombre        ;llama a el procedimiento
; Cierre de archivo
    mov ah,3eh               ;instrucion para cerrar el archivo
    int 21h                  ;ejecuta la interrupcion
; Eliminar archivo
    mov ah,41h               ;instruccion para eliminar el archivo
    mov dx,offset nombre     ;mueve a dx, el contenido de nombre
    int 21h                  ;ejecuta la interrupcion
    jmp leer                 ;regresa a leer
  
;PROCEDIMIENTOS  
  PROC capturanombre          ;nombre del procedimiento
    cap: 
    MOV AH, 01h               ;Ejecuta en AH la funcion 01H que sirve para leer los caracteres ingresador
    INT 21h                   ;Inicia la interrupcion para mostrar el MS-DOS
    INC SI                    ;Incrementamos nuestro contador
    CMP AL,0DH                ;Compara el caracter introducido, si se introdujo un enter
    JE reg                    ;Salta a la etiqueta LEER
    MOV nombre[SI],AL         ;Mueve a el vector CADENA en la posicion SI el contenido de AL
    JMP cap                   ;salta a la etiqueta
    reg:  
  ENDP                        ;fin del procedimiento
  RET                         ;instruccion de retorno
 

 
 
 fin:
END                           ;Termina el programa