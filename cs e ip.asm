.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria
cadena DB 10,13, 'HOLA MUNDO',' $';Se define una variable llamada CADENA con el mensaje "HOLA MUNDO"
cont db 0                    ;Definicion de la variable cont con valor 0
cont2 db 0                   ;Definicion de la variable cont2 con valor 0


.CODE                        ;Define el segmento de codigo
PROGRAMA:                    ;Etiqueta que define el codigo del programa
    MOV AX,@DATA             ;Mueve al registro de proposito general AX lo que esta en DATA
    MOV DS,AX                ;Mueve al registro DS, los datos de AX      
ciclo:                       ;etiqueta 
    CMP cont,2               ;hace la comparacion de cont si es igual a 2
    JE  far ciclo2           ;si el resultado de la comparacion anterior es igual hace el salto
    MOV DX,OFFSET cadena     ;Lee en DX lo que tiene CADENA
    MOV AH,9                 ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                  ;Se genera la interrupcion que nos muestra el MS-DOS
    INC cont                 ;incrementa cont en uno
    JMP ciclo                ;salta a la etiqueta sin contar ningun dato ni bandera
ciclo2:
    CMP cont2,2              ;hace la comparacion de cont2  si es igual a 2
    JE  salir                ;si el resultado de la comparacion anterior es igual hace el salto
    MOV BX,OFFSET cadena     ;Lee en DX lo que tiene CADENA
    MOV AH,9                 ;Se carga en AH el servicio 9 para desplegar la cadena
    INT 21H                  ;Se genera la interrupcion que nos muestra el MS-DOS
    INC cont2                ;incrementa cont2 en uno
    JMP ciclo2               ;salta a la etiqueta sin contar ningun dato ni bandera
Salir:
    

END PROGRAMA                 ;Termina el programa