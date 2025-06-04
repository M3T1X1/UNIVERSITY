         [bits 32]

;        esp -> [ret] ; ret - adres powrotu do asmloader

         call getaddr ; push on the stack the run-time address of format and jump to getaddr
format:
         db "a = ", 0
getaddr:

;        esp -> [format][ret]

         call [ebx+3*4] ; printf(format);

;        esp -> [ret]

         push esp

         call getaddr2; push on the stack the run-time address of format and jump to getaddr
format2:
         db "%d", 0
getaddr2:

;        esp -> [format][addr_a][ret]

         call [ebx+4*4] ; scanf(format);
         add esp, 2*4     ; esp -> esp + 4

;        esp -> [a][ret]
         
         pop eax
         
         cmp eax, 0

         jl ujemna

         call getaddr3; push on the stack the run-time address of format and jump to getaddr
format3:
         db "Podano liczbe dodatnia", 0xA, 0
getaddr3:

;        esp -> [format][ret]

         call [ebx+3*4] ; printf(format);
         add esp, 1*4     ; esp -> esp + 4

;        esp -> [ret]

         jmp koniec

ujemna:
         call getaddr4; push on the stack the run-time address of format and jump to getaddr
format4:
         db "Podano liczbe ujemna", 0xA, 0
getaddr4:

;        esp -> [format][ret]

         call [ebx+3*4] ; printf(format);
         add esp, 2*4     ; esp -> esp + 4

;        esp -> [ret]
koniec:
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
