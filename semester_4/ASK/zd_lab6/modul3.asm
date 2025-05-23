         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         call getaddr  ; push on the stack the run-time address of format and jump to getaddr
format:
         db "liczba = ",  0
getaddr:

;        esp -> [format][ret]

         call [ebx+3*4]  ; printf(format);

;        esp -> [liczba][ret]  ; zmienna liczba, adres format nie jest juz potrzebny

         push esp  ; esp -> stack = addr_liczba

;        esp -> [addr_liczba][liczba][ret]

         call getaddr2  ; push on the stack the run-time address of format2 and jump to getaddr2
format2:
         db "%d",  0
getaddr2:

;        esp -> [format2][addr_liczba][liczba][ret]

         call [ebx+4*4]  ; scanf(format2, addr_liczba);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [liczba][ret]

         mov eax, [esp]  ; eax = liczba
         mov ecx, eax    ; ecx = eax  ; modul

         add esp, 4  ; esp = esp + 4

;        esp -> [ret]

         test eax, eax  ; SF = 1 jeœli < 0, SF = 0 jeœli >= 0
         jns nieujemna  ; jump if not signed ; jump if SF = 1

         neg ecx  ; ecx = -ecx

nieujemna:

         push ecx  ; ecx -> stack

;        esp -> [ecx][ret]

         call getaddr3  ; push on the stack the run-time address of format3 and jump to getaddr3
format3:
         db "modul = %d", 0xA, 0
getaddr3:

;        esp -> [format3][ecx][ret]

         call [ebx+3*4]  ; printf(format3, ecx);
         add esp, 2*4    ; esp = esp + 8

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
