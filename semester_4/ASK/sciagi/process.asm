         [bits 32]

extern   _printf
extern   _exit

global   _main

;        Sekcja danych niezainicjowanych (ang. block started by symbol)

section  .bss

addr_b   resd 1  ; [ ][ ][ ][ ]  ; reserve double word 1 time

;        Sekcja danych zainicjowanych

section  .data

a        equ 1

addr_a   dd a  ; [1][0][0][0]  ; define double word

;        Sekcja kodu

section  .text

_main:

;        esp -> [ret]  ; return address

;        1. Odczyt z sekcji danych zainicjowanych

         push dword [addr_a]  ; *(int*)addr_a = a -> stack

         push format          ; format -> stack

;        esp -> [format][a][ret]

         call _printf  ; printf(format, a);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

;        2. Zapis do sekcji danych niezainicjowanych

b        equ 2

         mov dword [addr_b], b  ; *(int*)addr_b = b

;        3. Odczyt z sekcji danych niezainicjowanych

         push dword [addr_b]  ; *(int*)addr_b = b -> stack

         push format2         ; format2 -> stack

;        esp -> [format2][b][ret]

         call _printf  ; printf(format2, b);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

;        4. Odlozenie na stos stalej

c        equ 3

         push c        ; c -> stack

         push format3  ; format3 -> stack

;        esp -> [format3][c][ret]

         call _printf  ; printf(format3, c);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         push 0      ; esp -> [00 00 00 00][ret]
         call _exit  ; exit(0);

format   db "a = %d", 0xA, 0
format2  db "b = %d", 0xA, 0
format3  db "c = %d", 0xA, 0

%ifdef COMMENT
Kompilacja:

nasm process.asm -o process.o -f win32

ld process.o -o process.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm process.asm -o process.o -f win32

gcc process.o -o process.exe -m32
%endif