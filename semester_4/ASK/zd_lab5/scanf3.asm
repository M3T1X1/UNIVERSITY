         [bits 32]

extern _printf
extern _scanf
extern _exit

global _main

section .bss

addr_a   resd 1  ; [ ][ ][ ][ ]  ; reserve double word 1 time 

section .text

_main:

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         push format  ; format -> stack

;        esp -> [format][ret]

         call _printf  ; _printf(format);
        
         add esp, 4  ; esp = esp + 4

;        esp -> [ret]

         push addr_a  ; addr_a -> stack

;        esp -> [addr_a][ret]

         push format2  ; format2 -> stack

;        esp -> [format2][addr_a][ret]

         call _scanf    ; _scanf(format2, addr_a);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         push dword [addr_a]  ; *(int*)addr_a = a -> stack

;        esp -> [a][ret]

         push format3  ; format3 -> stack

;        esp -> [format3][a][ret]

         call _printf   ; _printf(format3, a);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         push 0     ; esp -> [00 00 00 00][ret]
         call _exit  ; _exit(0);

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
