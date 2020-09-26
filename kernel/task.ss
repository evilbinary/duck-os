;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;任务
(define (task-switch task)
    ($asm
        (asm "xchg bx,bx")
        (set reg0 (local 0))
        (sar reg0 3)
        (set reg1 0x20)
        (asm "mov es,ebx")
        (asm "call far [es:eax]")

        ; (asm "push word 0xa0")
        ; (asm "push dword 0x0")
        ; (asm "jmp far [esp]")
        ; (asm "call 0x20:[eax]")
        ; (asm "jmp dword 0x20:00")
        ;;(set r0 #x20)
        ;;(asm (ltr r0))
    )
)

