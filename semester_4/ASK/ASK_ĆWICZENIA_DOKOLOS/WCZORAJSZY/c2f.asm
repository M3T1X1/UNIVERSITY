         [bits 32]

;        esp -> [ret] ; ret - adres powrotu do asmloader
;        F = C * 9/5 + 32
c        equ -5

         mov eax, c  ; eax = c
         
         push eax  ; stack -> eax

         call getaddr ; push on the stack the run-time address of format and jump to getaddr
format:
         db "C = %d", 0xA, 0

getaddr:

;        esp -> [format][ret]

         call [ebx+3*4] ; printf(format);
         add esp, 4     ; esp -> esp + 4

;        esp -> [ret]


         mov eax, c  ; eax = c

         imul eax, 9
         
         cdq

         mov ecx, 5

         idiv ecx
         
         add eax, 32
         
         push eax

         call getaddr2 ; push on the stack the run-time address of format and jump to getaddr
format2:
         db "F = %d", 0xA, 0

getaddr2:

;        esp -> [format2][ret]

         call [ebx+3*4] ; printf(format2);
         add esp, 4     ; esp -> esp + 4

;        esp -> [ret]

         push 0         ; esp -> [00 00 00 00][ret]
         call [ebx+0*4] ; exit(0);

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

; https://gynvael.coldwind.pl/?id=38
