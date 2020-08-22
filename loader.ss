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
        (asm "org 0x200")

        (call cls)
        
        (asm "mov dx,0x0000")
        (call set-cursor)

        (asm "mov si,boot")
        (asm "call print.string")

        ;;开启A20，才能访问1M以外的地址
        (call enable-a20)

        ;;加载 gdt info
        (asm "lgdt [gdtinfo]")
        ;;切换到保护模式
        (asm "mov eax ,cr0")
        (asm "mov [pcr0],eax")
        (asm "or al ,1")
        (asm "mov cr0,eax")
        (asm "mov bx, 0x10");;data selector
        (asm "mov ds, bx")
        (asm "mov gs, bx")
        (asm "jmp 0x08:protect") ;;code selector

        ;;保护模式32 bit代码
        (label protect)

        (asm "xor eax,eax")
        (asm "mov ah,0x0c")
	    (asm "mov al,'n'")
        (asm "mov ebx,0x0b8000")
        (asm "add ebx,(80*0+8)*2 ")
        (asm "mov word [gs:ebx],ax")
        

        ;(asm "mov si,boot")
        ;(asm "call print.string")

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

        ;;开启A20
        (label enable-a20)
        (asm "push ax")
        (asm "in al,92h")
        (asm "or al,2")
        (asm "out 92h,al")
        (asm "pop ax")
        (ret)
        
        ;;关闭A20
        (label disable-a20)
        (asm "push ax")
        (asm "in al,92h")
        (asm "and al,0fdh")
        (asm "out 92h,al")
        (asm "pop ax")
        (ret)
        
        (data boot "loader hello")

        ;;gdt info
        (label gdtinfo)
        (asm "dw gdt_end - gdt - 1 ")
        (asm "dd gdt       ")
        (asm "gdt   dd 0,0") ;;gdt 0 unuse
        ;;                 limit       base     type/s/dpl/p    limith/avl/l/db/g   baseh
        (asm "flatcode  db 0xff, 0xff, 0, 0, 0, 10011010b,      11001111b,          0")
        (asm "flatdata  db 0xff, 0xff, 0, 0, 0, 10010010b,      11001111b,          0")
        (asm "flatdesc  db 0xff, 0xff, 0, 0, 0, 10010010b,      11001111b,          0")
        (label gdt_end)


        (asm "pcr0: dd 0")
        
    )
    
)

