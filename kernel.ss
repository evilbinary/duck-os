;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

($asm 
    (asm "org 0x8000")
    (asm "bits 32"))

;;打印一个字符
(define (print-char ch)
    ($asm
        (set reg0 (local 0))
        (sar reg0 3);;cast to raw type
        (set reg5 #xb8000)
        (mset reg5 r0)
        ))


;;内存分配
(define alloc-frame-start 0x9000)
(define (kalloc-frame-int)
    1
)

(define (kalloc-frame)
    1
)

(define (kfree-frame a)
    1
)


;;运行
(print-char #x4f69)



;; loop forever
($asm
    (label halt)
    (jmp halt)


)
   


