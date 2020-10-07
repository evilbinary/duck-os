;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;字符串长度
(define (string-length str)
    (let loop3 ([x 0])
        (if (= (string-ref str x) 0)
            x
            (loop3 (+ x 1) ))
        )
)

;;字符串获取
(define (string-ref str i)
        ($asm 
            (set reg0 (local 0))
            (set reg1 (local 1))
            (sar reg0 3);;cast to raw type
            (sar reg1 3)
            (+ reg0 reg1)
            (mref reg0 reg0)
            (land reg0 #xff)
            (sal reg0 3)
            (add reg0 #b000)
        )
      )

;;字符串设置
(define (string-set! str i val)
        ($asm 
            (set reg0 (local 0))
            (set reg1 (local 1))
            (sar reg0 3);;cast to raw type
            (sar reg1 3)
            (+ reg0 reg1)
            (set reg1 (local 2))
            (sar reg1 3)
            (mset reg0 reg1 byte)
        )
      )