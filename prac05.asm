
default rel

extern printf
global main

section .rdata
    arr dd 12, -7, 42, 0, 5
    n dd 5

    fmt_max db "Maximum = %d", 10, 0
    fmt_pos db "Positive = %d", 10, 0
    fmt_fact db "5! = %d", 10, 0

section .text
main:
    push rbx
    push rsi
    push rdi
    sub rsp, 32

; Задание 1.

    lea rbx, [arr]
    mov eax, [rbx] ; max = arr[0]
    mov ecx, 1 ; i = 1

.loop_max:
    mov edx, [rbx + rcx*4]
    cmp edx, eax
    jle .skip_max

    mov eax, edx ; новый максимум

.skip_max:
    inc ecx
    cmp ecx, [n]
    jb .loop_max

    mov edx, eax
    lea rcx, [fmt_max]
    call printf


; Задание 2.

    lea rbx, [arr]
    xor esi, esi ; i = 0
    xor edi, edi ; count = 0

.loop_pos:
    cmp esi, [n]
    jge .done_pos

    mov edx, [rbx + rsi*4]
    test edx, edx
    jle .skip_pos

    inc edi ; count++

.skip_pos:
    inc esi
    jmp .loop_pos

.done_pos:
    mov edx, edi
    lea rcx, [fmt_pos]
    call printf


; Задание 3.

    mov ecx, [n] ; result = 1
    mov eax, 1 ; n = 5

.loop_fact:
    imul eax, ecx
    loop .loop_fact

    mov edx, eax
    lea rcx, [fmt_fact]
    call printf


; Завершение

    xor eax, eax

    add rsp, 32
    pop rdi
    pop rsi
    pop rbx
    ret
