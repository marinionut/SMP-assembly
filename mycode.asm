INCLUDE 'emu8086.inc'

.model small

.stack 100h

.data

menu db "Please select a choice:",13,10
     db "1. Deseneaza triunghi",13,10
     db "2. Deseneaza dreptunghi",13,10
     db "3. Exit",13,10,'$'

.code
start:

;INITIALIZE DATA SEGMENT.
  mov  ax, @data
  mov  ds, ax

  call clear_screen      
  call display_menu    
  
  call BEEP

;WAIT FOR ANY KEY.    
  mov  ah, 00h
  int  16h
  
  CMP al, 31h 
  je triunghi
  CMP al, 32h 
  je dreptunghi 
  
  call BEEP
  
;FINISH PROGRAM.
  mov  ax, 4c00h
  int  21h

;---------------------------------------------

display_menu proc
  mov  dx, offset menu
  mov  ah, 9
  int  21h
  ret
display_menu endp

clear_screen proc
  mov  ah, 0
  mov  al, 3
  int  10H
  ret
clear_screen endp 

dreptunghi  PROC
    

w equ 100 ; dimensiune dreptunghi
h equ 60
 mov ah, 0
 mov al, 13h ; trecere in mod grafic 320x200
 int 10h
 ; afisare latura superioara
 mov cx, 100+w ; coloana
 mov dx, 20 ; rand
 mov al ,9 ; alb
u1: mov ah, 0ch ; afisare pixel
 int 10h
 dec cx
 cmp cx, 100
 jae u1
 ; afisare latura inferioare
 mov cx, 100+w
 mov dx, 20+h
 mov al, 10
u2: mov ah, 0ch
 int 10h
 dec cx
 cmp cx, 100
 ja u2
 ; latura din stanga
 mov cx, 100
 mov dx, 20+h
 mov al, 11
u3: mov ah, 0ch
 int 10h
 dec dx
 cmp dx, 20
 ja u3
 ; latura din dreapta
 mov cx, 100+w
 mov dx, 20+h
 mov al, 12 
u4: mov ah, 0ch
 int 10h
 dec dx
 cmp dx, 20
 ja u4
 ; asteptare apasare tasta
 call BEEP 
 PUTC 13
 PUTC 10
 PRINT "Press any key to continue..."
 mov ah,00
 int 16h 
 jmp start
 
 ret
dreptunghi  ENDP      

triunghi PROC
 mov ah, 0
 mov al, 13h ; trecere in mod grafic 320x200
 int 10h
 ; afisare latura superioara
 mov cx, 100 ; coloana
 mov dx, 100 ; rand
 mov al, 4 ; rosu 
 uu1: mov ah, 0ch ; afisare pixel
 int 10h
 add cx, 2
 sub dx, 3 
 cmp dx, 14
 mov ah, 0ch
 int 10h
 inc cx
 sub dx, 2
 cmp dx, 14
 jae uu1
 ; afisare latura inferioasa
 mov cx, 200
 mov dx, 100
 mov al, 14 ; galben
 uu2: mov ah, 0ch
 int 10h
 dec cx
 cmp cx, 100
 jae uu2
 ;latura din dreapta
 mov cx, 200
 mov dx, 100
 mov al, 1; albastru
 uu3: mov ah, 0ch
 int 10h
 dec cx
 sub dx, 3
 cmp dx, 14
 mov ah, 0ch
 int 10h
 dec dx
 dec cx
 cmp dx, 14
 jae uu3
 ;asteptare apasare tasta  
 call BEEP
 PUTC 13
 PUTC 200
 PRINT "Press any key to continue..."
 mov ah,00
 int 16h 
 jmp start
 
 ret
 
triunghi ENDP     

beep PROC        ;genereaza un beep
    mov ah, 02
    mov dl, 07h
    int 21h
    ret
beep ENDP

end start 


