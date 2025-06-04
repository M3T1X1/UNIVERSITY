         [bits 32]

;        esp -> [ret] ; ret - adres powrotu do asmloader

;        f(x,y) = x - y

;        W tym zadaniu musimy robiæ na floatach wiêc dd



x        equ __?float32?__(2.0)
y        equ __?float32?__(1.5)

         call getaddr  ; push on the stack the run-time address of addr_x and jump to getaddr

;        dd -> float/int || dq -> double

addr_y   dd y  ;[][][][]  define double word
addr_x   dd x  ;[][][][]  define double word


getaddr:
;       esp -> [addr_a][ret]

        finit

        mov ebp, [esp]  ; -> addr_x

;       poni¿ej jak mamy robiæ na double to zamiast dword robimy qword i zamiat ebp+4 dajemy ebp+8

        fld dword [ebp]   ; *(float*)(ebp+0) = *(float*)addr_x = x -> st = [x]
        fld dword [ebp+4] ; *(float*)(ebp+4) = *(float*)addr_y = y -> st = [y,x]

;       st -> [st0, st1] -> [y, x]

        fsubp st1  ; st0 = st1 - st0 = y = x - y

        sub esp, 4  ; esp - 4

        fstp dword [esp]  ; ; *(float*)esp <- st = x - y  ; fpu store floating-point value and pop

;        st = []

;        esp -> [fl][fh][ret]

        call getaddr2 ; push on the stack the run-time address of format and jump to getaddr
format2:
         db "f(x,y) = %lf", 0xA, 0
getaddr2:
;        esp -> [format][st0][][ret]

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
