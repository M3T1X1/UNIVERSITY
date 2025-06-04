;        work in progress

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        Stos koprocesora FPU

;        st = [st0, st1, st2, st3, st4, st5, st6, st7]  ; 8 rejestrow 80-bitowych

         finit  ; fpu init

;        st = []

;        Ladowanie stalych na stos FPU

         fldz    ; 0.0 -> st
         fld1    ; 1.0 -> st
         fldpi   ; PI -> st
         fldl2t  ; log2(10) -> st
         fldl2e  ; log2(E) -> st
         fldlg2  ; log10(2) -> st
         fldln2  ; ln(2) -> st
         
;        st = [ln(2), log10(2), log2(E), log2(10), PI, 1.0, 0.0]

;        Ladowanie danych na stos FPU

;        fld stn/m32fp/m64fp/m80fp  ; stn/m32fp/m64fp/m80fp -> st  ; fpu load floating-point

         fld st1          ; st1 -> st
         fld dword [esp]  ; *(float*)esp -> st
         fld qword [esp]  ; *(double*)esp -> st
         fld tword [esp]  ; *(__float80*)esp -> st

;        fild m16int/m32int/m64int  ; m16int/m32int/m64int -> st  ; fpu load integer

         fild word [esp]   ; *(short*)esp -> st
         fild dword [esp]  ; *(int*)esp -> st
         fild qword [esp]  ; *(long long*)esp -> st

;        Zapisanie danych ze stosu FPU

;        fst stn/m32fp/m64fp  ; stn/m32fp/m64fp = st0  ; fpu store floating-point value

         fst st1          ; st1 = st0
         fst dword [esp]  ; *(float*)esp = st0
         fst qword [esp]  ; *(double*)esp = st0
         
;        Zapisanie danych ze stosu FPU z zaokragleniem do liczby calkowitej

;        fist stn/m32fp/m64fp  ; stn/m32fp/m64fp <- st0 = Integer(st0)

         fist word [esp]   ; *(short*)esp = (short)st0 <- st
         fist dword [esp]  ; *(int*)esp = (int)st0 <- st
         fist qword [esp]  ; *(long long*)esp = (long long)st0 <- st

;        Pobieranie danych ze stosu FPU

;        fstp stn/m32fp/m64fp/m80fp  ; stn/m32fp/m64fp/m80fp <- st  ; fpu store floating-point value and pop

         fstp st1          ; st1 <- st = st0
         fstp dword [esp]  ; *(float*)esp <- st
         fstp qword [esp]  ; *(double*)esp <- st
         fstp tword [esp]  ; *(__float80*)esp <- st

;        Pobieranie danych ze stosu FPU z zaokragleniem do liczby calkowitej

;        fistp m16int/m32int/m64int  ; m16int = trunc(st0) <- st  ; fpu store integer with truncation and pop

         fistp word [esp]   ; *(short*)esp = (short)st0 <- st
         fistp dword [esp]  ; *(int*)esp = (int)st0 <- st
         fistp qword [esp]  ; *(long long*)esp = (long long)st0 <- st

;        Pobieranie danych ze stosu FPU z obcieciem do liczby calkowitej

;        fisttp m16int/m32int/m64int  ; m16int = trunc(st0) <- st  ; fpu store integer with truncation and pop

         fisttp word [esp]   ; *(short*)esp = (short)st0 <- st
         fisttp dword [esp]  ; *(int*)esp = (int)st0 <- st
         fisttp qword [esp]  ; *(long long*)esp = (long long)st0 <- st

;        Dodawanie liczb zmienno-pozycyjnych

;        fadd stn  ; st0 = st0 + stn
         fadd st1  ; st0 = st0 + st1

;        fadd stn, st0  ; stn = stn + st0
         fadd st1, st0  ; st1 = st1 + st0

;        fadd to stn  ; stn = stn + st0  ; alias do powyzszego
         fadd to st1  ; st1 = st1 + st0

;        faddp stn  ; stn = stn + st0 and pop
         faddp st1  ; st1 = st1 + st0 and pop
         
;        faddp stn, st0  ; stn = stn + st0 and pop  ; alias do powyzszego
         faddp st1, st0  ; st1 = st1 + st0 and pop
         
;        fadd m32fp/m64fp/m32int/m16int  ; st0 = st0 + m32fp/m64fp/m32int/m16int

         fadd dword [esp]   ; st0 = st0 + *(float*)esp
         fadd qword [esp]   ; st0 = st0 + *(double*)esp
         fiadd dword [esp]  ; st0 = st0 + *(int*)esp
         fiadd word [esp]   ; st0 = st0 + *(short*)esp

;        Odejmowanie liczb zmienno-pozycyjnych

;        fsub stn  ; st0 = st0 - stn
         fsub st1  ; st0 = st0 - st1

