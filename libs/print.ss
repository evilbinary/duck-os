;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;打印一个字符
(define (print-char ch x y)
    ($asm
        (save reg0)
        (save reg5)
        (set reg5 #xb8000)
        (set reg0 (local 1)) ;;x
        (sar reg0 2) ;;cast to raw type
        (add reg0 reg5)
        (set reg5 reg0)

        (set reg0 (local 2)) ;;y
        (sar reg0 3) ;;cast to raw type
        (mul reg0 160)
        (add reg0 reg5)
        (set reg5 reg0)

        (set reg0 (local 0)) ;;ch
        (sar reg0 3);;cast to raw type
        (mset reg5 r0)
        (restore reg5)
        (restore reg0)
        ))

;;打印字符串
(define (print-string str)
        (let loop2 ([x 0] [len (string-length str)])
            (if (< x len)
                (begin
                    (print-char (+ #x4f00 (string-ref str x)) (+ x sx) sy )
                (loop2 (+ x 1) len )))
            )
        )



