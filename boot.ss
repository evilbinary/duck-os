;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(begin
    (define add
        (lambda (a b)
        (+ a b)))
    ($asm 
        (set reg0 reg1)
        (set reg4 hello)
        (asm ".loop lodsb") 
        (asm "or eax, eax")
        (asm "jz halt")            
        (asm "int 0x10 ")             
        (asm "jmp .loop")
        (asm "halt: hlt")
        (ret)
        (data hello "hello")
    )
    
)

