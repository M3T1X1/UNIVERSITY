         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 7

;        7!! = 7*5*3*1 = 105

         mov eax, 1  ; eax = 1
         mov ecx, n  ; ecx = n

         cmp ecx, 1  ; ecx - 1                 ; OF SF ZF AF PF CF affected
         jbe zero    ; jump if below or equal  ; jump if CF = 1 or ZF = 1

.loop    mul ecx  ; edx:eax = eax*ecx

         sub ecx, 2  ; ecx = ecx - 2

         cmp ecx, 1  ; ecx - 1                 ; OF SF ZF AF PF CF affected
         jbe zero    ; jump if below or equal  ; jump if CF = 1 or ZF = 1

         jmp .loop  ; jump always

zero     push eax  ; eax -> stack

;        esp -> [eax][ret]

         call getaddr  ; push on the stack the run-time address of format and jump to getaddr
format:
         db "podwojna silnia = %d", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf(format, eax);
         add esp, 2*4    ; esp = esp + 8

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
