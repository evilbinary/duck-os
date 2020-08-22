;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

($asm 
    (asm "org 0x1000")
    (asm "bits 32"))

(define a 1)
(- a 30)
(+ 111 2)

(define (print-ch ch)
    ($asm
        (call print-char #x4f62))
)
;;(print-ch #x4f #x62)

($asm
    (label halt)
    (jmp halt)

    ;;打印一个字符
    (proc print-char)
    (set reg0 (local 0))
    (set reg5 #xb8000)
    (mset reg5 r0)
    (ret)
)
   


