;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(library (arch arch)
  (export 
    ;;regs
    reg0 reg1 reg2 reg3 reg4 reg5 reg6 reg7 regs regs-map
    ;;instruct
    asm set mref mset note
    add label sar sal mul sub div
    shl shr ret
    call jmp cmp-jmp cmp
    land lor xor save restore
    nop local proc lproc lret pret
    fcall ccall
    stext sexit 
    data sdata
    asm-compile-exp
    arch-bits
  )

(import
    (common common)
    (common match)
    (common trace)
    (arch x86-os)
    )
)