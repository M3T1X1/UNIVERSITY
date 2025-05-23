         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

%ifdef COMMENT
0   1   2   3   4   5   6    indeksy

a   b
|---|
1   1   2   3   5   8   13   wartosci
|   |---|
d   a   b

Przesuniecie ramki:

d = a              ; d = 1
a = b              ; a = 1
b = a + d = b + d  ; b = 1 + 1 = 2
%endif

n        equ 4

         mov ebp, ebx  ; ebp = ebx  ; store ebx
         
         mov ecx, n  ; ecx = n

         mov eax, 1  ; a = 1
         mov ebx, 1  ; b = 1

         cmp ecx, 0  ; ecx - 0            ; OF SF ZF AF PF CF affected
         jne next1   ; jump if not equal  ; jump if eax != ecx ; jump if ZF = 0

         push eax  ; eax -> stack

;        esp -> [eax][ret]

         jmp done
         
next1    cmp ecx, 1  ; ecx - 1            ; OF SF ZF AF PF CF affected
         jne next2   ; jump if not equal  ; jump if eax != ecx ; jump if ZF = 0

         push ebx  ; ebx -> stack

;        esp -> [ebx][ret]

         jmp done
         
next2    cmp ecx, 2  ; ecx - 2            ; OF SF ZF AF PF CF affected
         jne next3   ; jump if not equal  ; jump if eax != ecx ; jump if ZF = 0

         push edx  ; edx -> stack

;        esp -> [edx][ret]

         jmp done

next3    sub ecx, 2  ; ecx = ecx - 2

shift    mov eax, ebx  ; a = b
         mov ebx, edx  ; b = d
         add eax, ebx  ; a = a + b
         mov edx, eax  ; d = a + b

         loop shift

         push edx  ; edx -> stack

;        esp -> [edx][ret]

done:

         call getaddr  ; push on the stack the run-time address of format and jump to getaddr
format:
         db "fibo = %d", 0xA, 0
getaddr:

;        esp -> [format][eax/ebx/edx][ret]

         call [ebp+3*4]  ; printf(format, eax/ebx/edx);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [00 00 00 00][ret]
         call [ebp+0*4]  ; exit(0);

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
