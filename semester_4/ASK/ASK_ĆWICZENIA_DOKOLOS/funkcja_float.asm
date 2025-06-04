         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        f(x, y) = x - y

x        equ __?float32?__(5.0)
y        equ __?float32?__(1.5)

;        1. Umiesc dane w pamieci procesu

         call getaddr  ; push on the stack the run-time address of addr_x and jump to getaddr

addr_x   dd x    ; [ ][ ][ ][ ]  ; define quad word
addr_y   dd y    ; [ ][ ][ ][ ]  ; addr_y = addr_y + 4

getaddr:

;        esp -> [addr_x][ret]

;        2. Zaladuj dane z pamieci na stos FPU

         finit  ; fpu init

;        st = []  ; fpu stack

         mov ebp, [esp]  ; ebp = *(int*)esp = addr_x

         fld dword [ebp]    ; *(float*)(ebp+0) = *(float*)addr_x = x -> st = [x]     ; fpu load floating-point
         fld dword [ebp+4]    ; *(float*)(ebp+4) = *(float*)addr_y = y -> st = [y, x]  ;

;        st = [st0, st1] = [y, x]

;        3. Wykonaj obliczenia przy pomocy FPU

;        fmulp st1  ; [st0, st1] => [st0, st1-st0] => [st1-st0]

         fsubp st1, st0  ; st1 = st1 - st0 and pop

;        st = [st0] = [5*x]

;        Robimy miejsce na wartosc typu float

         sub esp, 4  ; esp = esp - 4

;        esp -> [ ][ ][ret]  ; addr_x nie jest juz potrzebny

;        4. Zapisz dane ze stosu FPU do pamieci

         fstp qword [esp]  ; *(float*)esp <- st = y - x  ; fpu store floating-point value and pop

;        st = []

;        esp -> [f][ret]

         call getaddr2  ; push on the stack the run-time address of format and jump to getaddr2
format:
         db "f(x) = %f", 0xA, 0
getaddr2:

;        esp -> [format][f][ret]

         call [ebx+3*4]  ; printf(format, f);
         add esp, 2*4    ; esp = esp + 12

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
