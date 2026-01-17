; nasm -f elf64 sysexit.asm -o sysexit.o
; ld -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 sysexit.o -o sysexit_asm

section .data
    msg_error       db "Podaj dokładnie 1 argument!", 10, 0
    msg_not_digit   db "Argument musi być TYLKO liczbą całkowitą!", 10, 0
    fmt_before      db "String przed _exit(%d)", 10, 0
    fmt_after       db "String po _exit(%d), ktory nigdy się nie wykona.", 10, 0

section .text
    global _start
    extern printf, atoi

_start:
    ; Na starcie programu w Linux x86_64:
    ; [rsp]      = argc
    ; [rsp + 8]  = argv[0] (ścieżka programu)
    ; [rsp + 16] = argv[1] (pierwszy argument)

    mov rdi, [rsp]          ; Pobierz argc do rdi

    ; Sprawdzenie: if (argc == 1 || argc != 2) -> czyli musi być dokładnie 2 (program + 1 arg)
    cmp rdi, 2
    je validate_input

    ; Jeśli argc != 2, wypisz błąd i zakończ
    mov rdi, msg_error
    xor rax, rax            ; AL=0 dla printf (brak argumentów float)
    call printf

    mov rax, 60             ; syscall: exit
    mov rdi, -1             ; return -1
    syscall

validate_input:
    mov rbx, [rsp + 16]     ; rbx = argv[1]
    mov rcx, 0              ; i = 0

check_loop:
    movzx rax, byte [rbx + rcx] ; Pobierz znak argv[1][i]
    test al, al                 ; Sprawdź czy to koniec stringa (\0)
    jz convert_and_exit

    ; Odpowiednik isdigit(): sprawdź czy w zakresie '0' - '9' (ASCII 48-57)
    cmp al, '0'
    jl not_digit_error
    cmp al, '9'
    jg not_digit_error

    inc rcx
    jmp check_loop

not_digit_error:
    mov rdi, msg_not_digit
    xor rax, rax
    call printf

    mov rax, 60             ; syscall: exit
    mov rdi, 1              ; _exit(1)
    syscall

convert_and_exit:
    ; Przygotowanie do atoi(argv[1])
    mov rdi, rbx            ; rdi = argv[1]
    call atoi               ; wynik w rax
    mov r12, rax            ; r12 = error_code (używamy r12, bo printf go nie nadpisze)

    ; printf("String przed _exit(%d)\n", error_code)
    mov rdi, fmt_before
    mov rsi, r12
    xor rax, rax
    call printf

    ; WYWOŁANIE _exit(error_code)
    mov rax, 60             ; numer syscalla sys_exit
    mov rdi, r12            ; status wyjścia
    syscall                 ; <-- Tutaj proces kończy życie

    ; KOD PONIŻEJ NIGDY SIĘ NIE WYKONA
    ; Zachowujemy go dla 100% zgodności z Twoim kodem C
    mov rdi, fmt_after
    mov rsi, r12
    xor rax, rax
    call printf

    ; Dodatkowy exit na wszelki wypadek (choć proces już nie istnieje)
    mov rax, 60
    xor rdi, rdi
    syscall