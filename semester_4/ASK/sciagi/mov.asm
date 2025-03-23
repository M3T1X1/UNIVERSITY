         [bits 32]

extern   _printf
extern   _exit

a        equ 1
b        equ 2
c        equ 3
d        equ 4

section  .data

addr_b   dd b  ; [02 00 00 00]  ; define double word
addr_c   dd c  ; [03 00 00 00]
addr_d   dd d  ; [04 00 00 00]

section  .text

global   _main

_main:

;        esp -> [ret]

;        1. Zaladowanie do rejestru eax stalej a

         mov eax, a ; eax = a = 1

;        2. Zaladowanie do rejestru ebp adresu addr_b

         mov ebp, addr_b  ; ebp = addr_b

;        3. Zaladowanie do rejestru ebx wartosci spod adresu z ebp

         mov ebx, [ebp]  ; ebx = *(int*)ebp = *(int*)addr_b = b = 2  ; [adresowanie posrednie]

;        4. Zaladowanie do rejestru ecx wartosci spod adresu addr_c

         mov ecx, [addr_c]  ; ecx = *(int*)addr_c = c = 3  ; [adresowanie posrednie]

;        5. Zaladowanie do rejestru esi wartosci rejestru eax

         mov esi, eax  ; esi = eax = 1

;        6. Zaladowanie do rejestru edx wartosci spod adresu ebp + edi*4 + 4

         mov edx, [ebp + esi*4 + 4]  ; edx = *(int*)(ebp + esi*4 + 4) =
                                     ;       *(int*)(addr_b + 1*4 + 4) = *(int*)addr_d = d = 3

;        [ Base_Reg + Index_Reg * Scale + Constant ]  Scale = 1,2,4,8

         push edx  ; edx -> stack
         push esi
         push ecx
         push ebx
         push ebp
         push eax
         
         push format

;        esp -> [format][eax][ebp][ebx][ecx][esi][edx][ret]

         call _printf  ; printf(format, eax, ebp, ebx, ecx, esi, edx);
         add esp, 7*4  ; esp = esp + 28

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);
         
format   db "eax = %d", 0xA
         db "ebp = %p", 0xA
         db "ebx = %d", 0xA
         db "ecx = %d", 0xA
         db "esi = %d", 0xA
         db "edx = %d", 0xA, 0

%ifdef COMMENT
Kompilacja:

nasm mov.asm -o mov.o -f win32

ld mov.o -o mov.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm mov.asm -o mov.o -f win32

gcc mov.o -o mov.exe -m32
%endif
