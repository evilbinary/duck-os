;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(begin
    ; (define add
    ;     (lambda (a b)
    ;     (+ a b)))
    ($asm
        (call cli)

        (asm "mov si,boot")
        (asm "call print.string")

        (asm "jmp $")
        (ret)
        
        (label print-char)
        (asm "mov ah,0eh")
        (asm "mov bx,0007h")
        (asm "int 0x10")
        (ret)

        (label print-string)
        (note ";si addr ,dh row ,dl col")
        (label ps)
        (asm "mov al,[si]")
        (asm "inc si")
        (asm "or al,al")
        (asm "jz pend")  
        (asm "call print.char")      
        (asm "jmp ps")
        (label pend)
        (asm "ret")
        
        (label cli)
        (asm "cli")
        (ret)

        (data boot "boot hello")
        
    )
    
)