;        fsub stn, st0  ; stn = stn - st0
         fsub st1, st0  ; st1 = st1 - st0

;        fsub to stn  ; stn = stn - st0  ; alias do powyzszego
         fsub to st1  ; st1 = st1 - st0

;        fsubp stn  ; stn = stn - st0 and pop
         fsubp st1  ; st1 = st1 - st0 and pop
         
;        fsubp stn, st0  ; stn = stn - st0 and pop  ; alias do powyzszego
         fsubp st1, st0  ; st1 = st1 - st0 and pop
         
;        fsub m32fp/m64fp/m32int/m16int  ; st0 = st0 - m32fp/m64fp/m32int/m16int

         fsub dword [esp]   ; st0 = st0 - *(float*)esp
         fsub qword [esp]   ; st0 = st0 - *(double*)esp
         
;        fisub m32int/m16int  ; st0 = st0 - m32int/m16int

         fisub dword [esp]  ; st0 = st0 - *(int*)esp
         fisub word [esp]   ; st0 = st0 - *(short*)esp

;        Odejmowanie odwrotne liczb zmienno-pozycyjnych

;        fsubr stn  ; st0 = stn - st0
         fsubr st1  ; st0 = st1 - st0
         
;        fsubr stn, st0  ; stn = st0 - stn
         fsubr st1, st0  ; st1 = st0 - st1

;        fsubr to stn  ; stn = st0 - stn  ; alias do powyzszego
         fsubr to st1  ; st1 = st0 - st1
         
;        fsubrp stn  ; stn = st0 - stn and pop
         fsubrp st1  ; st1 = st0 - st1 and pop

;        fsubrp stn, st0  ; stn = st0 - stn and pop  ; alias do powyzszego
         fsubrp st1, st0  ; st1 = st0 - st1 and pop

;        fsubr m32fp/m64fp  ; st0 = m32fp/m64fp - st0

         fsubr dword [esp]  ; st0 = *(float*)esp - st0
         fsubr qword [esp]  ; st0 = *(double*)esp - st0

;        fisubr m32int/m16int  ; st0 = m32int/m16int - st0

         fisubr dword [esp]  ; st0 = *(int*)esp - st0
         fisubr word [esp]   ; st0 = *(short*)esp - st0

;        Mnozenie liczb zmienno-pozycyjnych

;        fmul stn  ; st0 = st0 * stn
         fmul st1  ; st0 = st0 * st1

;        fmul stn, st0  ; stn = stn * st0
         fmul st1, st0  ; st1 = st1 * st0

;        fmul to stn  ; stn = stn * st0  ; alias do powyzszego
         fmul to st1  ; st1 = st1 * st0

;        fmulp stn  ; stn = stn * st0 and pop
         fmulp st1  ; st1 = st1 * st0 and pop
         
;        fmulp stn, st0  ; stn = stn * st0 and pop  ; alias do powyzszego
         fmulp st1, st0  ; st1 = st1 * st0 and pop
         
;        fmul m32fp/m64fp/m32int/m16int  ; st0 = st0 * m32fp/m64fp/m32int/m16int

         fmul dword [esp]   ; st0 = st0 + *(float*)esp
         fmul qword [esp]   ; st0 = st0 + *(double*)esp
         fimul dword [esp]  ; st0 = st0 + *(int*)esp
         fimul word [esp]   ; st0 = st0 + *(short*)esp

;        Dzielenie liczb zmienno-pozycyjnych

;        fdiv stn  ; st0 = st0 : stn
         fdiv st1  ; st0 = st0 : st1

;        fdiv stn, st0  ; stn = stn : st0
         fdiv st1, st0  ; st1 = st1 : st0

;        fdiv to stn  ; stn = stn : st0  ; alias do powyzszego
         fdiv to st1  ; st1 = st1 : st0

;        fdivp stn  ; stn = stn : st0 and pop
         fdivp st1  ; st1 = st1 : st0 and pop

;        fdivp stn, st0  ; stn = stn : st0 and pop  ; alias do powyzszego
         fdivp st1, st0  ; st1 = st1 : st0 and pop

;        fdiv m32fp/m64fp/m32int/m16int  ; st0 = st0 : m32fp/m64fp/m32int/m16int

         fdiv dword [esp]   ; st0 = st0 : *(float*)esp
         fdiv qword [esp]   ; st0 = st0 : *(double*)esp

;        fidiv m32int/m16int  ; st0 = st0 : m32int/m16int

         fidiv dword [esp]  ; st0 = st0 : *(int*)esp
         fidiv word [esp]   ; st0 = st0 : *(short*)esp

;        Dzielenie odwrotne liczb zmienno-pozycyjnych

;        fdivr stn  ; st0 = stn : st0
         fdivr st1  ; st0 = st1 : st0
         
