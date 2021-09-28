;SE REQUIERE DE UN PROGRAMA ESCRITO EN EL LENGUAJE ENSAMBLADOR, QUE SEA CAPAZ
;DE PRESENTAR AL USUARIO UN MENU DE OPCIONES EN EL CUAL SE OFREZCAN LOS SIGUIENTES
;CALCULOS: CREAR,ABRIR, LEER ( SECUENCIAL Y ALEATORIAMENTE ), MODIFICAR, CERRAR ARCHIVOS EN
;EL LENGUAJE ENSAMBLADOR. 
;ADEMAS ESTE MENU SE MOSTRARA AL USUARIO INDEFINIDAMENTE PARA VOLVER
;A REPETIR LOS CALCULOS (N) VECES HASTA QUE EL DECIDA TERMINAR.
;EL PROGRAMA DEBE OFRECER UNA OPCION FORMAL PARA TERMINAR Y EN ESE MOMENTO
;SE LE PREGUNTARA AL USUARIO LO SIGUIENTE :
;REALMENTE DESEA SALIR DEL PROGRAMA ( S/N ) ?
;A LO CUAL PUEDE CONTESTAR PRESIONANDO UNA 'S' O BIEN UNA 'N'. 
;SI RESPONDE CON LA LETRA 'S' EN MINUSCULA O BIEN MAYUSCULA, TERMINARA LA EJECUCION.
;DE LO CONTRARIO SE DEBERA BORRAR EL CONTENIDO DE LA PANTALLA Y VOLVER A
;DESPLEGAR EL MENU COMPLETO.
;---------------PROGRAMA PARA EL MANEJO DE ARCHIVOS---------------
.MODEL small
.STACK ;Segmento de pila
.DATA ;segmento de datos
opcion db 0
opcionTerminar db ''
msg1 db 0ah,0dh, 'ARCHIVOS: MANEJO Y ADMINISTRACION DE DATOS','$' 
msg2 db 0ah,0dh, '------------------------------------------','$'
msgVacio db 0ah,0dh,'$'
msgCrear db 0ah,0dh, '1. CREAR UN ARCHIVO DE TEXTO EN DISCO','$'
msgAbrir db 0ah,0dh, '2. ABRIR EL ARCHIVO Y HACER LA CAPTURA DE DATOS POR TECLADO','$'
msgListar db 0ah,0dh, '3. LISTAR EN PANTALLA EL CONTENIDO DEL ARCHIVO','$'
msgCerrar db 0ah,0dh, '4. CERRAR EL ARCHIVO','$'
msgEliminar db 0ah,0dh, '5. ELIMINAR EL ARCHIVO EN DISCO','$'
msgTerminar db 0ah,0dh, '6. TERMINAR ','$'
msgOpcion db 0ah,0dh, 'ELIJA SU OPCION:', '$'
msgMenup db 0ah,0dh, 'PRESIONE CUALQUIER TECLA PARA REGRESAR AL MENU PRINCIAL...','$'
msgCrear1 db 0ah,0dh, 'ARCHIVOS: MANEJO Y ADMINISTRACION DE DATOS [OPCION 1]','$'
msgCrear2 db 0ah,0dh, 'INGRESE EL NOMBRE DEL NUEVO ARCHIVO A CREAR: ','$'
msgCrear3 db 0ah,0dh, 'AVISO: ARCHIVO CREADO EXITOSAMENTE!','$'
msgAbrir1 db 0ah,0dh, 'ARCHIVOS: MANEJO Y ADMINISTRACION DE DATOS [OPCION 3]','$'
msgAbrir2 db 0ah,0dh, 'PORFAVOR INGRESE LOS DATOS ALMACENADOS SON:','$'
msgAbrir3 db 0ah,0dh, '--fin de la cita--','$'
msgListar1 db 0ah,0dh, 'ARCHIVOS: MANEJO Y ADMINISTRACION DE DATOS [OPCION 2]','$'
msgListar2 db 0ah,0dh, 'INGRESE EL CONTENIDO DEL ARCHIVO datos_prueba.txt ES:','$'
msgListar3 db 0ah,0dh, '--fin de la cita--','$' 
msgCerrar1 db 0ah,0dh, 'ARCHIVOS: MANEJO Y ADMINISTRACION DE DATOS [OPCION 4]','$'
msgCerrar2 db 0ah,0dh, 'EL ARCHIVO datos_prueba.txt FUE CERRADO EXITOSAMENTE!','$'
msgEliminar1 db 0ah,0dh, 'ARCHIVOS: MANEJO Y ADMINISTRACION DE DATOS [OPCION 5]','$'
msgEliminar2 db 0ah,0dh, 'EL ARCHIVO datos_prueba.txt FUE ELIMINADO DE DISCO EXITOSAMENTE!','$'
msgTerminar1 db 0ah,0dh, 'REALMENTE DESEA SALIR DEL PROGRAMA ( S/N ) ?','$'
leido db 100 dup (24h) ; para leer 100 caracteres como maximo
archivo db 'c:\datos_prueba.txt', 0 ;nombre de archivo con su ruta
vec db 100 dup('$') ;100 espacios para el vector
msgError db 'Error: no se pudo realizar la operacion', 0ah,0dh,'$'
handler dw ? ; manejador que tendra diferentes funciones (crear, leer, eliminar, modificar), por eso se define como ?
.CODE ;segmento de codigo
inicio: 
mov ax, @data
mov ds, ax
mov es, ax 
mov ah,09h                                       
lea dx,msg1 ;lee el mensaje msg1
int 21h ;interrupcion mov ah,09h
lea dx,msg2 ;lee el mensaje msg2
int 21h ;interrupcion 
mov ah,09h
lea dx,msgVacio ;lee un mensaje vacio que usaremos para dar espacio
int 21h ;interrupcion 
mov ah,09h
lea dx,msgCrear ;Lee el mensaje de Crear
int 21h ;interrupcion
mov ah,09h
lea dx,msgAbrir ;Lee el mensaje de Salir
int 21h ;interrupcion
mov ah,09h
lea dx,msgListar ;Lee el mensaje de Listar
int 21h ;interrupcion
mov ah,09h
lea dx,msgCerrar ;Lee el mensaje de Cerrar
int 21h ;interrupcion 
mov ah,09h
lea dx,msgEliminar ;Lee el mensaje de Eliminarint 21h ;interrupcion
mov ah,09h
lea dx,msgTerminar ;Lee el mensaje de Terminar
int 21h ;interrupcion
mov ah,09h
lea dx, msgOpcion ;Lee el mensaje de opcion
int 21h ;interrupcion 
mov ah,01h
int 21h ;pedir valor
sub al,30h 
mov opcion, al ;pasar el valor a una variable
CMP opcion, 1 ;Compara el valor de opcion 1 == 1
JE crear ;JAE(Jump Above or equals) JB(Jump Below) JBE(Jump below or equals) JE(Jump equals) JA(Jump Above)
CMP opcion, 2 ;Compara el valor de opcion 2 == 2
JE listar: ;Salto a la etiqueta abrir
CMP opcion, 3 ;Compara el valor de opcion 3== 3
JE abrir: ;Salto a la etiqueta listar
CMP opcion, 4 ;Compara el valor de opcion 4 == 4
JE cerrar ;Salto a la etiqueta cerrar
CMP opcion, 5 ;Compara el valor de opcion 5 == 5
JE eliminar ;Salto a la etiqueta eliminarCMP opcion, 6 ;Compara el valor de opcion 6 == 6
JE terminar ;Salto a la etiqueta terminar
crear: 
mov ah,09h
lea dx, msgCrear1 ;Lee el mensaje de Crear1
int 21h ;interrupcion
mov ah,09h
lea dx, msg2 ;Lee el mensaje de msg2
int 21h ;interrupcion
mov ah,09h
lea dx, msgCrear2 ;Lee el mensaje msgCrear2
int 21h ;interrupcion 
mov ah,3ch ;instruccion para crear el archivo.
mov cx,0
mov dx,offset archivo ;crea el archivo con el nombre datos_prueba.txt
int 21h
jc salir
mov ah,09h
lea dx, msgCrear3 ;Lee el menu de salir
int 21h ;interrupcion 
mov bx,ax
mov ah,3eh ;se cierra el manejador de archivoint 21h
mov ah,09h
lea dx, msgMenup ;Lee el menu de salir
int 21h ;interrupcion 
mov ah,09h
lea dx, msgVacio ;Lee el menu de salir
int 21h ;interrupcion
jmp inicio ;salto a la etiqueta inicio

