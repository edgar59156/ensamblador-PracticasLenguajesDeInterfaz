.MODEL SMALL                 ;Define el modelo de memoria
.STACK                       ;Definie una Pila de 1k
.DATA                        ;Define el inico del segmento de datos para las variables de memoria
msg DB 10,13 ,'Ingrese numero: ','$';Se define una variable llamada CADENA con el mensaje "HOLA MUNDO"
msg1 DB 10,13 ,'numero ingresado: ','$'
u db 0                    ;Definicion de la variable cont con valor 0
d db 0                   ;Definicion de la variable cont2 con valor 0
n db 0

.CODE                        ;Define el segmento de codigo
   mov ax,@data
   mov ds,ax
   
   
   
   mov ah,09h
   lea dx,msg
   int 21h
   
   mov ah,01h
   int 21h
   sub al,30h
   mov d,al
   
   mov ah,01h
   int 21h
   sub al,30h
   mov u, al
    
   mov al,d
   mov bl,10
   mul bl
   add al,u
   mov n,al
   
   mov ah,09h
   lea dx,msg1
   int 21h
   
   mov al,n
   AAM
   mov bx,ax
   mov ah,02h
   mov dl,bh
   add dl,30h
   int 21h
   
   mov ah,02h
   add dl,bl
   add dl,30h
   int 21h
   
    
    
  .exit  

END                  ;Termina el programa