         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        f(a,b,c,d) = a*b + d*c = 4*5 + 6*3 = 38

a        equ __?float64?__(4.0)
b        equ __?float64?__(5.0)
c        equ __?float64?__(6.0)
d        equ __?float64?__(3.0)

;        1. Umiesc dane w pamieci procesu

         call getaddr  ; push on the stack the run-time address of addr_a and jump to getaddr

addr_a   dq a  ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; define quad word
addr_b   dq b  ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; addr_b = addr_a + 8
addr_c   dq c  ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; addr_c = addr_a + 16
addr_d   dq d  ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; addr_d = addr_a + 24

getaddr:

;        esp -> [addr_x][ret]

;        2. Zaladuj dane z pamieci na stos FPU

         finit  ; fpu init

;        st = []  ; fpu stack

         mov ebp, [esp]  ; ebp = *(int*)esp = addr_a

         fld qword [ebp]     ; *(double*)(ebp+0)  = *(double*)addr_a = a -> st = a  ; fpu load floating-point
         fld qword [ebp+8]   ; *(double*)(ebp+8)  = *(double*)addr_b = b -> st = b  ;
         
;        3. Wykonaj obliczenia przy pomocy FPU

         fmulp st1  ; st1 = st1 * st0 and pop
         
;        st = [st0, st1] = [a*b]

         fld qword [ebp+16]  ; *(double*)(ebp+16) = *(double*)addr_c = c -> st = c  ;
         fld qword [ebp+24]  ; *(double*)(ebp+24) = *(double*)addr_d = d -> st = d  ;

;        st = [st0, st1, st2] = [d, c, a*b]

         fmulp st1  ; st1 = st1 * st0 and pop
         
;        st = [st0, st1] = [d*c, b*a]

         faddp st1  ; st1 = st1 + st0 and pop
         
;        st = [st0] = [a*b + c*d]

;        Robimy miejsce na wartosc typu double

         sub esp, 4  ; esp = esp - 4
         
;        esp -> [ ][ ][ret]  ; addr_a nie jest juz potrzebny

;        4. Zapisz dane ze stosu FPU do pamieci

         fstp qword [esp]  ; *(double*)esp <- st = a*b + d*c  ; fpu store floating-point value and pop

;        st = []

;        esp -> [fl][fh][ret]

         call getaddr2  ; push on the stack the run-time address of format and jump to getaddr2
format:
         db "f(a, b, c, d) = %f", 0xA, 0
getaddr2:

;        esp -> [format][fl][fh][ret]

         call [ebx+3*4]  ; printf(format, f);
         add esp, 3*4    ; esp = esp + 12

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
