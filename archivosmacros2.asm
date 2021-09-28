 imprimir MACRO  msg
          mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
          lea dx,msg       ;mueve a dx el contenido de la etiqueta para mostrarla
          int 21h                   ;Ejecuta la interrupcion 
          ENDM 

.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria

 ;Definicion de las etiquetas
presentacion DB 10,13 ,'EDITOR DE TEXTO','$' 
opcion1 db 10,13 , '1.CREAR O LEER UN ARCHIVO DE TEXTO EN DISCO','$'  
opcion2 db 10,13 , '2.BUSCAR UNA PALABRA','$'
opcion3 db 10,13 , '3.SALIR','$' 
opcion4 db 10,13 , '1.DESEA CREAR UN NUEVO ARCHIVO?','$'
opcion5 db 10,13 , '2.DESEA LEER DE DISCO UN TEXTO ALMACENADO?','$'
opcion db 10,13 , 'ELIJA SU OPCION : ','$' 
aviso db 10,13, 'AVISO : EL TEXTO FUE ALMACENADO EXITOSAMENTE EN DISCO Y AHORA TAMBIEN ESTA DISPONIBLE EN MEMORIA. .','$'  
aviso2 db 10,13, 'AVISO : EL TEXTO FUE LEIDO EXITOSAMENTE DE DISCO Y AHORA RESIDE EN MEMORIA.','$'
NOaviso db 10,13, 'AVISO : LINEA NO ALMACENADA.','$'
linea db 10,13, 'ESTA ES UNA LINEA QUE SE ALMACENARA EN DISCO','$'
lineatexto db 10,13, 'INGRESE TEXTO POR ALMACENAR : ','$'
palabrabuscar db 10,13, 'PALABRA A BUSCAR : ','$' 
numerocoincidencias db 10,13, 'COINCIDENCIAS : ','$'
opcionnombre db 10,13 , 'INGRESE NOMBRE PARA EL ARCHIVO : ','$' 
espacio db 10,13,'','$' 
;nombre db 'c:\               ', 0
nombre db 50 dup(' ')
capturado db 700 dup('$')
palabra db 10 dup('$')
leido db 700 dup (24h) 
handle dw ? 
cont dw 0  
coincidencias dw 0
aux dw 0 
aux2 dw 10000
nopalabras dw 0

.CODE                        ;Define el segmento de codigo
  
 
  
   MOV AX,@DATA              ;Mueve al registro de proposito general AX lo que esta en DATA
   MOV DS,AX                 ;Mueve al registro DS, los datos de AX
      
    imprimir presentacion
    imprimir espacio
    imprimir opcion1
    imprimir opcion2
    imprimir opcion3
   
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
   JE FIN
   CMP al,53                 ;Compara al con 53
   JE FIN                    ;Salta a la etiqueta
   CMP al,83                 ;Compara al con 83
   JE FIN                    ;Salta a la etiqueta
   CMP al,115                ;Compara al con 115
   JE FIN                    ;Salta a la etiqueta
 case1: 
;CREAR O LEER UN ARCHIVO DE TEXTO EN DISCO
   imprimir espacio
   imprimir opcion1
   imprimir espacio
   imprimir opcion4
   imprimir opcion5
   imprimir espacio
   imprimir opcion
   mov ah,01h                ;mueve a ah el contenido de la funcion 01h para esperar una entrada del teclado
   int 21h
   
   CMP al,49                 ;Compara al con 49
   JE crear_archivo          ;Salta a la etiqueta
   CMP al,50                 ;Compara al con 50
   JE leer_archivo                  ;Salta a la etiqueta

crear_archivo:
imprimir opcionnombre

call capturanombre
call crearArchivo 

imprimir lineatexto
 capturacontenido capturado
call abrirArchivo
call escribirArchivo
call cerrarArchivo
imprimir aviso
jmp leer

leer_archivo:
imprimir opcionnombre
call capturanombre  
call abrirArchivo 
call leerArchivo
call cerrarArchivo
imprimir aviso2 
   
jmp leer                  ;salta a la etiqueta

 case2: 
;BUSCAR UNA PALABRA 
  imprimir opcion2
  imprimir espacio
  imprimir palabrabuscar
  capturaContenido   palabra
  imprimir espacio
  
  mov si,0 
  mov di,0 
 
   
   
