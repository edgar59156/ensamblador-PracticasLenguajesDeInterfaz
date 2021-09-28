.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria
cadena DB 10,13, 'HOLA MUNDO',' $';Se define una variable llamada CADENA con el mensaje "HOLA MUNDO"
cont db 0                    ;Definicion de la variable cont con valor 0
cont2 db 0                   ;Definicion de la variable cont2 con valor 0
cadena2 db 10,13, '//','$'   ;Definicion de la variable cadena2 con los caracteres //

.CODE                        ;Define el segmento de codigo
PROGRAMA:                    ;Etiqueta que define el codigo del programa
    MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
    MOV DS,AX                ;Mueve al registro DS, los datos de AX      
ciclo:                       ;etiqueta 
    CMP cont,10              ;hace la comparacion de cont si es igual a 10
    JE  ciclo2               ;si el resultado de la comparacion anterior es igual hace el salto
    MOV DX,OFFSET cadena     ;Lee en DX lo que tiene CADENA
    MOV AH,9                 ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                  ;Se genera la interrupcion que nos muestra el MS-DOS
    INC cont                 ;incrementa cont en uno
    JMP ciclo                ;salta a la etiqueta sin contar ningun dato ni bandera

ciclo2:   
    MOV DX,OFFSET cadena2    ;Lee en DX lo que tiene cadena2
    MOV AH,9                 ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                  ;se ejecuta la interrupcion para desplegar la cadena
    
    INC cont2                ;Incrementa el cont2 en uno
    MOV cont,0               ;Coloca el valor de 0 en la variable cont
    CMP cont2,9              ;Compara el valor de cont2 con 9
    JLE ciclo                ;Si el resultado es menor o igual va a la etiqueta ciclo

END PROGRAMA                 ;Termina el programa