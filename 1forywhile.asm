
.MODEL SMALL                              ;Define el modelo de memoria
.STACK                                    ;Denine una pila de 1k
.DATA                                     ;Define el segmento de datos
MENSAJE DB 10,13,'Estoy en el While','$'  ;Define una variable llamada MENSAJE 
MENSAJE2 DB 10,13,'Estoy en el For','$'   ;Define una variable llamada MENSAJE2
cont1 db 0                                ;Define una variable llamada cont1
.CODE                                     ;Define el incio del segmentod e codigo
    MOV AX,@DATA                          ;Mueve alregisto AX el contenido de data
    MOV DS,AX                             ;Mueve al segmento de datos el contenido de AX
    MOV CX, 10                            ;Movemos al registro CX el valor de 10    
While:                                    ;Etiqueta
    LEA DX,MENSAJE                        ;Lee el contenido de la variable 
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Inicia la interrupcion para mostrar MENSAJE
LOOP while                                ;Crea un ciclo que salta en la etiqueta while y que decrementa CX
For:                                      ;Etiqueta
    LEA DX,MENSAJE2                       ;Lee el contenido de la variable 
    MOV AH,09                             ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                               ;Ejecuta la interrupcion
    INC cont1                             ;Incrementa en 1 cont1
    CMP cont1,10                         ;Compara si cont1 es igual a 10
    JBE For                               ;Si el resultado anterior es menor igual salta a For
END                                       ;Finaliza el programa