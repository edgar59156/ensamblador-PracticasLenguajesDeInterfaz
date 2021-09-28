imprime macro cadena
;mov ax,data
;mov ds,ax

mov ah,09
mov dx,offset cadena
int 21h
endm

.model small
.stack
.data
msj db 0ah,0dh, '***** Menu *****', '$'
msj2 db 0ah,0dh, '1.- Crear Archivo', '$'
msj3 db 0ah,0dh, '2.- Abrir Archivo', '$'
msj4 db 0ah,0dh, '3.- Modificar archivo', '$'
msj5 db 0ah,0dh, '4.- Eliminar archivo', '$'
msj6 db 0ah,0dh, '5.- Salir', '$'
msj7 db 0ah,0dh, 'El Cerrado de un archivo se hace automatico', '$'
msjelim db 0ah,0dh, 'Archivo eliminado con exito', '$'
msjcrear db 0ah,0dh, 'Archivo creado con exito', '$'
msjescr db 0ah,0dh, 'Archivo escrito con exito', '$'
msjnom db 0ah,0dh, 'Nombre del archivo: ', '$'
cadena db 'Cadena a Escribir en el archivo','$'
nombre db 'C:\prueba.txt',0
vec db 50 dup('$')

handle db 0
linea db 10,13,'$'

.code
main proc;;;;;;;;;;;;;;;;;;;;;Parte Acresentada
inicio:
mov ax,@data
mov ds,ax

menu:
imprime msj
imprime msj2
imprime msj3
imprime msj4
imprime msj5
imprime msj6
imprime msj7

mov ah,0dh
int 21h

mov ah,01h
int 21h

cmp al,31h
je crear
cmp al,32h
je abrir
cmp al,33h
je pedir
cmp al,34h
je eliminar2
cmp al,35h
je salir2

crear:
; Crear
mov ah,3ch
mov cx,0
mov dx,offset nombre
int 21h
jc salir2
imprime msjcrear
mov bx,ax
mov ah,3eh
int 21h
jmp menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;Esta parte fue acresentada;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
eliminar2:
jmp eliminar
salir2:
jmp salir
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;Ate aqui;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
abrir:
; Abrir
mov ah,3dh
mov al,0h
mov dx,offset nombre
int 21h

mov bx,ax

; Leer archivo
mov ah,3fh
; mov bx,ax
; mov bx,ax

mov cx,50
mov dx,offset vec
; mov dl,vec[si]
int 21h
mov ah,09h
int 21h

; Cierre de archivo
mov ah,3eh
int 21h
jmp menu

pedir:
mov ah,01h
int 21h
mov vec[si],al
inc si
cmp al,0dh

ja pedir
jb pedir

editar:
; Abrir
mov ah,3dh
mov al,1h
mov dx,offset nombre
int 21h
jc salir
; Escritura de archivo
mov bx,ax       
mov cx,si
mov dx,offset vec
mov ah,40h
int 21h
mov handle,bl
mov bx,ax
imprime msjescr
mov ax,bx
cmp cx,ax

jne salir
mov ah,3eh
mov bl,handle
int 21h
jmp menu

eliminar:
; Cierre de archivo
mov ah,3eh
int 21h
; Eliminar archivo
mov ah,41h
mov dx,offset nombre
int 21h

jc salir
imprime msjelim

salir:
mov ah,04ch
int 21h
main endp;;;;;;;;;;
end main;;;;;;;;;;;