abrir: 
mov ah,09h
lea dx, msgAbrir1 ;Lee el mensaje msgAbrir1
int 21h ;interrupcion
mov ah,09h
lea dx, msg2 ;;Lee el mensaje msg2
int 21h ;interrupcion
mov ah,09h
lea dx, msgAbrir2 ;Lee el mensaje msgAbrir2
int 21h ;interrupcion


xor ax,ax ;pone en cero al reg ax.mov ax,data ;mueve la posicion de segmento data al reg ax.
mov ds,ax ;mueve la posicion de ax al reg DS.
mov al, 0h ;modo de acceso para abrir arhivo, modo lectura/escritura
mov dx, offset archivo ;offset lugar de memoria donde esta la variable
mov ah, 3dh ;se intenta abrir el archivo
int 21h ;llamada a la interrupcion DOS
mov handler,ax
mov bx, handler
mov cx, 100h ;cantidad de caracteres que lee del archivo
mov dx, offset leido ; pasa al dx lo que hay en el archivo
mov ah, 3fh ;funcion para leer un fichero usando handler
int 21h
;cerramos archivo
mov bx, handler
mov ah, 3eh
int 21h
;imprimir el contenido de leido
mov ah,09h
lea dx, msgVacio ;Lee el menu de salir
int 21h ;interrupcion 
mov dx, offset leido ; ;cargamos lo leido a los datos
mov ah, 9
int 21h
xor ax,ax ;limpia ax. 
mov ah,09h
lea dx, msgAbrir3 ;Lee el mensaje msgAbrir3int 21h ;interrupcion
mov ah,09h
lea dx, msgMenup ;Lee el menu de salir
int 21h ;interrupcion
jmp inicio ;cerramos archivo
listar:
mov ah,09h
lea dx, msgListar1 ;Lee el mensaje de Lista1
int 21h ;interrupcion
mov ah,09h
lea dx, msg2 ;Lee el mensaje de msg2
int 21h ;interrupcion
mov ah,09h
lea dx, msgListar2 ;Lee el mensaje msgListar2
int 21h ;interrupcion 

