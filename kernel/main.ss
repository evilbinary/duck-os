;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

($asm 
    (asm "org 0x8000")
    (asm "bits 32")
    )

;;运行
;;(print-char #x4f61 2 2)
; (print-string "hello,world" 0 0)
; (print-string "gaga" 0 1)

;;打印
;;(print-char (+ #x4f00 #x60  (mod 8 3)) 0 6)
;;(print-hex (mem-ref #x3000) 6 2)
; (print-base 1234 10 0 6)
;;(print-mem-info)


;;任务
(gdt-set-base-limit #x3400 #xffffff #x89)

($data tcb-task0 0 32)
($data tcb-task1 0 32)
($data tcb-task2 0 32)

(mem-set &tcb-task0 &tt0)
(mem-set &tcb-task1 &tt1)
(mem-set &tcb-task2 &tt2)

(task-init &tcb-task0)

;; loop forever
(loop-forever)

;;内存分配
(define mem-info #x3000)
(define alloc-frame-start #x9000)
(define gdt-info #x3200)

;;print mem info
(define (print-mem-info)
    (let print-mem-info-loop ([i 0] [count (mem-ref #x3000)])
        (if (< i count)
            (begin
                (print-hex (mem-ref (+ #x3004 (* i 4 6))) 0 i ) ;;BaseL
                ; (print-hex (mem-ref (+ #x3012 (* i 4 6))) 18 i ) ;;Length
                ; (print-hex (mem-ref (+ #x3020 (* i 4 6))) 40 i ) ;;Type
                (print-mem-info-loop (+ i 1)  count)
            )
        )
    )
)


;;task define
(define (task0)
    (begin 
        ($asm (label tt0))
        (print-string "task0" 0 5)
        (mem-set &next-taskp &tcb-task1)
        ($asm (jmp switch-to))
    ))

(define (task1)
    (begin 
        ($asm (label tt1))
        (print-string "task1" 0 10)
        (mem-set &next-taskp &tcb-task2)
        ($asm (jmp switch-to))
    ))

(define (task2)
    (begin 
        ($asm (label tt2))
        (print-string "task2" 0 10)
        (mem-set &next-taskp &tcb-task0)
        ($asm (jmp switch-to))
    ))


;;libs
($include "../libs/bits.ss")
($include "../libs/mem.ss")
($include "../libs/print.ss")
($include "../libs/string.ss")
($include "../libs/math.ss")
($include "../libs/logic.ss")

;;kernel
($include "../kernel/asm.ss")
($include "../kernel/kalloc.ss")
($include "../kernel/task.ss")

