.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria
.CODE                        ;Define el segmento de codigo                                                    

 
 PROGRAMA:

;Direccionamiento inmediato 
   ADD      AX, 0fffh         ;Movimiento de un dato al registro AX (acumulador),BX,CX y AL
   MOV      BX, 0001h         ;En es este modo se puede definir un valor
   MOV      CX,0xAAAA         ;constante, si se trabaja con el registro completo 
   MOV      AL,0x11           ;o tanto si se trabaja para 8 bits parte baja y parte alta
   
;Direccionamiento de registro
                              ;En este modo de direccionamiento se trabaja directamente con 
   MOV      AX,BX             ;los registros, es decir se mueven los datos que estan dentro 
   MOV      AH,AL             ;de ellos, y ambos tienen que ser del mismo tipo, si es el 
                              ;registro completo o si es la parte baja o alta, este tipo de
                              ;direccionamiento es el que se utliza por ejemplo en operaciones 
                              ;como lo son multiplicaciones
   
;Direccionamiento absoluto
    MOV AX, [57D1h]           ;En este modo de direccionamiento, se le asigna el valor 
    MOV AX,ES:[429Ch]         ;al registro directamente de la posicion de memoria indicada en 
                              ;operando fuente
;Direccionamiento indirecto
    MOV     AX,[BP]           ;En este modo de direccionamiento, el operando fuente contiene
    MOV     ES:[DI],AX        ;la direccion de memoria de donde se tomara el dato
                              ;es decir, para el primer ejemplo, BP contiene la direccion donde
                              ;AX tomara el dato

;Direccionamiento base        ;En este modo de direccionamiento, el registro que contiene la
    MOV     AX,[BX]           ;direccion de memoria de donde se tomara el dato, es un registro
                              ;base (AX) 


;Direccionamiento indice o indexado
    MOV     AX,[DI]           ;Este modo direccionamiento la direccion se obtiene de un registro
    ADD     [SI],BX           ;indice,  (SI o DI) ejemplo de ello es la obtencion de una
                              ;cadena de caracteres y su almacenamiento letra por letra en 
                              ;un vector o arreglo

;Direccionamiento con base e indice o indexado a base
    MOV     AX,ES:[BX+DI]     ;En este modo de direccionamiento se utliza un registro base
    MOV     CS:[BX+SI],CX     ;(AX o BX), y un registro indice (SI o DI)
    MOV     AL,[BP+SI]
;Direccionamiento base+desplazamiento indice+desplazamiento y base+indice+desplazamiento
    MOV     AX,[BP+7]         ;En este modo de direccionamiento se utliza un registro base
    MOV     AX,[DI+7]         ; y un desplazamiento o un registro indice y un desplazamiento
    MOV     AX,[BX+SI+7]      ;o la suma de un registro indice, uno base y un desplazamiento

END PROGRAMA                 ;Termina el programa           