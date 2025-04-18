         [bits 32]

extern _printf
extern _scanf
extern _exit

global main

section .text

main:

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         push format

;        esp -> [format][ret]

         call _printf  ; printf(format);

;        esp -> [a][ret]  ; zmienna a, adres format nie jest juz potrzebny

         push esp  ; esp -> stack = addr_a

;        esp -> [addr_a][a][ret]

         push format2

;        esp -> [format2][addr_a][a][ret]

         call _scanf    ; scanf(format2, addr_a);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [a][ret]

         push format3

;        esp -> [format3][a][ret]

         call _printf   ; printf(format3, a);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         push 0     ; esp -> [00 00 00 00][ret]
         call _exit  ; exit(0);

format   db "a = ", 0
format2  db "%d", 0
format3  db "a = %d", 0xA, 0

%ifdef COMMENT
Kompilacja:

nasm process.asm -o process.o -f win32

ld process.o -o process.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm process.asm -o process.o -f win32

gcc process.o -o process.exe -m32
%endif
