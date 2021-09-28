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
handle dw ? 
cont dw 0  

.CODE                        ;Define el segmento de codigo

   MOV AX,@DATA              ;Mueve al registro de proposito general AX lo que esta en DATA
   MOV DS,AX                 ;Mueve al registro DS, los datos de AX
           
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,presentacion       ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion 
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion1            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion2            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion3            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion4            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcion5            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
   
   
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
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcionnombre       ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov si,2                  ;coloca en si, 2 para comenzar a contar despues de c:\
   ;Solicitar nombre 
   call capturanombre        ;llama al procedimiento
   ;Crear Archivo 
   call crearArchivo
   jmp leer                  ;salta a la etiqueta

 case2: 
;EDITAR Y GUARDAR UN ARCHIVO EN DISCO 
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcionnombre       ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov si,2                  ;coloca en si, 2 para comenzar a contar despues de c:\
   xor ax,ax                 ;limpia AX          
   ;Solicitar nombre
   call capturanombre        ;llama al procedimiento
 
mostarlineas:
  mov ah,09h                 ;Mueve a ah la funcion 09h para el desplegado de una cadena
  lea dx,linea               ;mueve a dx el contenido de opcion para mostrarlo
  int 21h                    ;Ejecuta la interrupcuion 21h
  mov ah,09h                 ;Mueve a ah la funcion 09h para el desplegado de una cadena
  lea dx,lineatexto          ;mueve a dx el contenido de opcion para mostrarlo
  int 21h                    ;Ejecuta la interrupcuion 21h 
  mov si,cont                ;coloca en si, el valor de cont  
;Captura de contenido
capturar: 
  mov ah,01h                 ;Coloca en ah, la funcion 01h para captura por teclado
  int 21h                    ;ejecuta la interrupcion 
  mov capturado[si],al       ;mueve a la etiqueta en la posicion de si, lo que esta en al
  inc si                     ;incrementa si
  cmp al,0dh                 ;compara si se presiono un enter
  jne capturar               ;si no se presino, regresa a capturar
  mov ah,09h                 ;Mueve a ah la funcion 09h para el desplegado de una cadena
  lea dx,guardar             ;mueve a dx el contenido de opcion para mostrarlo
  int 21h                    ;Ejecuta la interrupcuion 21h 
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
  call abrirArchivo
;Escribir en el archivo
 call escribirArchivo 
;Mostrar el aviso
  mov ah,09h                 ;Mueve a ah la funcion 09h para el desplegado de una cadena
  lea dx,aviso               ;mueve a dx el contenido de opcion para mostrarlo
  int 21h                    ;Ejecuta la interrupcuion 21h
;Cerrar el archivo
  call cerrarArchivo
  jmp leer                   ;salta a leer
 case3:
;LISTAR EL CONTENIDO DEL ARCHIVO EN PANTALLA
 
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena   
   lea dx,opcionnombre       ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h
   mov si,2                  ;coloca en si, 2 para comenzar a contar despues de c:\ 
   xor ax,ax                 ;limpia ax          
;capturar nombre
   call capturanombre        ;llama al procedimiento
listar:   
;abrir el archvo
    call abrirArchivo
;leer el archivo
    call leerArchivo
;cerramos archivo
    call cerrarArchivo
;imprimir el contenido de leido
    call imprimirContenido 
    jmp leer                 ;regresa a leer
 

 case4:
;ELIMINAR UN ARCHIVO DE DISCO
   mov si,2                  ;coloca en si, 2 para comenzar a contar despues de c:\ 
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,opcionnombre       ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;ejecuta la interrupcion
   call capturanombre        ;llama a el procedimiento

; Eliminar archivo 
    call eliminarArchivo 
    jmp leer                  ;regresa a leer
;---------------------------------------------------------------------------------------------------  
;PROCEDIMIENTOS  
capturanombre  PROC           ;nombre del procedimiento
    cap: 
    MOV AH, 01h               ;Ejecuta en AH la funcion 01H que sirve para leer los caracteres ingresador
    INT 21h                   ;Inicia la interrupcion para mostrar el MS-DOS
    INC SI                    ;Incrementamos nuestro contador
    CMP AL,0DH                ;Compara el caracter introducido, si se introdujo un enter
    JE reg                    ;Salta a la etiqueta LEER
    MOV nombre[SI],AL         ;Mueve a el vector CADENA en la posicion SI el contenido de AL
    JMP cap                   ;salta a la etiqueta
    reg:  
capturanombre  ENDP           ;fin del procedimiento
RET                           ;instruccion de retorno
crearArchivo PROC
   crear:                    ;etiqueta
   mov ah,3ch                ;instruccion para crear el archivo.
   mov cx,0                  ;atributos del archivo
   mov dx,offset nombre      ;crea el archivo con el nombre 
   int 21h                   ;ejecuta la interrupcion
   mov handle,ax             ;mueve el manejador, a handle1
   mov si,0                  ;coloca en si,0
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,aviso2             ;mueve a dx el contenido de opcion para mostrarlo
   int 21h                   ;Ejecuta la interrupcuion 21h    
crearArchivo ENDP 
RET

abrirArchivo PROC
    mov ah, 3dh              ;se intenta abrir el archivo
    mov al, 00               ;modo de acceso para abrir arhivo, modo lectura
    mov dx, offset nombre    ;offset lugar de memoria donde esta la variable
    int 21h                  ;llamada a la interrupcion       
    jc fin                   ;si hay un error, va a fin     
abrirArchivo ENDP
RET

leerArchivo PROC    
    mov handle,ax            ;mueve a handle, el contenido de ax
    mov ah, 3fh              ;funcion para leer un fichero usando handler
    mov bx, handle           ;coloca en bx, el contenido del handle
    mov cx, 100              ;mueve a cx la cantidad de caracteres que lee del archivo
    lea dx, leido            ; pasa al dx lo que hay en el archivo
    int 21h                  ;ejecuta la interrupcion
leerArchivo ENDP
RET

cerrarArchivo PROC
    mov bx, handle          ;coloca en bx, el contenido de handle
    mov ah, 3eh              ;instruccion para cerrar el archivo
    int 21h                  ;ejecuta la interrupcion
cerrarArchivo ENDP
RET  

imprimirContenido PROC
    mov ah,09h               ;mueve a ah, la funcion 09 para desplegar una cadena
    lea dx, espacio          ;mueve a dx el contenido de espacio para mostrarlo
    int 21h                  ;ejecuta la interrupcion
    mov dx, offset leido     ;mueve a dx, el contenido que se leyo
    mov ah,09h               ;mueve a ah, la funcion 09 para desplegar una cadena
    int 21h                  ;ejecuta la interrupcion
    xor ax,ax                ;limpia ax.
imprimirContenido ENDP
RET

eliminarArchivo PROC
    mov ah,41h               ;instruccion para eliminar el archivo
    mov dx,offset nombre     ;mueve a dx, el contenido de nombre
    int 21h                  ;ejecuta la interrupcion
    jc fin
eliminarArchivo ENDP
RET
  
escribirArchivo PROC  
  mov ah,40h                 ;instruccion para escribir
  mov bx,handle             ;mueve el mueve a bx, el contenido de handle
  mov cx,si                  ;coloca en cx, el tamano de la cadena que se guardo
  mov dx,offset capturado    ;mueve a dx, la cadena que escribimos
  int 21h                    ;ejecuta la interrupcion
  jc fin                     ;va a fin si ocurrio un error 
escribirArchivo ENDP
RET
 
 fin:
END                           ;Termina el programa