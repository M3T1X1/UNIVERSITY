         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

_01f0100 call _01f0107  ; push on the stack the return address _01f0105 and jump to _01f0107

_01f0105 nop  ; no operation

;        esp -> [ret]

_01f0106 ret  ; return to asmloader

_01f0107 nop  ; no operation

;        esp -> [_01f0105][ret]

_01f0108 ret  ; return to _01f0105

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