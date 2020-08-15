;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(library (x86-os)
  (export 
    reg0 reg1 reg2 reg3 reg4 reg5 reg6 reg7 regs regs-map

    asm set mref mset note
    add label sar sal mul sub div
    shl shr ret
    call jmp cmp-jmp cmp
    land xor save restore
    nop local proc

    fcall ccall
    stext sexit
    asm-compile-exp
    data sdata
    arch-bits
    
  )

(import 
    (rename (scheme) (div div2) )
    (common)
    (trace)
    (type)
    (options)
    (rename (x86) (stext $stext)
        (sexit $sexit)
        (asm-compile-exp $asm-comile-exp)
        )
    )

(define (stext)
  (if need-boot
    (asm "org 7c00h")
  )
  (asm "_start:")

)

(define (sexit code)
  (asm "ret")
)

(define (asm-compile-exp exp name)
  (let ((asm (format "`which  nasm` ~a.s -o ~a.o" name name)))
      ;;(printf "~a\n" asm)
      (system asm)
  )
)



)