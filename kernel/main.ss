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
(print-string "gaga" 0 1)

(task1)

;; loop forever
($asm
    (label halt)
    (jmp halt))

;;内存分配
(define mem-info #x3000)
(define alloc-frame-start #x9000)
(define gdt-info #x3200)



;;task define
(define (task1)
    (begin 
        (print-string "task1" 0 5)
        (task-switch task2)
    ))

(define (task2)
    (begin 
        (print-string "task2" 0 6)
        (task-switch task1)
    ))

;;libs
($include "bits.ss")
($include "mem.ss")
($include "print.ss")
($include "string.ss")

;;kernel
($include "gdt.ss")
($include "kalloc.ss")
($include "task.ss")

