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

;;(print-char (+ #x4f00 #x60  (mod 8 3)) 0 6)


;;set task
; (gdt-set-base-limit task1 #xffffff 0x0f89)
; (print-hex #x12345 0 6)


;;(print-hex (mem-ref #x3000) 6 2)
(print-mem-info)

; (print-base 1234 10 0 6)
;;(task1)

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
($include "../libs/bits.ss")
($include "../libs/mem.ss")
($include "../libs/print.ss")
($include "../libs/string.ss")
($include "../libs/math.ss")
($include "../libs/logic.ss")

;;kernel
($include "../kernel/asm.ss")
($include "../kernel/gdt.ss")
($include "../kernel/kalloc.ss")
($include "../kernel/task.ss")

