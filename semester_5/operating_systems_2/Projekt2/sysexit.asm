; nasm -f elf64 sysexit.asm -o sysexit.o
; ld -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 sysexit.o -o sysexitasm

section .data
    child_fmt:  db "Child (PID %d)",10,0
    parent_fmt: db "Parent (PID %d).",10,0
    ended_fmt:  db "Child after _exit(42) (PID %d).",10,0
    status_fmt: db "Exit status : %d",10,0

section .bss
    status:     resq 1      ; Bufor na status zakończenia dziecka
    child_pid:  resq 1      ; Przechowanie PID utworzonego procesu potomnego

section .text
    extern printf
    global _start

_start:
    sub rsp, 8              ; rsp -= 8: wyrównaj stos do 16B (wymóg ABI dla wywołań funkcji C)

;   Pobranie PID rodzica
    mov rax, 39             ; rax = 39: syscall getpid()
    syscall
    mov rsi, rax            ; rsi = parentPID (drugi argument printf)
    mov rdi, parent_fmt     ; rdi = &parent_fmt (pierwszy argument printf)
    xor rax, rax            ; rax = 0: brak zmiennych zmiennoprzecinkowych dla printf
    call printf

    ; 2. Wykonaj fork
    mov rax, 57             ; rax = 57: syscall fork()
    syscall

    cmp rax, 0
    jl exit_program         ; skok jeśli rax < 0: fork() error (błąd tworzenia procesu)
    jz child_process        ; skok jeśli rax == 0: kod wykonywany przez proces potomny

parent_process:
    mov [child_pid], rax    ; zapisz PID dziecka (w rodzicu fork zwraca PID potomka)
    mov rdi, [child_pid]    ; rdi = PID dziecka, na które czekamy
    mov rsi, status         ; rsi = wskaźnik na miejsce zapisu statusu wyjścia
    xor rdx, rdx            ; rdx = 0: brak dodatkowych opcji (options)
    xor r10, r10            ; r10 = 0: brak statystyk zużycia zasobów (rusage)
    mov rax, 61             ; rax = 61: syscall wait4()
    syscall

    ; 3. Wypisz PID rodzica po zakończeniu dziecka
    mov rax, 39             ; getpid() - ponownie pobieramy PID rodzica
    syscall
    mov rsi, rax            ; rsi = PID rodzica (do wyświetlenia w ended_fmt)
    mov rdi, ended_fmt      ; rdi = adres formatu komunikatu o zakończeniu
    xor rax, rax            ; rax = 0: przygotowanie do printf
    call printf

    ; 4. Wypisz status wyjścia
    mov rax, [status]       ; załaduj pełne słowo statusu odebrane przez wait4
    shr rax, 8              ; przesuń w prawo o 8 bitów (kod wyjścia jest w starszym bajcie słowa)
    and rax, 0xFF           ; maskuj dolny bajt (wyciągnięcie właściwej wartości exit_code)
    mov rsi, rax            ; rsi = przetworzony kod wyjścia (42)
    mov rdi, status_fmt     ; rdi = adres formatu statusu
    xor rax, rax            ; rax = 0: brak zmiennych XMM
    call printf

    jmp exit_program        ; skok do zakończenia procesu rodzica

child_process:
    ; 5. Pobierz i wypisz PID dziecka
    mov rax, 39             ; getpid() - pobranie PID aktualnego (potomnego) procesu
    syscall
    mov rsi, rax            ; rsi = PID dziecka
    mov rdi, child_fmt      ; rdi = adres formatu dla dziecka
    xor rax, rax            ; rax = 0: przygotowanie do printf
    call printf

    ; Zakończ dziecko z kodem 42
    mov rax, 60             ; rax = 60: syscall exit()
    mov rdi, 42             ; rdi = 42: kod powrotu przekazywany do rodzica
    syscall

exit_program:
    add rsp, 8              ; przywróć wskaźnik stosu (cofnij wyrównanie)
    mov rax, 60             ; rax = 60: syscall exit()
    xor rdi, rdi            ; rdi = 0: kod wyjścia programu głównego
    syscall