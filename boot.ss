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
        (asm "bits 16")
        (call cli)
        (call cls)

        (asm "mov dx,0x0000")
        (call set-cursor)

        (asm "mov si,boot")
        (asm "call print.string")

        (asm "mov bx,0x200")
        (call disk-load)

        ; (asm "mov ax,0x0000")
        ; (asm "mov es,ax")
        (asm "mov si,0x200")
        (asm "call print.string")

        ;;跳转loader地址
        (asm "jmp 0x200")
        
        (asm "jmp $")
        
        ;;磁盘读取到内存 es:bx 地址
        (label disk-load)
        (asm "mov ah,0x02 ;读取功能")
        (asm "mov al,0x01 ;读取几个扇区")
        (asm "mov cl,0x02 ;0x01 boot sector, 0x02 is first sector")
        (asm "mov ch,0x00")
        (asm "mov dh,0x00")
        (asm "mov dl,0x00 ;软盘0")
        (asm "int 0x13")
        (asm "jc disk.error")
        (asm "jmp dend")
        (label disk-error)
        (asm "mov si,disk.erro")
        (asm "call print.string")
        (label dend)
        (ret)

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
        
        ;;关中断
        (label cli)
        (asm "cli")
        (ret)

        (data boot "boot hello")
        (data disk.erro "read disk erro")
        
    )
    
)

