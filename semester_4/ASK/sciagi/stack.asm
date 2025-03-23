         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        1. Odlozenie zawartosci rejestru na stos CPU

         push eax  ; eax -> stack
         
;        esp -> [eax][ret]

;        2. Odlozenie stalej typu int na stos CPU

         push 1  ; 1 -> stack  ; <=> push dword 1

;        esp -> [01 00 00 00][eax][ret]

;        3. Odlozenie zawartosci pamieci na stos CPU

         push dword [esp]  ; *(int*)esp -> stack = 1

;        esp -> [01 00 00 00][01 00 00 00][eax][ret]

;        4. Podniesienie do rejestru elementu ze stosu CPU

         pop ecx  ; ecx <- stack = 1

;        esp -> [01 00 00 00][eax][ret]

;        5. Odczytanie do rejestru wierzcholka stosu CPU

         mov eax, [esp]  ; eax = *(int*)esp = 1  ; peek

;        6. Zapisanie zawartosci rejestru na szczyt stosu CPU

         mov [esp], eax  ; *(int*)esp = eax = 1  ; poke

;        esp -> [01 00 00 00][eax][ret]

;        7. Zapisanie stalej typu int na szczyt stosu CPU

         mov dword [esp], 2  ; *(int*)esp = 2  ; poke

;        esp -> [02 00 00 00][eax][ret]

;        8. Przesuniecie wskaznika szczytu stosu w prawo

         add esp, 4  ; esp = esp + 4

;        esp -> [eax][ret]

;        9. Przesuniecie wskaznika szczytu stosu w lewo

         sub esp, 4  ; esp = esp - 4

;        esp -> [02 00 00 00][eax][ret]

;        10. Odlozenie stalej typu short na stos CPU

         push word 0x0000  ; 0x0000 -> stack  ; stack = 00 00
         push word 0x0003  ; 0x0003 -> stack  ; stack = 03 00 00 00  ; esp = 4*k

;        esp -> [03 00 00 00][02 00 00 00][eax][ret]

         add esp, 3*4  ; esp = esp + 12

;        esp -> [ret]

         ret  ; return to asmloadder

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
