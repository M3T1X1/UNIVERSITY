         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        f(x) = x - y^2 || float

x        equ __?float32?__(5.0)
y        equ __?float32?__(2.0)

;        1. Umiesc dane w pamieci procesu

         call getaddr  ; push on the stack the run-time address of addr_x and jump to getaddr



addr_x   dd x    ; [ ][ ][ ][ ]  ; define quad word
addr_y   dd y  ; [ ][ ][ ][ ]  ; addr_y = addr_x + 4
addr_y2  dd y  ; [ ][ ][ ][ ]  ; addr_y2 = addr_x + 8

getaddr:

;        esp -> [addr_x][ret]

;        2. Zaladuj dane z pamieci na stos FPU

         finit  ; fpu init

;        st = []  ; fpu stack

         mov ebp, [esp]  ; ebp = *(int*)esp = addr_x

         fld dword [ebp]    ; *(double*)(ebp+0) = *(double*)addr_x = x -> st = [x]     ; fpu load floating-point
         fld dword [ebp+4]  ; *(double*)(ebp+8) = *(double*)addr_y = y -> st = [y, x]  ;
         fld dword [ebp+8]  ; *(double*)(ebp+8) = *(double*)addr_y2 = y2 -> st = [y2, y, x]  ;

;        st = [st0, st1, st2] = [y2, y, x]

;        st0 -> y2
;        st1 -> y
;        st2 -> x

;        st0 -> x
;        st1 -> y

         fmulp st1
         fsubr st1


;        3. Wykonaj obliczenia przy pomocy FPU

;        fmulp st1  ; [st0, st1] => [st0, st1*st0] => [st1*st0]

;         fmulp st1  ; st1 = st1 * st0 and pop

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
         db "f(x, y) = %f", 0xA, 0
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
