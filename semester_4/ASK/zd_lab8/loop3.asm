         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 0

         push dword n  ; n -> stack

.loop    push dword [esp]  ; esp -> stack

;        esp -> [n][n][ret]

         call getaddr  ; push on the stack the run-time address of format and jump to getaddr
format:
         db "i = %u", 0xA, 0
getaddr:

;        esp -> [format][n][n][ret]

         call [ebx+3*4]  ; printf(format, n);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [n][ret]

         dec dword [esp]  ; [esp]--           ; OF SF ZF AF PF affected

         cmp dword [esp], 0  ; [esp] - 0         ; OF SF ZF AF PF CF affected
         jnz .loop     ; jump if not zero  ; jump if ZF = 0

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
