
.MODEL SMALL                              ;Define el modelo de memoria
.STACK                                    ;Denine una pila de 1k
.DATA                                     ;Define el segmento de datos
MENSAJE DB 'INTRODUCE UN NUMERO (5 DIGITOS MAX):','$'     ;Define una variable llamada MENSAJE con el mensaje "Introduce tu cadena"
CADENA DB 100 dup ('$')                   ;Define un vector de tamano 100 
MENSAJE2 DB 10,13,'NUMEROS EN ASCII:','$'
Msg db 'en 6','$'
.CODE                                     ;Define el incio del segmentod e codigo

    MOV AX,@DATA                          ;Mueve alregisto AX el contenido de data
    MOV DS,AX                             ;Mueve al segmento de datos el contenido de AX
    LEA DX,MENSAJE                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar MENSAJE
    MOV SI,00h                            ;Inicia el contador en 0 para almacenar las letras de la cadena
LEER:                                     ;Etiqueta que define el segmento de codigo LEER 
    
    MOV AX,0000                           ;Coloca en AX el valor 0000
    MOV AH, 01h                           ;Ejecuta en AH la funcion 01H que sirve para leer los caracteres ingresador
    INT 21h 
                                          ;Inicia la interrupcion para mostrar el MS-DOS
    MOV CADENA[SI],AL                     ;Mueve a el vector CADENA en la posicion SI el contenido de AL
    sub CADENA[SI],30h 
    
    
    INC SI                                ;Incrementamos nuestro contador                         
    CMP AL,0DH                            ;Compara el caracter introducido, si se introdujo un enter
    JA LEER                               ;Salta a la etiqueta LEER
   
   
    LEA DX,MENSAJE2                       ;Lee el contenido de la variable MENSAJE2 en DX
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar el MS-DOS
    
    MOV SI,0
    LEA DX, CADENA[SI]                    ;Imprime el contenido del vector con la misma instrucción de una cadena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar CADENA  
    
    MOV SI,1
    CMP CADENA[SI],6
    je  h_f
    jne salir
    
    h_F:
    LEA DX,msg                       ;Lee el contenido de la variable MENSAJE2 en DX
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H
   
Salir:    
END