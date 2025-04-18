         [bits 64]

extern   printf

global   main

section  .text

a        equ 4294967295
b        equ 1


;        before call   ; rsp % 16 == 0

main:  ; entry point

;        esp -> [ret]  ; rsp % 16 == 8

         mov eax, a     ; eax = a
         mov edx, b     ; edx = b
         add rax, rdx   ; rax = rax + rdx



         mov rcx, format  ; rcx = format
         mov rdx, rax     ; rdx = rax


         sub rsp, 40  ; allocate shadow space
         call printf  ; printf(format, a, b,);
         add rsp, 40  ; rsp = rsp + 32 + 8

         mov rax, 0  ; rax = 0  ; return value

         ret

format   db "a + b = %llu", 0xA,0


%ifdef COMMENT
Kompilacja:

nasm ms64call.asm -o ms64call.obj -f win64
golink /console /entry main ms64call.obj msvcrt.dll

lub

nasm add6.asm -o add6.o -f win64
gcc add6.o -o add6.exe -m64

%endif
