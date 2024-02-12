
%include 'in_out.asm'
section .data
msg1 db 'Введите значение x: ',0h
msg2 db 'Введите значение a: ',0h
msg3 db 'f(x) = ',0h

section .bss
x resb 10
a resb 10

section .text
global _start
_start:
mov eax,msg1
call sprint
mov ecx,x
mov edx,10
call sread
mov eax,x
;----------
call atoi
mov [x],eax
;-----------

mov eax,msg2
call sprint
mov ecx,a
mov edx,10
call sread
mov eax,a ;
call atoi
mov [a],eax ;
;----------
mov ecx,[a]
cmp ecx,[x] ;x<a
jg check_a ;
mov eax,[a]
mov ebx,-1
mul ebx
mov ecx,[x]
add ecx,eax
jmp _end
check_a:
mov ecx,5;
_end:
mov eax,msg3 ;
call sprint ;
mov eax,ecx ;
call iprintLF;
call quit ;