modifica:
mov ah,01h ;funcion para pedir datos por teclado
int 21h
mov vec[si],al ;colocamos cada lectura en el vector
inc si ;incremenramos el indice
cmp al,0dh
ja modifica ;este ciclo es para que leamos mas de un caracter
jb modifica ;sea el caracter que sea mientras no se presione enter
mov ah,3dh
mov al,1h ;Abrimos el archivo en solo escritura.
mov dx,offset archivo
int 21h
jc error ;Si hubo error
mov ah,40h ;funcion de escritura en archivo
mov bx,handler ;mover hadler
mov cx,si ;num de caracteres a grabar
mov dx,offset vec ;movemos el vector guardado al reg. de datos
int 21h
mov ah,09h
lea dx, msgListar3 ;Lee el mensaje msgAbrir3
int 21h ;interrupcion
cmp cx,ax
jmp cerrar
 
mov ah,09h
lea dx, msgMenup ;Lee el menu de salir
int 21h ;interrupcion
jmp inicio ;cerramos archivo
cerrar: ;cerrando archivo 
mov ah,09h
lea dx, msgCerrar1 ;Lee el menu de salir
int 21h ;interrupcion 
mov ah,09h
lea dx, msg2 ;Lee el menu de salir
int 21h ;interrupcion
mov ah,3eh ;funcion para cerrar
mov bx,handler ;devolvemos el handler a un registro
int 21h
mov ah,09h
lea dx, msgCerrar2 ;Lee el menu de salir
int 21h ;interrupcion
mov ah,09h
lea dx, msgMenup ;Lee el menu de salir
int 21h ;interrupcion
jmp inicio
eliminar: 
mov ah,09h
lea dx, msgEliminar1 ;Lee el mensaje de Deliminar1
int 21h ;interrupcion 
mov ah,09h
lea dx, msg2 ;Lee el mensaje de msg2
int 21h ;interrupcion
mov bx,handler ;movemos handler a registro para manejarlo
mov dx, offset archivo ;movemos el nombre del archivo al reg. de datos
mov ah,41h ;funcion para borrar ficheroint 21h
jc error ;Si hubo error
mov ah,09h
lea dx, msgEliminar2 ;Lee el mensaje de msgEliminar2
int 21h ;interrupcion 
mov ah,09h
lea dx, msg2 ;Lee el mensaje de msg2
int 21h ;interrupcion
mov ah,09h
lea dx, msgMenup ;Lee el mensajeMenp
int 21h ;interrupcion
jmp inicio
error:
mov ah,09h
lea dx, msgError ;Lee el menu de salir
int 21h ;interrupcion 
salir:
mov ah,04ch
int 21h 
terminar: 
mov ah,09h
lea dx, msgTerminar1 ;Lee el mensaje msgTerminar
int 21h ;interrupcion mov opcionTerminar, al ;pasar el valor a una variable
mov ah,01h
int 21h ;pedir valor
sub al,30h
CMP AL,'N' ;comparamos el valor ingresado
JE inicio ;salto a la etiqueta inicio
CMP AL,'n' ;comparamos el valor ingresado
JE inicio ;salto a la etiqueta inicio
CMP AL,'S' ;comparamos el valor ingresado
JE salir ;salto a la etiqueta salir
CMP AL,'s' ;comparamos el valor ingresado
JE salir ;salto a la etiqueta salir
END
