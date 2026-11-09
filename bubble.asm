
default rel

extern printf
global main

section .data
    arr dd 34, -5, 12, 0, 87, 23, -11, 6, 42, 1
    fmt_num db "%d ", 0
    fmt_end db 10, 0

section .text
main:
    push rbx
    push rsi
    sub rsp, 40

    lea rbx, [arr]

    xor r8d, r8d

.outer:
    xor r10d, r10d
    xor r9d, r9d

    mov r11d, 9
    sub r11d, r8d

.inner:
    mov eax, [rbx + r9*4]
    mov edx, [rbx + r9*4 + 4]

    cmp eax, edx
    jle .no_swap ; если левый элемент меньше или равен правому, обмен не нужен
        ; В ассемблере часто удобнее сначала проверить условие и перейти к альтернативной ветке, если оно не выполняется
    mov [rbx + r9*4], edx
    mov [rbx + r9*4 + 4], eax

    mov r10d, 1

.no_swap:
    inc r9d
    cmp r9d, r11d
    jl .inner ; если индекс меньше границы, продолжаем внутренний цикл

    test r10d, r10d
    jz .done_sort ; если флаг обмена равен нулю, заканчиваем сортировку

    inc r8d
    cmp r8d, 9
    jl .outer ; если осталось выполнить проходы, возвращаемся к внешнему циклу

.done_sort:
    xor esi, esi

.print:
    mov edx, [rbx + rsi*4]
    lea rcx, [fmt_num]
    call printf

    inc esi
    cmp esi, 10
    jl .print

    lea rcx, [fmt_end]
    call printf

    xor eax, eax

    add rsp, 40
    pop rsi
    pop rbx
    ret
