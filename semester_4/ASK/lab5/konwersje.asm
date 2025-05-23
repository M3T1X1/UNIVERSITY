         [bits 64]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         cbw   ; ax = al    ; sign extension ; convert byte to word
         cwde  ; eax = ax   ; sign extension ; convert word to doubleword extended
         cdqe  ; rax = eax  ; sign extension ; convert doubleword to quadword extended

         cwd  ; dx:ax = ax     ; sign extension ; convert word to doubleword
         cdq  ; edx:eax = eax  ; sign extension ; convert doubleword to quadword
         cqo  ; rdx:rax = rax  ; sign extension ;

         movzx eax, al  ; eax = al  ; move and zero extend

         movsx eax, al  ; eax = al  ; move and sign extend

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

