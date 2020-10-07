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

(define cursor-y 0)
(define cursor-x 0)

;;打印字符串
(define (print-string str)
        (let loop2 ([x 0] [len (string-length str)])
            (if (< x len)
                (begin
                    (print-char (+ #x4f00 (string-ref str x)) (+ x cursor-x) cursor-y )
                (loop2 (+ x 1) len )))
            )
        )

(define (print-string-len str l)
        (let print-string-len-loop ([x 0] [len l])
            (if (< x len)
                (begin
                    (print-char (+ #x4f00 (string-ref str x)) (+ x cursor-x) cursor-y )
                (print-string-len-loop (+ x 1) len )))
            )
        )

;;打印十六进制
(define (print-hex val x y)
    (print-base val 16 x y))

(define (print-base val base)
    (let print-loop ([i 30] [v val] [buf "0000000000000000000000000000000000"]) 
        (if (and (> i 0) (> val 0))
            (begin 
                (string-set! buf i (string-ref "0123456789abcdef" (mod v base) ))
                (print-loop (- i 1) (/ v base) buf)
            )
            (print-string-len buf 31)
            )))

