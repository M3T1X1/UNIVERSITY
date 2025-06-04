         [bits 32]

;        esp -> [ret] ; ret - adres powrotu do asmloader
;        exp = a*3 + b*7
;            = 2 * 3 + 3 * 7 = 6 + 21 = 27

a        equ 2
b        equ 3

         mov eax, a  ; eax = a
         mov ecx, b  ; ecx = b
         
         imul eax, 3  ; eax = eax * 3
         imul ecx, 7  ; ecx = ecx * 7

         add eax, ecx  ; eax = eax + ecx

         push eax  ; eax -> stack

         call getaddr ; push on the stack the run-time address of format and jump to getaddr
format:
         db "exp = a * 3 + b * 7 = %d", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4] ; printf(format);
         add esp, 2*4     ; esp -> esp + 8

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