;        fdivr stn, st0  ; stn = st0 : stn
         fdivr st1, st0  ; st1 = st0 : st1

;        fdivr to stn  ; stn = st0 : stn  ; alias do powyzszego
         fdivr to st1  ; st1 = st0 : st1
         
;        fdivrp stn  ; stn = st0 : stn and pop
         fdivrp st1  ; st1 = st0 : st1 and pop

;        fdivrp stn, st0  ; stn = st0 : stn and pop  ; alias do powyzszego
         fdivrp st1, st0  ; st1 = st0 : st1 and pop

;        fdivr m32fp/m64fp  ; st0 = m32fp/m64fp : st0

         fdivr dword [esp]  ; st0 = *(float*)esp : st0
         fdivr qword [esp]  ; st0 = *(double*)esp : st0

;        fisubr m32int/m16int  ; st0 = m32int/m16int : st0

         fidivr dword [esp]  ; st0 = *(int*)esp : st0
         fidivr word [esp]   ; st0 = *(short*)esp : st0

;        Funkcje

         fabs  ; st0 = |st0|  ; wartosc bezwgledna

         fchs  ; st0 = -st0  ; zmiana znaku
         
         fsqrt  ; st0 = sqrt(0)  ; pierwiastek kwadratowy

         frndint  ; st0 = RoundToIntegralValue(st0)  ; zaokraglenie do liczby calkowitej

;        RC Field Setting

;        00 - round to nearest even         (Default Value)
;        01 - round down toward -infinity
;        10 - round up toward +infinity
;        11 - round towards zero (trancate)

         fyl2x  ; st1 = st1*log2(st0) and pop
         
         fyl2xp1  ; st1 = st1*log2(st0 + 1) and pop
         
         f2xm1  ; st0 = 2^st0 - 1  ; f2xm1 : [-1, 1] -> [-0.5, 1]

;        x^y = 2^(y*log2(x))

         fsin  ; st0 = sin(st0)

         fcos  ; st0 = cos(st0)

         fsincos  ; st0 = sin(st0), st1 = cos(st0)
         
         fptan  ; st0 = tg(st0)
         
         fpatan  ; st0 = arctg(st0)

;        Instrukcje porownan

         ftst  ; st0 - 0.0  ; C0 C1=0 C2 C3 affected  ; fpu test st0
         
;        C3 C2 C0
;        0  0  1   st0 < 0.0
;        1  0  0   st0 = 0.0
;        0  0  0   st0 > 0.0
;        1  1  1   Unordered

;        fcom stn/m32fp/m64fp  ; st0 - stn/m32fp/m64fp  ; C0 C1=0 C2 C3 affected  ; fpu compare real

;        C3 C2 C0
;        0  0  1   st0 < stn
;        1  0  0   st0 = stn
;        0  0  0   st0 > stn
;        1  1  1   Unordered

         fcom st1  ; st0 - st1  ; C0 C1=0 C2 C3 affected

;        fcomp stn/m32fp/m64fp  ; st0 - stn/m32fp/m64fp and pop  ; C0 C1=0 C2 C3 affected

         fcomp st1  ; st0 - st1 and pop  ; C0 C1=0 C2 C3 affected

         fcompp  ; st0 - st1 and pop twice  ; C0 C1=0 C2 C3 affected

;        fcomi stn  ; st0 - stn  ; C1=0 ZF PF CF affected

;        ZF PF CF
;        0  0  1   st0 < stn
;        1  0  0   st0 = stn
;        0  0  0   st0 > stn
;        1  1  1   Unordered

         fcomi st1  ; st0 - st1           ; C1=0 OF=SF=AF=0 ZF PF CF affected
         
;        fcomip stn  ; st0 - stn and pop  ; C1=0 OF=SF=AF=0 ZF PF CF affected

         fcomip st1  ; st0 - st1 and pop  ; C1=0 OF=SF=AF=0 ZF PF CF affected

;        Typ liczby

         fxam  ; examine floating-point

;        C3 C2 C0

;        0  0  0  -  Unsupported
;        0  0  1  -  NaN
;        0  1  0  -  Normal
;        0  1  1  -  Infinity
;        1  0  0  -  Zero
;        1  0  1  -  Empty
;        1  1  0  -  Denormal

;        C1 = sign bit of st0 (0 for positive, 1 for negative)

;        The C1 flag is set to the sign of the value in st0,
;        regardless of whether the register is empty or full.

;        Instrukcje kontrolne

         fclex   ; clear exceptions
         fnclex  ; clear exceptions  ; no wait

         fldcw word [esp]   ; fpu_control_word = *(short*)esp
         fstcw word [esp]   ; *(short*)esp = fpu_control_word
         fnstcw word [esp]  ; *(short*)esp = fpu_control_word  ; no wait



;        esp -> [ret]

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


%ifdef COMMENT

ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf

%endif