compara:
  xor CX,CX
  INC di  ;leido
  INC si  ;palabra
  
   denuevo:
  MOV ch, leido[di-1]  
  MOV cl, palabra[si-1]
  
  
  CMP palabra[si],24h
  je ocurrencia
  
  CMP leido[di],20h
  JE  contarpalabras
  
  k:
  CMP leido[di],24h
  je finalizar
  
  CMP cl,ch
 
  JE  compara
  JNE incrementar

     
    
  OCURRENCIA:
            MOV si, 1              ;palabra
            
            INC coincidencias                  ;INCREMENTA DI
        JMP denuevo                 ;SALTA A COMPARA 
 
contarpalabras:
          inc nopalabras
          jmp k
 
 
 incrementar:
 inc di                            ;leido
 
  
  
  CMP palabra[si],24h
  JE  ocurrencia
  CMP leido[di],24h
  JE  finalizar
 jmp  denuevo
finalizar:
    
   imprimir numerocoincidencias
   call imprimircoincidencias. 
   jmp fin
   
capturanombre PROC           ;nombre del procedimiento
    MOV nombre[SI],'c'
    inc si
    MOV nombre[SI],':'
    inc si
    MOV nombre[SI],'\'
    cap: 
    MOV AH, 01h               ;Ejecuta en AH la funcion 01H que sirve para leer los caracteres ingresador
    INT 21h                   ;Inicia la interrupcion para mostrar el MS-DOS
    INC SI                    ;Incrementamos nuestro contador
    CMP AL,0DH                ;Compara el caracter introducido, si se introdujo un enter
    JE reg                    ;Salta a la etiqueta LEER
    MOV nombre[SI],AL         ;Mueve a el vector CADENA en la posicion SI el contenido de AL
    JMP cap                   ;salta a la etiqueta
    reg: 
    MOV nombre[SI],0
  ENDP                        ;fin del procedimiento
  RET                         ;instruccion de retorno
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
cerrarArchivo PROC
    mov bx, handle          ;coloca en bx, el contenido de handle
    mov ah, 3eh              ;instruccion para cerrar el archivo
    int 21h                  ;ejecuta la interrupcion
cerrarArchivo ENDP
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

leerArchivo PROC    
    mov handle,ax            ;mueve a handle, el contenido de ax
    mov ah, 3fh              ;funcion para leer un fichero usando handler
    mov bx, handle           ;coloca en bx, el contenido del handle
    mov cx, 100              ;mueve a cx la cantidad de caracteres que lee del archivo
    lea dx, leido            ; pasa al dx lo que hay en el archivo
    int 21h                  ;ejecuta la interrupcion
leerArchivo ENDP
RET

;capturacontenido PROC
;    mov si,0
;capturar: 
;  mov ah,01h                 ;Coloca en ah, la funcion 01h para captura por teclado
;  int 21h                    ;ejecuta la interrupcion 
;  mov capturado[si],al       ;mueve a la etiqueta en la posicion de si, lo que esta en al
;  inc si                     ;incrementa si
;  cmp al,0dh                 ;compara si se presiono un enter
;  jne capturar               ;si no se presino, regresa a capturar
;ENDP
;RET
capturacontenido MACRO contenido
    LOCAL capturar,acabar 
    mov si,0
capturar: 
  mov ah,01h                 ;Coloca en ah, la funcion 01h para captura por teclado
  int 21h                    ;ejecuta la interrupcion 
  cmp al,0dh                 ;compara si se presiono un enter
  je acabar
  mov contenido[si],al       ;mueve a la etiqueta en la posicion de si, lo que esta en al
  inc si
  jmp capturar                     ;incrementa si
 acabar: 
  
ENDM

imprimircoincidencias PROC 
   ;Obtiene el digito decenas
   mov ah,09h                ;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio            ;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;Ejecuta la interrupcion
     
;Obtiene el digito centenas    
   iterar:
   xor ax,ax                                                    
   mov ax, coincidencias
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
   mov ax,coincidencias
   sub ax, aux
   mov coincidencias, ax  
   
   mov ax,aux2 
   mov bx,10
   div bx
   mov aux2,ax
   cmp aux2,0
   JE salir
   cmp aux2,1
   JAE iterar
   
    salir:
imprimircoincidencias ENDP   
  RET


 fin:
END                          ;Termina el programa