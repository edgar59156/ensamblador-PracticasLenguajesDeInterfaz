 imprimir MACRO  msg
  mov ah,09h                ;;Mueve a ah la funcion 09h para el desplegado de una cadena
  lea dx,msg                ;;mueve a dx el contenido de la etiqueta para mostrarla
  int 21h                   ;;Ejecuta la interrupcion 
  ENDM 
  
  sumar MACRO  a,b,resultado
  mov ax,a                ;;Coloca en ax, el contenido de a
  mov bx,b                ;;Coloca en bx, el contenido de b
  add ax,bx               ;;Suma ax y bx
  mov resultado,ax        ;;Mueve el resultado de la operacion a la etiqueta resultado
  ENDM                    ;;Fin de la macro
      
  
  restar MACRO  a,b,resultado
  mov ax,a                ;;Coloca en ax, el contenido de a
  mov bx,b                ;;Coloca en bx, el contenido de b
  sub ax,bx               ;;Resta ax y bx
  mov resultado,ax        ;;Mueve el resultado de la operacion a la etiqueta resultado
  ENDM                    ;;Fin de la macro
 
  multiplicar MACRO  a,b,resultado
  mov ax,a                ;;Coloca en ax, el contenido de a
  mov bx,b                ;;Coloca en bx, el contenido de b
  mul bx                  ;;Multiplica ax y bx
  mov resultado,ax        ;;Mueve el resultado de la operacion a la etiqueta resultado
  ENDM                    ;;Fin de la macro
  
  dividir MACRO  a,b,resultado
  xor ax,ax               ;;Limpia ax
  mov al,a                ;;Coloca en ax, el contenido de a
  mov bl,b                ;;Coloca en bx, el contenido de b
  div bl                  ;;Divide ax y bx
  mov resultado,ax        ;;Mueve el resultado de la operacion a la etiqueta resultado
  ENDM                    ;;Fin de la macro

 imprimirnumero MACRO numero ;;Nombre de la macro
   LOCAL iterar,salir        ;;Etiquetas locales
   ;Obtiene el digito decenas
   mov ah,09h                ;;Mueve a ah la funcion 09h para el desplegado de una cadena
   lea dx,espacio            ;;mueve a dx el contenido de la etiqueta para mostrarla
   int 21h                   ;;Ejecuta la interrupcion     
;Obtiene el digito centenas    
   iterar:
   xor ax,ax                 ;;limpia el registo ax                                   
   mov ax, numero            ;;Mueve a ax, el contenido de numero
   xor dx,dx                 ;;limpia dx
   mov bx,digitos            ;;mueve a bx, el contenido de
   div bx                    ;;Ejecuta la division
   mov aux,0                 ;;Coloca el auxiliar en 0
   mov aux, ax               ;;mueve a auxiliar, el contenido de ax
   mov dx,ax                 ;;coloca en dx, el contenido de ax
   mov ah,02h                ;;Mueve a ah, la funcion 02h
   add dl,30h                ;;Hace un ajuste de 30h a dl
   int 21h                   ;;Ejecuta la interrupcion 21h 
;;Multiplica por el digtio de centenas a un auxiliar y luego lo resta a el resultado binario    
   xor ax,ax                 ;;limpia ax
   mov ax,digitos            ;;coloca en ax, los digitos
   mov bx,aux                ;;mueve a bx, el contenido de aux
   mul bx                    ;;multiplixa bx
   mov aux, ax               ;;coloca en ax, el contenido de numero
   mov ax,numero             ;;mueve a  ax, el contenido de aux                  
   sub ax, aux               ;;Resta a ax, el contenido de aux
   mov numero, ax            ;;Coloca en numero, el contenido de ax
   mov ax,digitos            ;;coloca en ax, el contenido de digitos
   mov bx,10                 ;;coloca en bx, 10
   div bx                    ;;divide ax y bx
   mov digitos,ax            ;;coloca en digitos el contenido de ax
   cmp digitos,0             ;;compara si digitos es igual a 0
   JE salir                  ;;Si es igual, sale
   cmp digitos,1             ;;Comprar si digitos es igual a 1
   JAE iterar                ;;Si es menor o igual, salta a iterar
    salir:
    mov digitos,100        ;;Reinicia el valor de digitos, 10000 para imprimir 5 digitos
 ENDM