;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;mem set value 4byte
(define (mem-set addr value)
    ($asm 
        (set reg0 (local 0))
        (set reg1 (local 1))
        (sar reg0 3)
        (sar reg1 3)
        (mset reg0 reg1)))

;;mem get value
(define (mem-ref addr)
    ($asm
        (set reg0 (local 0))
        (sar reg0 3)
        (mref reg0 reg0)
        (sal reg0 3)
        (add reg0 #b000)
        ))
