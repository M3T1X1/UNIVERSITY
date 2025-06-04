         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 2
b        equ 2
c        equ 3

         mov eax, a
         mov edx, b
         mov ecx, c

         push ecx
         push edx
         push eax

;        esp -> [eax][edx][ecx][ret]

         call getaddr  ; push on the stack the run-time address of format and jump to getaddr
format:
         db "a = %d", 0xA,
         db "b = %d", 0xA,
         db "c = %d", 0xA, 0
getaddr:

;        esp -> [eax][edx][ecx][format][ret]

         call [ebx+3*4]  ; printf(format);
         add esp, 4*4      ; esp = esp + 16
         
         mov eax, a
         mov edx, b
         mov ecx, c

         push ecx
         push edx
         push eax

;        esp -> [eax][edx][ecx][ret]

         add eax, edx
         cmp eax, ecx

         je rowny

nierowny:
         sub eax, edx
         call getaddr2  ; push on the stack the run-time address of format and jump to getaddr
format2:

         db "%d + %d != %d", 0xA, 0
getaddr2:

;        esp -> [format][eax][edx][ecx][ret]

         call [ebx+3*4]  ; printf(format);
         add esp, 4*4      ; esp = esp + 16
         
         jmp koniec

rowny:
         sub eax, edx
         call getaddr3  ; push on the stack the run-time address of format and jump to getaddr
format3:
         db "%d + %d = %d", 0xA, 0
getaddr3:

;        esp -> [format][ret]

         call [ebx+3*4]  ; printf(format);
         add esp, 4*4      ; esp = esp + 4
         


koniec:
;        esp -> [ret]

         push 0          ; esp -> [00 00 00 00][ret]
         call [ebx+0*4]  ; exit(0);

; asmloader API
;
; ESP wskazuje na prawidlowy stos
; argumenty funkcji wrzucamy na stos
; EBX zawiera pointer na tablice API
;
; call [ebx + NR_FUNKCJI*4] ; wywolanie funkcji API
;
; NR_FUNKCJI:
;
; 0 - exit
; 1 - putchar
; 2 - getchar
; 3 - printf
; 4 - scanf
;
; To co funkcja zwróci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387

%ifdef COMMENT

ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf

%endif
