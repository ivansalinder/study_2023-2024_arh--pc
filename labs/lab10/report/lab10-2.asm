%include 'in_out.asm'
SECTION .data
filename db 'name.txt', 0h ; Имя файла
msg db 'Как Вас зовут? ', 0h ; Сообщение
msg1 db 'Меня зовут ', 0h ;
SECTION .bss
contents resb 255 ; переменная для вводимой строки
SECTION .text
global _start
_start:
; --- Печать сообщения `msg`
mov eax,msg
call sprint
; ---- Запись введеной с клавиатуры строки в `contents`
mov ecx, contents
mov edx, 255
call sread
;--- Создание файла для записи имени
mov ecx,0777o ; разрешения
mov ebx,filename ; имя файла
mov eax,8 ; номер сис выозва для создание
int 80h
; --- Открытие существующего файла (`sys_open`)
mov ecx,2 ; открываем для записи (2)
mov ebx,filename
mov eax,5
int 80h
; --- Запись дескриптора файла в `esi`
mov esi,eax
; --- Расчет длины введенной строки msg1
mov eax,msg1
call slen
; --- Записываем в файл `msg1` (`sys_write`)
mov edx, eax
mov ecx, msg1

mov ebx, esi
mov eax, 4
int 80h
; --- Расчет длины введенной строки
mov eax, contents ; в `eax` запишется количество
call slen ; введенных байтов
; --- Записываем в файл `contents` (`sys_write`)
mov edx, eax
mov ecx, contents
mov ebx, esi
mov eax, 4
int 80h
; --- Закрываем файл (`sys_close`)
mov ebx, esi
mov eax, 6
int 80h
call quit
