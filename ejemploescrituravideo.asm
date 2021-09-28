
.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria
leido db  1500 dup (' ')
handle dw ?
nombre db 'c:\LI_ARCHIVO_EXAMEN_13_v2.txt',0
.CODE                        ;Define el segmento de codigo
 
 MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
 MOV DS,AX                ;Mueve al registro DS, los datos de AX
 call abrirarchivo        ;Llama al procedemiento para abrir el archivo
 call leerarchivo         ;Lee el contenido del archivo
 call cerrararchivo       ;Cierra el archivo
   
 mov CX, 0B800H            ;Coloca en CX, la direccion de memoria para comenzar en el modo texto
 mov ES, CX                ;Mueve a ES, la direccion, ES se encarga de hacer el direccionamiento
 mov BX, offset leido      ;apunta inicio cadena texto
 mov AL, 0                 ;inicio en el renglon 0
 mov DX, 1                 ;y en columna 1
 mov CX, 1500              ;1500 caracteres
siguienteCaracterRenglon: 
 push AX                   ;guardar renglon en la pila
 call desplazamiento       ;calcular desplazamiento con la formula (Yp*80 + Xp)*2
 mov AL, [BX]              ;leer caracter del texto en memoria
 mov AH, 10001111B         ;fondo gris, con caracter color blanco
 mov ES:[SI], AX           ;escribirlo en VRAM, con la posicion calculada el contenido de AX (Color y caracter)
 inc BX                    ;siguiente caracter en buffer de texto
 inc DX                    ;siguiente columna
 pop AX                    ;rescatar la hilera
 loop siguienteCaracterRenglon  ;Repite el ciclo tantas veces como caracteres se vayan a escribir en pantalla
 jmp fin                   ;Salta a fin
desplazamiento: 
 push BX                   ;se usar BL para el producto por 80
 mov BL, 80                ;Numero de caracteres por renglon
 mul BL                    ;BL * AL (Yp*80)
 add AX, DX                ;AX + DX (Yp*80 + Xp)
 add AX, AX                ;(Yp*80 + Xp) * 2
 mov SI, AX                ;para devolver
 pop BX                    ;recuperar ...
 ret                       ;Instruccion de retorno

;---------------------------------------PROCEDIMIENTOS-------------------------------------------------- 
abrirArchivo PROC            ;Nombre del procedimiento
    mov ah, 3dh              ;se intenta abrir el archivo
    mov al, 00               ;modo de acceso para abrir arhivo, modo lectura
    mov dx, offset nombre    ;offset lugar de memoria donde esta la variable
    int 21h                  ;llamada a la interrupcion       
    jc fin                   ;si hay un error, va a fin     
abrirArchivo ENDP            ;Fin del procedmiento
RET                          ;Instruccion de retorno
cerrarArchivo PROC           ;Nombre del procedimiento
    mov bx, handle           ;coloca en bx, el contenido de handle
    mov ah, 3eh              ;instruccion para cerrar el archivo
    int 21h                  ;ejecuta la interrupcion
cerrarArchivo ENDP           ;Fin del procedmiento
RET                          ;Instruccion de retorno
leerArchivo PROC             ;Nombre del procedimiento
    mov handle,ax            ;mueve a handle, el contenido de ax
    mov ah, 3fh              ;funcion para leer un fichero usando handler
    mov bx, handle           ;coloca en bx, el contenido del handle
    mov cx, 1500             ;mueve a cx la cantidad de caracteres que lee del archivo
    lea dx, leido            ;pasa al dx lo que hay en el archivo
    int 21h                  ;ejecuta la interrupcion
leerArchivo ENDP             ;Fin del procedmiento
RET                          ;Instruccion de retorno

 fin:
END                          ;Termina el programa