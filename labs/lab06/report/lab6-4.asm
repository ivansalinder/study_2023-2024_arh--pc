%include 'in_out.asm' ; подключение внешнего файла

SECTION .data ; секция инициированных данных
    msg_prompt: DB 'Введите значение переменной x: ', 0
    div_msg: DB 'Остаток от деления: ', 0
    rem_msg: DB 'Результат: ', 0

SECTION .bss ; секция не инициированных данных
    x: RESB 10 ; Переменная для ввода значения x

SECTION .text ; Код программы
    GLOBAL _start ; Начало программы

_start: ; Точка входа в программу
    ; ---- Вывод приглашения для ввода x
    mov eax, msg_prompt
    call sprintLF

    ; ---- Ввод значения x
    mov ecx, x
    mov edx, 10
    call sread

    ; ---- Преобразование введенного значения в число
    mov eax, x
    call atoi

    ; ---- Вычисление выражения 4/3*(x - 1) + 5
    sub eax, 1 ; вычитаем 1
    imul eax, 4 ; умножаем на 4

    ; Расширяем результат до 64 бит, используя edx:eax
    ; Переход к 64-битной арифметике
    mov ebx, 3 ; ebx = 3
    xor edx, edx ; обнуляем edx для корректной работы div
    div ebx ; делим на 3

    add eax, 5 ; прибавляем 5
    mov edi, eax ; запись результата вычисления в 'edi'

    ; ---- Вывод результата на экран
    mov eax, rem_msg
    call sprint ; сообщение 'Результат: '
    mov eax, edi
    call iprintLF ; вывод результата

    ; ---- Вычисление остатка от деления на 3
    mov ebx, 3
    xor edx, edx ; обнуляем edx для корректной работы div
    div ebx
    mov eax, edx ; перемещаем остаток в eax

    ; ---- Вывод остатка на экран
    mov eax, div_msg
    call sprint ; сообщение 'Остаток от деления: '
    mov eax, edx
    call iprintLF ; вывод остатка

    ; ---- Завершение программы
    call quit


