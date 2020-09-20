;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

($asm 
    (asm "org 0x8000")
    (asm "bits 32")
    )


;;($asm (asm "xchg bx,bx"))

;;运行
(print-char #x4f61 4 3)
(print-string "hello,world" 0 0)


;; loop forever
($asm
    (label halt)
    (jmp halt))

;;内存分配
(define mem-info #x3000)
(define alloc-frame-start #x9000)

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

;;打印字符串
(define (print-string str)
        (let loop2 ([x 0] [len (string-length str)])
            (if (< x len)
                (begin
                    (print-char (+ #x4f00 (string-ref str x)) (+ x sx) sy )
                (loop2 (+ x 1) len )))
            )
        )

;;内存分配
(define (kalloc-frame-int)
    1
)

(define (kalloc-frame)
    1
)

(define (kfree-frame a)
    1
)
   


