;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;bit opts
(define (bit-shift-left x bit)
    ($asm 
            (set reg0 (local 0))
            (set reg1 (local 1))
            (sar reg0 3);;cast to raw type
            (sar reg1 3)
            (sal reg0 reg1)
            (sal reg0 3)
            (add reg0 #b000)
        )
)

(define (bit-shift-right x bit)
    ($asm 
        (set reg0 (local 0))
        (set reg1 (local 1))
        (sar reg0 3);;cast to raw type
        (sar reg1 3)
        (sar reg0 reg1)
        (sal reg0 3)
        (add reg0 #b000)
        )
)

(define (bit-and x y)
    ($asm 
        (set reg0 (local 0))
        (set reg1 (local 1))
        (sar reg0 3);;cast to raw type
        (sar reg1 3)
        (land reg0 reg1)
        (sal reg0 3)
        (add reg0 #b000)
        )
)

(define (bit-or x y)
    ($asm 
        (set reg0 (local 0))
        (set reg1 (local 1))
        (sar reg0 3);;cast to raw type
        (sar reg1 3)
        (lor reg0 reg1)
        (sal reg0 3)
        (add reg0 #b000)
        )
)