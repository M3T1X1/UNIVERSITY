%ifdef COMMENT
n!! = 1 * 2 * ... * n

0!! = 1
n!! = n*(n-2)

silnia(0) = 1
silnia(1) = 1
silnia(2) = 2
silnia(3) = 3
silnia(4) = 8

%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 4

         mov ecx, n  ; edx = n

         call silniap  ; eax = silnia(edx) ; fastcall

addr:

;        esp -> [ret]

         push eax

;        esp -> [eax][ret]

         call getaddr
format:
         db "silniap = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf("silnia = %i\n", eax);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

;        eax silnia(ecx)

silniap:
         cmp ecx, 1    ; ecx  = ecx - 1
         jbe base      ; jump if below or equal ; jump if ZF = 1

         push ecx      ; ecx -> stack = n
         sub ecx, 2    ; ecx = ecx - 2 = n - 2
         call silniap  ; eax = silniap(ecx) = silniap(n - 2)
         pop ecx       ; ecx <- stack = n
         mul ecx       ; edx:eax = eax*ecx = silnia(n - 2) * n
         ret
         
base:
         mov eax, 1
         ret

; 0! = 1
; n! = n*(n-1)

%ifdef COMMENT
eax = silnia(ecx)

 silnia(2) =            * silnia(2) = 2
  ecx -> stack = 2         ecx -> stack = 2
  ecx = ecx - 1 = 1        ecx = ecx - 1 = 1
  eax = silnia(1) =        eax = silnia(1) = 1
  ecx <- stack = 2         ecx <- stack = 2
  eax = eax*ecx =          eax = eax*ecx = 1*2 = 2
  return eax = 2           return eax = 2

* silnia(1) =            * silnia(1) = 1
  ecx -> stack = 1         ecx -> stack = 1
  ecx = ecx - 1 = 0        ecx = ecx - 1 = 0
  eax = silnia(0) =        eax = silnia(0) = 1
  ecx <- stack = 1         ecx <- stack = 1
  eax = eax*ecx =          eax = eax*ecx = 1*1 = 1
  return eax = 1           return eax = 1

* silnia(0) =            * silnia(0) = 1
  eax = 1                  eax = 1
  return eax = 1           return eax = 1
  

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
