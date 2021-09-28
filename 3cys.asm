
.MODEL SMALL                              ;Define el modelo de memoria
.STACK                                    ;Denine una pila de 1k
.DATA                                     ;Define el segmento de datos
MENSAJE DB 10,13, 'Bienvenido Que desea hacer?','$';Define una variable llamada MENSAJE
 numero DB 0                                       ;Define una valiable llamada numero con 0
 opcion1 DB 10,13,'1) Saludame','$'                ;Define una variable llamada opcion1
 opcion2 DB 10,13,'2) Cuentame un chiste','$'      ;Define una variable llamada opcion2
 opcion3 DB 10,13,'3) Despidete y finaliza','$'    ;Define una variable llamada opcion3
 espacio DB 10,13, ' ','$'                         ;Define una variable llamada espacio
 respuesta1 DB 10,13,'Muy buenas tardes!','$'      ;Define una variable llamada respuesta1
 respuesta2 DB 10,13,'Que es un terapeuta? R: 1024 Gigapeutas.','$' ;Define una variable llamada respuesta1 
 respuesta3 DB 10,13,'Adios','$'                    ;Define una variable llamada respuesta1
 
.CODE                                     ;Define el incio del segmentod e codigo

    MOV AX,@DATA                          ;Mueve alregisto AX el contenido de data
    MOV DS,AX                             ;Mueve al segmento de datos el contenido de AX
    LEA DX,MENSAJE                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar MENSAJE   
    LEA DX,opcion1                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar MENSAJE    
    LEA DX,opcion2                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar MENSAJE    
    LEA DX,opcion3                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar MENSAJE    
    LEA DX,espacio                        ;Lee el contenido de la variable candena
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar MENSAJE       
LEER:                                     ;Etiqueta que define el segmento de codigo LEER     
    MOV AH, 01h                           ;Ejecuta en AH la funcion 01H que sirve para leer los caracteres ingresador
    INT 21h                               ;Inicia la interrupcion para mostrar el MS-DOS
    sub al,30h                            ;Hace un ajuste para que el numero que esta en Al este en decimal
    MOV numero,AL                         ;Mueve a el vector CADENA en la posicion SI el contenido de AL    
Switch:                                   ;Etiqueta
    CMP numero,1                          ;Compara el numero con 1
    JE  case1                             ;Si es igual, va a la etiqueta case1
    CMP numero,2                          ;Compara el numero con 2
    JE  case2                             ;Si es igual, va a la etiqueta case2
    CMP numero,3                          ;Compara el numero con 3
    JE  case3                             ;Si es igual, va a la etiqueta case3
case1:                                    ;Etiqueta
    MOV numero,0                          ;Coloca el numero en 0
    LEA DX,respuesta1                     ;Lee el contenido de respuesta1
    MOV AH,09                             ;Carga el servicio 9 para mostrar la cadena
    INT 21H                               ;Ejecuta la interrupcion para mostrar el contenido
    JMP LEER                              ;Hace el salto a la etiqueta leer
case2:                                    ;etiqueta
    MOV numero,0                          ;Coloca el numero en 0
    LEA DX,respuesta2                     ;Lee el contenido de respuesta2
    MOV AH,09                             ;Carga el servicio 9 para mostrar la cadena
    INT 21H                               ;Ejecuta la interrupcion para mostrar el contenido
    JMP LEER                              ;Hace el salto a la etiqueta leer
case3:                                    ;Etiqueta
    MOV numero,0                          ;Coloca el numero en 0
    LEA DX,respuesta3                     ;Lee el contenido de respuesta3
    MOV AH,09                             ;Carga el servicio 9 para mostrar la cadena
    INT 21H                               ;Ejecuta la interrupcion para mostrar el contenido
END                                       ;Finaliza el programa