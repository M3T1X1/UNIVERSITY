         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        f(x) = x + y^2
;             = 3 + 4 = 7


x        equ __?float64?__(3.0)
y        equ __?float64?__(2.0)

;        1. Umiesc dane w pamieci procesu

         call getaddr  ; push on the stack the run-time address of addr_x and jump to getaddr

addr_x   dq x    ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; define quad word
addr_y   dq y    ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; addr_y = addr_x + 8
addr_y2  dq y   ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; addr_y2 = addr_y + 16

getaddr:

;        esp -> [addr_x][ret]

;        2. Zaladuj dane z pamieci na stos FPU

         finit  ; fpu init

;        st = []  ; fpu stack

         mov ebp, [esp]  ; ebp = *(int*)esp = addr_x

         fld qword [ebp]    ; *(double*)(ebp+0) = *(double*)addr_x = x -> st = [x]     ; fpu load floating-point
         fld qword [ebp+8]  ; *(double*)(ebp+8) = *(double*)addr_y = y -> st = [y, x]  ;
         fld qword [ebp+16] ; *(double*)(ebp+16) = *(double*)addr_y2 = y2 -> st = [y2, y, x]  ;

;        st = [st0, st1, st2] = [y2, y, x]

;        3. Wykonaj obliczenia przy pomocy FPU

;        fmulp st1  ; [st0, st1] => [st0, st1*st0] => [st1*st0]

;        st0 -> y2
;        st1 -> y
;        st2 -> x

;        po fmulp

;        st0 -> x
;        st1 -> y


         fmulp st1  ; st1 = st1 * st0 and pop || y = y * y2
         faddp st1  ; st1 = st1 + st0 and pop


;        st = [st0] = [5*x]

;        Robimy miejsce na wartosc typu double

         sub esp, 4  ; esp = esp - 4
         
;        esp -> [ ][ ][ret]  ; addr_x nie jest juz potrzebny

;        4. Zapisz dane ze stosu FPU do pamieci

         fstp qword [esp]  ; *(double*)esp <- st = 5*x  ; fpu store floating-point value and pop

;        st = []

;        esp -> [fl][fh][ret]

         call getaddr2  ; push on the stack the run-time address of format and jump to getaddr2
format:
         db "f(x) = %f", 0xA, 0
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
