;;MACROS
;;----------------------------------------------------------------------------------------------
imprimir MACRO  msg
          mov ah,09h                ;;Mueve a ah la funcion 09h para el desplegado de una cadena
          lea dx,msg                ;;mueve a dx el contenido de la etiqueta para mostrarla
          int 21h                   ;;Ejecuta la interrupcion 
          ENDM 
;;MACRO QUE IMPRIME NUMEROS 
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
    mov digitos,10000        ;;Reinicia el valor de digitos, 10000 para imprimir 5 digitos
 ENDM                
 
;MACRO QUE BUSCA LA PALABRA EN UN TEXTO
buscarpalabra MACRO          ;;Nombre de la macro
  LOCAL compara,denuevo,sigue,ocurrencia,contarpalabras,incrementar,finalizar ;Etiqueras locales
  mov si,0                   ;;Colooca en si, 0
  mov di,0                   ;;Coloca en di, 0
compara:
  xor CX,CX                  ;;Limpia cx
  INC di  ;leido             ;Incrementa di, para comenzar en el caracter 1
  INC si  ;palabra           ;incrementa si, para comenzar en el caracter 1
denuevo:
  MOV ch, leido[di-1]        ;;Mueve a ch, el contenido de la cadena en la posicion di-1
  MOV cl, palabra[si-1]      ;;Mueve a cl, el contenido de la cadena en la posicion di-1
  CMP palabra[si],24h        ;;Compara si el contenido de la candena en la posicion de si, es igual 24h o $
  je ocurrencia              ;;Si es igual, salta a ocurrencia
  CMP leido[di],20h          ;;Compara si el contenido de la candena en la posicion de di, es igual 20h o espacio
  JE  contarpalabras         ;;Si es igual salta a la etiqueta
sigue:  
  CMP leido[di],24h          ;;Compara si el caracter en la posicion de di, es igual a 
  je finalizar               ;;Si es igual, ve a finalizar
  CMP cl,ch                  ;;compara el contenido de cl con ch
  JE  compara                ;;Si son iguales, ve a la etiqueta
  JNE incrementar            ;;Si no son iguales ve a la etiqueta
OCURRENCIA:
  MOV si, 1                  ;;reinica si a 1     
  INC coincidencias          ;;Incrementa las coincidencias        
  JMP denuevo                ;;Regresa a la etiqueta 
contarpalabras:
  inc nopalabras             ;;Incrementa el numero de palabras leidas
  jmp sigue                  ;;regresa a la etiqueta
incrementar:
  inc di                     ;;Incrementa di       
  CMP palabra[si],24h        ;;Compara si el contenido de palabra en la posicion de si, es igual a 24h o $
  JE  ocurrencia             ;;si es igual, ve a ocurrencia
  CMP leido[di],24h          ;;Compara si el contenido de palabra en la posicion de si, es igual a 24h o $
  JE  finalizar              ;;Si son iguales, ve a finalizar
 jmp  denuevo                ;;Regresa a la etiqueta
finalizar:
   inc nopalabras               ;;Incrementa el numero de palabras
   imprimir numerocoincidencias ;;invoca a la macro
   imprimirnumero coincidencias ;;invoca a la macro
   imprimir numeropalabras      ;;invoca a la macro
   imprimirnumero nopalabras    ;;invoca a la macro
   jmp leer                     ;;Salta a la etiqueta
  ENDM
;;MACRO QUE CAPTURA UN TEXTO
capturacontenido MACRO contenido ;;Nombre de la macro
  LOCAL capturar,acabar      ;;Nombre de las etquetas locales
  mov si,0                   ;;Coloca en si, 0
capturar: 
  mov ah,01h                 ;;Coloca en ah, la funcion 01h para captura por teclado
  int 21h                    ;;ejecuta la interrupcion 
  cmp al,0dh                 ;;compara si se presiono un enter
  je acabar                  ;;Salta a la etiqueta
  mov contenido[si],al       ;;mueve a la etiqueta en la posicion de si, lo que esta en al
  inc si                     ;;Incrementa SI
  jmp capturar               ;;incrementa si
 acabar:   
ENDM 
 