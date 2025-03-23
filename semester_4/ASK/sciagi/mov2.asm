         [bits 32]

extern   _printf
extern   _exit

a        equ 1
b        equ 2
c        equ 3
d        equ 4
e        equ 5

section  .bss

addr_a   resd 1  ; [?? ?? ?? ??]  ; reserve 1 double word
addr_b   resd 1  ; [?? ?? ?? ??]
addr_c   resd 1  ; [?? ?? ?? ??]
addr_d   resd 1  ; [?? ?? ?? ??]
addr_e   resd 1  ; [?? ?? ?? ??]

section  .text

global   _main

_main:

;        esp -> [ret]

;        1. Zapisanie pod adresem addr_a stalej a typu int

         mov dword [addr_a], a  ; *(int*)(addr_a) = a = 1

;        2. Zapisanie pod adresem z rejestru ebx stalej b typu int

         mov ebx, addr_b     ; ebx = addr_b

         mov dword [ebx], b  ; *(int*)ebx = *(int*)addr_b = b = 2

;        3. Zapisanie pod adresem addr_c stalej c z rejestru ecx

         mov ecx, c         ; ecx = c = 3

         mov [addr_c], ecx  ; *(int*)addr_c = ecx = 3  ; <=> mov dword [addr_c], ecx
         
;        4. Zapisanie pod adresem z rejestru edx stalej z rejestru esi

         mov esi, d       ; esi = d = 4

         mov edx, addr_d  ; edx = addr_d

         mov [edx], esi   ; *(int*)edx = *(int*)addr_d = esi = d = 4  ; <=> mov dword [edx], esi

;        5. Zapisanie pod adresem ebx + edi*4 + 2*4 stalej e typu int

         mov edi, 1                        ; edi = 1
         mov dword [ebx + edi*4 + 2*4], e  ; *(int*)(ebx + edi*4 + 2*4) =
                                           ; *(int*)(addr_b + 1*4 + 2*4) = *(int*)addr_e = e = 5

;        [ Base_Reg + Index_Reg * Scale + Constant ]  Scale = 1,2,4,8

         push dword [addr_e]  ; *(int*)addr_e = e -> stack
         push dword [addr_d]  ; *(int*)addr_d = d -> stack
         push dword [addr_c]  ; *(int*)addr_c = c -> stack
         push dword [addr_b]  ; *(int*)addr_b = b -> stack
         push dword [addr_a]  ; *(int*)addr_a = a -> stack

;        esp -> [a][b][c][d][e][ret]

         push format

;        esp -> [format][a][b][c][d][e][ret]

         call _printf  ; printf(format, a, b, c, d, e);
         add esp, 6*4  ; esp = esp + 24

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);
         
format   db "a = %d", 0xA
         db "b = %d", 0xA
         db "c = %d", 0xA
         db "d = %d", 0xA
         db "e = %d", 0xA, 0

%ifdef COMMENT
Kompilacja:

nasm mov2.asm -o mov2.o -f win32

ld mov2.o -o mov2.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm mov2.asm -o mov2.o -f win32

gcc mov2.o -o mov2.exe -m32
%endif

