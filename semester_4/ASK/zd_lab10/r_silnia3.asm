%ifdef COMMENT
n! = 1 * 2 * ... * n

0! = 1
n! = n*(n-1)

silnia(0) = 1
silnia(1) = 1
silnia(2) = 2
silnia(3) = 6
silnia(4) = 24
%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 3

         mov ecx, n  ; ecx = n

         call silniap   ; eax = suma(ecx) ; fastcall
raddr:

;        esp -> [ret]

         push eax

;        esp -> [eax][ret]

         call getaddr  ; push on the stack the run-time address of format and jump to getaddr
format:
         db "silnia = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf("suma = %i\n", eax);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

;        eax silnia(ecx)

silnia  mov eax, 1  ; eax = 1

;        silnia(ecx)

silnia_  cmp ecx, 1    ; ecx - 1            ; ZF affected
         jbe exit_     ; jump if below or equal ; jump if CF = 1 or ZF = 1
         jmp rec_

rec_     mul ecx        ; eax = eax * n
         dec ecx        ; ecx = ecx - 1 = n-1
         call silniap_  ; silniap_(n-1)

exit_    ret

;        silnia(0) = 0
;        silnia(n) = n * silnia(n-1)

%ifdef COMMENT
eax = silnia(ecx)

;        esp -> [raddr][ret]

* silniap(2):
  eax = 1
  ecx = 2

* silniap_(2):
  ecx > 1
  eax = eax * ecx = 1*2 = 2
  ecx = ecx - 1 = 0
  silniap_(0)


* silniap_(0):
  ecx = 1
  return eax = 2

* rrec_:
  return eax = 2

;        esp -> [ret]



%endif

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

