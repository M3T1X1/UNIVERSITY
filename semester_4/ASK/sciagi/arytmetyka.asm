         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        1. Negacja

         neg eax  ; eax = -eax

         neg dword [eax]  ; *(int*)eax = -*(int*)eax

;        neg r/m32  ; r/m32 = -r/m32  ; OF SF ZF AF PF CF affected

;        The CF flag set to 0 if the source operand is 0; otherwise it is set to 1. 
;        The OF, SF, ZF, AF, and PF flags are set according to the result.

;        2. Inkrementacja

         inc eax  ; eax++

         inc dword [eax]  ; (*(int*)eax)++

;        inc r/m32  ; OF SF ZF AF PF affected

;        3. Dekrementacja

         dec eax  ; eax--
         
         dec dword [eax]  ; (*(int*)eax)--
         
;        dec r/m32  ; OF SF ZF AF PF affected

;        4. Dodawanie

         add eax, ecx  ; eax = eax + ecx

         add [eax], ecx  ; *(int*)eax = *(int*)eax + ecx

;        add r/m32, r32  ; r/m32 = r/m32 + r32  ; OF SF ZF AF PF CF affected

;        The add instruction performs integer addition. It evaluates the result for both signed
;        and unsigned integer operands and sets the CF and OF flags to indicate a carry (overflow)
;        in the unsigned or signed result, respectively. The SF flag indicates the sign of the 
;        signed result.

;        5. Dodawanie z przeniesieniem

;        Zerowanie i ustawienie flagi CF

         clc  ; CF = 0  ; clear carry flag
         stc  ; CF = 1  ; set carry flag

         adc eax, ecx  ; eax = eax + ecx + CF

         adc [eax], ecx  ; *(int*)eax = *(int*)eax + ecx + CF

;        adc r/m32, r32  ; r/m32 = r/m32 + r32 + CF  ; OF SF ZF AF PF CF affected

;        6. Odejmowanie

         sub eax, ecx  ; eax = eax - ecx
         
         sub [eax], ecx  ; *(int*)eax = *(int*)eax - ecx

;        sub r/m32, r32  ; r/m32 = r/m32 - r32  ; OF SF ZF AF PF CF affected

;        The sub instruction performs integer subtraction. It evaluates the result for both signed
;        and unsigned integer operands and sets the OF and CF flags to indicate an overflow in the
;        signed or unsigned result, respectively. The SF flag indicates the sign of the signed
;        result.

;        7. Odejmowanie z pozyczka

;        Zerowanie i ustawienie flagi CF

         clc  ; CF = 0  ; clear carry flag
         stc  ; CF = 1  ; set carry flag

         sbb eax, ecx  ; eax = eax - ecx - CF

         sbb [eax], ecx  ; *(int*)eax = (*int*)eax - ecx - CF

;        sbb r/m32, r32  ; r/m32 = r/m32 - r32  ; OF SF ZF AF PF CF affected

;        8. Mnozenie bez znaku

         mul ecx  ; edx:eax = eax*ecx

         mul dword [ecx]  ; edx:eax = eax * (*(int*)ecx)

;        mul r/m32  ; edx:eax = eax*r/m32

;        The OF and CF flags are set to 0 if the upper half of the result is 0; 
;        otherwise, they are set to 1. The SF, ZF, AF, and PF flags are undefined.

;        9. Mnozenie ze znakiem

         imul ecx  ; edx:eax = eax*ecx
         
         imul dword [ecx]  ; edx:eax = eax * (*(int*)ecx)

;        imul r/m32  ; edx:eax = eax*r/m32

;        The CF and OF flags are set when significant bits are carried into the upper half of
;        the result and cleared when the result fits exactly in the lower half of the result.

         imul eax, ecx  ; eax = eax*ecx

         imul eax, [ecx]  ; eax = eax * (*(int*)ecx)

;        imul r32, r/m32  ; r32 = r32*r/m32

         imul eax, ecx, -1  ; eax = ecx*(-1)
         
         imul eax, [ecx], -1  ; eax = ecx * (*(int*)ecx) * (-1)

;        imul r32, r/m32, imm8  ; r32 = r/m32*imm8

;        The CF and OF flags are set when the result must be truncated to fit in the destination
;        operand size and cleared when the result fits exactly in the destination operand size.

;        10. Load Effective address

         lea eax, [eax + eax*2]  ; eax = eax*3

;        lea reg, [ Base_Reg + Index_Reg * Scale + Constant ]  Scale = 1,2,4,8

;        LEA instruction does not affect flags.

;        The LEA (load effective address) instruction computes the effective address in
;        memory (offset within a segment) of a source operand and places it in a
;        general-purpose register. This instruction can interpret any of the
;        processor's addressing modes and can perform any indexing or scaling that may
;        be needed. It is especially useful for initializing the ESI or EDI registers
;        before the execution of string instructions or for initializing the EBX
;        register before an XLAT instruction.

;        11. Dzielenie bez znaku liczby 64-bitowej edx:eax przez argument

         div ecx  ; eax = edx:eax / ecx  ; iloraz
                  ; edx = edx:eax % ecx  ; reszta

         div dword [ecx]  ; eax = edx:eax / *(int*)ecx  ; iloraz
                          ; edx = edx:eax % *(int*)ecx  ; reszta

;        div arg  ; eax = edx:eax / arg  ; iloraz
                  ; edx = edx:eax % arg  ; reszta

;        div r/m32  ; The CF, OF, SF, ZF, AF, and PF flags are undefined.

;        Non-integral results are truncated (chopped) towards 0.
;        The remainder is always less than the divisor in magnitude. 
;        Overflow is indicated with the #DE (divide error) exception rather than with the CF flag.

;        12. Dzielenie ze znakiem liczby 64-bitowej edx:eax przez argument

         idiv ecx  ; eax = edx:eax / ecx  ; iloraz
                   ; edx = edx:eax % ecx  ; reszta

         idiv dword [ecx]  ; eax = edx:eax / *(int*)ecx  ; iloraz
                           ; edx = edx:eax % *(int*)ecx  ; reszta

;        idiv arg  ; eax = edx:eax / arg  ; iloraz
                   ; edx = edx:eax % arg  ; reszta
                     
;        idiv r/m32  ; The CF, OF, SF, ZF, AF, and PF flags are undefined.

;        Non-integral results are truncated (chopped) towards 0. 
;        The remainder is always less than the divisor in magnitude. 
;        Overflow is indicated with the #DE (divide error) exception rather than with the CF flag.

         push 0          ; esp -> [0][ret]
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