section .data
    child_fmt:  db "Child (PID %d)",10,0
    parent_fmt: db "Parent (PID %d).",10,0
    ended_fmt:  db "Child after _exit(42) (PID %d).",10,0
    status_fmt: db "Exit status : %d",10,0

section .bss
    status:     resq 1
    child_pid:  resq 1

section .text
    extern printf
    global _start

_start:
    sub rsp, 8              ; Wyrównanie stosu

    ; 1. Pobierz PID rodzica na samym początku
    mov rax, 39             ; getpid()
    syscall
    mov rsi, rax            ; PID rodzica do rsi
    mov rdi, parent_fmt
    xor rax, rax
    call printf

    ; 2. Wykonaj fork
    mov rax, 57             ; fork()
    syscall

    cmp rax, 0
    jl exit_program         ; błąd
    jz child_process        ; rax == 0 -> proces potomny

parent_process:
    mov [child_pid], rax    ; zapisz PID dziecka

    ; wait4() - czekaj na zakończenie dziecka
    mov rdi, [child_pid]
    mov rsi, status
    xor rdx, rdx
    xor r10, r10
    mov rax, 61
    syscall

    ; 3. Wypisz PID rodzica po zakończeniu dziecka
    mov rax, 39             ; getpid() - ponownie pobieramy PID rodzica
    syscall
    mov rsi, rax
    mov rdi, ended_fmt
    xor rax, rax
    call printf

    ; 4. Wypisz status wyjścia
    mov rax, [status]
    shr rax, 8
    and rax, 0xFF
    mov rsi, rax
    mov rdi, status_fmt
    xor rax, rax
    call printf

    jmp exit_program

child_process:
    ; 5. Pobierz i wypisz PID dziecka
    mov rax, 39             ; getpid()
    syscall
    mov rsi, rax
    mov rdi, child_fmt
    xor rax, rax
    call printf

    ; Zakończ dziecko z kodem 42
    mov rax, 60             ; exit()
    mov rdi, 42
    syscall

exit_program:
    add rsp, 8
    mov rax, 60             ; exit(0)
    xor rdi, rdi
    syscall