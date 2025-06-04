         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 3
b        equ __?float32?__(3.141592)
c        equ __?float64?__(3.141592653589793)

         call getaddr  ; push on the stack the run-time address of addr_a and jump to getaddr

addr_a   dd a  ; [ ][ ][ ][ ]              ; define double word
addr_b   dd b  ; [ ][ ][ ][ ]              ; define double word  ; addr_b = addr_a + 4
addr_c   dq c  ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; define quad word    ; addr_c = addr_a + 8

getaddr:

;        esp -> [addr_a][ret]

         mov ebp, [esp]  ; ebp = *(int*)esp = addr_a

         finit  ; fpu init

;        st = []  ; fpu stack

;        1. Zaladowanie na stos FPU stalej

         fldpi  ; fpu load pi

;        st = [st0] = [pi]

;        2. Zaladowanie na stos FPU elementu ze stosu FPU

         fld st0  ; st0 -> st

;        st = [st0, st1] = [pi, pi]

;        3. Zaladowanie na stos FPU liczby calkowitej typu int

         fild dword [ebp]  ; *(int*)ebp = *(int*)addr_a = a -> st  ; fpu load integer

;        st = [st0, st1, st2] = [a, pi, pi]

;        4. Zaladowanie na stos FPU liczby zmiennopozycyjnej typu float

         fld dword [ebp+4]  ; *(float*)(ebp+4) = *(float*)addr_b = b -> st  ; fpu load floating-point

;        st = [st0, st1, st2, st3] = [b, a, pi, pi]

;        5. Zaladowanie na stos FPU liczby zmiennopozycyjnej typu double

         fld qword [ebp+8]  ; *(double*)(ebp+8) = *(double*)addr_c = c -> st  ; fpu load integer

;        st = [st0, st1, st2, st3, st4] = [c, b, a, pi, pi]

;        Robimy miejsce na wartosci typu double b, c, pi

         sub esp, 3*8  ; esp = esp + 24

;                  +4    +12   +20
;        esp -> [a][b][ ][c][ ][pi][ ][ret]  ; adres addr_a nie jest juz potrzebny

;        6. Sciagniecie ze stosu FPU do pamieci wartosci typu double

         fstp qword [esp+12]  ; *(double*)(esp+12) <- st = c  ; fpu store floating-point value and pop

;        st = [st0, st1, st2, st3] = [b, a, pi, pi]

         fstp qword [esp+4]  ; *(double*)(esp+4) <- st = b  ; fpu store floating-point value and pop

;        st = [st0, st1, st2] = [a, pi, pi]

;        7. Sciagniecie ze stosu FPU do pamieci wartosci typu int

         fistp dword [esp]  ; *(int*)esp <- st = a  ; fpu store integer value and pop

;        st = [st0, st1] = [pi, pi]

;        Sciagniecie ze stosu FPU do pamieci wartosci typu double

         fstp qword [esp+20]  ; *(double*)(esp+20) <- st = pi  ; fpu store floating-point value and pop

;        st = [st0] = [pi]

;        8. Zapisanie ze stosu FPU do pamieci wartosci typu double

         fst qword [esp+20]  ; *(double*)(esp+20) = st0 = pi  ; fpu store floating-point value

;        st = [st0] = [pi]

         call getaddr2  ; push on the stack the run-time address of format2 and jump to getaddr2
format2:
         db "a  = %d", 0xA
         db "b  = %.15f", 0xA
         db "c  = %.15f", 0xA
         db "pi = %.15f", 0xA, 0
getaddr2:

;        esp -> [format2][a][b][ ][c][ ][pi][ ][ret]

         call [ebx+3*4]  ; printf(format2, a, b, c, pi);
         add esp, 8*4    ; esp = esp + 32

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
