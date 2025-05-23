         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader
 
%ifdef COMMENT
a   b      a+2b
|---|   |---|
1   1   2   3   5   8   13   wartosci
    |---|   |---|
    b  a+b    2a+3b

Przesuniecie ramki:

xadd (b, a) = (a+b, b) // wynik w rejestrze b

%endif
 
n        equ 6

         mov ebp, ebx  ; edp = ebx  ; store ebx
         mov ecx, n    ; ecx = n
 
         mov eax, 1  ; a = 1
         mov ebx, 1  ; b = 1
         mov edx, 2  ; d = 2

         test ecx, ecx  ; ecx & ecx     ; OF=0 SF ZF PF CF=0 affected
         jz zero        ; jump if zero  ; jump if ZF = 1

         sub ecx, 1  ; ecx = ecx - 1
         jz one      ; jump if zero  ; jump if ZF = 1

shift    xadd ebx, eax  ; (b, a) = (a+b, b) //wynik w rejestrze b

         loop shift

         jmp done
         
zero     push eax  ; eax -> stack

;        esp -> [eax][ret]

         jmp done
         
one      push ebx  ; ebx -> stack

;        esp -> [ebx][ret]

done:

         push ebx  ; ebx -> stack
         
;        esp -> [ebx][ret]
 
         call getaddr  ; push on the stack the run-time address of format and jump to getaddr
format:
         db "fibo = %d", 0xA, 0
getaddr:
 
;        esp -> [format][eax/ebx][ret]
 
         call [ebp+3*4]  ; printf(format, eax/ebx);
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
 
Tablica API
 
ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf
 
%endif