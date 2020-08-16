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
        (call cls)

        (asm "mov dx,0x0000")
        (call set-cursor)

        (asm "mov al,0x61")
        (call print-char)
        ; (asm "mov si,boot")
        ; (asm "call print.string")

        (asm "jmp $")
        

        ;;设置光标位置  DH=列，DL=行
        (label set-cursor)
        (asm "mov ah,0x02 ;光标位置初始化")
        (asm "mov bh,0")
        (asm "int 0x10")
        (ret)

        ;;清除屏幕 
        (label cls)
        (asm "mov ah,0x06   ;清除屏幕		")			
        (asm "mov al,0")
        (asm "mov cx,0   ")
        (asm "mov dx,0xffff  ")
        (asm "mov bh,0x0f ;属性为白字")
        (asm "int 0x10")
        (ret)

        ;;打印一个字符 al=ascii值
        (label print-char)
        (asm "mov ah,0eh")
        (asm "mov bx,0007h")
        (asm "int 0x10")
        (ret)

        ;;打印字符串 si=字符地址
        (label print-string)
        (label ps)
        (asm "mov al,[si]")
        (asm "inc si")
        (asm "or al,al")
        (asm "jz pend")  
        (asm "call print.char")      
        (asm "jmp ps")
        (label pend)
        (ret)
        
        (data boot "loader hello")

        (asm "idt.real: dw 0x3ff")
        (asm "  dd 0")
        (asm "pcr0: dd 0")
        
    )
    
)

