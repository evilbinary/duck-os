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
        (asm "org 0x0500")
        (asm "%define page_dir_ptr_base 0x4000") ;;4k aligned 0x4000-0x7000
        (asm "%define kernel_base 0x8000")


        (call cls)
        
        (asm "mov dx,0x0000")
        (call set-cursor)

        (asm "mov si,boot")
        (asm "call print.string")
        
        ;;load kernel
        (asm "mov bx,kernel_base")
        (call disk-load)

        (asm "mov si,load.success")
        (asm "call print.string")

        ;;(asm "xchg bx,bx")

        ;;开启A20，才能访问1M以外的地址
        (call enable-a20)

        ;;加载 gdt info
        (asm "lgdt [gdtinfo]")
        (asm "cli")
        ;;切换到保护模式
        (asm "mov eax ,cr0")
        (asm "mov [pcr0],eax")
        (asm "or al ,1")
        (asm "mov cr0,eax")       
        (asm "jmp 0x08:protect") ;;code selector 跳转保护模式


        ;;磁盘读取到内存 es:bx 地址
        (label disk-load)
        (asm "mov ah,0x02 ;读取功能")
        (asm "mov al,0x01 ;读取几个扇区")
        (asm "mov cl,0x0a ;0x01 boot sector, 0x02 is first sector")
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
        (asm "ret")

        ;;设置光标位置  DH=列，DL=行    
        (label set-cursor)
        (asm "mov ah,0x02 ;光标位置初始化")
        (asm "mov bh,0")
        (asm "int 0x10")
        (asm "ret")

        ;;清除屏幕 
        (label cls)
        (asm "mov ah,0x06   ;清除屏幕		")			
        (asm "mov al,0")
        (asm "mov cx,0   ")
        (asm "mov dx,0xffff  ")
        (asm "mov bh,0x0f ;属性为白字")
        (asm "int 0x10")
        (asm "ret")

        ;;打印一个字符 al=ascii值
        (label print-char)
        (asm "mov ah,0eh")
        (asm "mov bx,0007h")
        (asm "int 0x10")
        (asm "ret")

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
        (asm "ret")

        ;;开启A20
        (label enable-a20)
        (asm "push ax")
        (asm "in al,92h")
        (asm "or al,2")
        (asm "out 92h,al")
        (asm "pop ax")
        (asm "ret")
        
        ;;关闭A20
        (label disable-a20)
        (asm "push ax")
        (asm "in al,92h")
        (asm "and al,0fdh")
        (asm "out 92h,al")
        (asm "pop ax")
        (asm "ret")


        ;;保护模式32 bit代码
        (label protect)
        (asm "bits 32")
        (asm "mov bx, 0x10");;data selector
        (asm "mov ss, bx")
        (asm "mov ds, bx") 
        (asm "mov es, bx")
        (asm "mov fs, bx")        
        (asm "mov gs, bx")

        ;;显示保护模式P
        (asm "mov ah,0xa4")
	    (asm "mov al,'P'")
        (asm "mov edi,0xb8000")
        (asm "add edi,(80*0+14)*3")
        (asm "mov word [ds:edi],ax")
        

        ;;分页设置
        (call init-page)

        ;;分页入口
        (asm "mov eax, page_dir_ptr_base") ;;0x7E00
        (asm "mov cr3, eax")

        ;;开启PAE
        (asm "mov eax, cr4")
        (asm "or eax, 1<<5")
        (asm "mov cr4, eax")


        ;;开启分页模式
        (asm "mov eax, cr0")
        (asm "or eax, 0x80000000")
        ;;(asm "xchg bx,bx")
        (asm "mov cr0, eax")

        ;;(asm "xchg bx,bx")

        ;;跳转到内核
        (asm "jmp kernel_base")

        (asm "jmp $")

        ;;分页设置
        (label init-page)
        ;;pdpt =>page_dir_ptr_base
        (asm "mov ebx,page_dir_ptr_base+0x1000|1") ;;pdpte
        (asm "mov esi,page_dir_ptr_base") ;;pdpt_addr
        (asm "mov ecx,10")
        (label loop-pdpte)
        (asm "mov dword [esi],ebx")
        (asm "mov dword [esi+4],0")
        (asm "add esi,8")
        (asm "loop loop.pdpte")
        ;;ptd =>page_dir_ptr_base + 0x1000
        (asm "mov ebx,page_dir_ptr_base+0x2000|3") ;;pde
        (asm "mov esi,page_dir_ptr_base+0x1000")
        (asm "mov ecx,10")
        (label loop-pdt)
        (asm "mov dword [esi],ebx")
        (asm "mov dword [esi+4],0")
        (asm "add esi,8")
        (asm "loop loop.pdt")
        ;;pt => page_dir_ptr_base + 0x2000
        (asm "mov ebx,0x0|3")
        (asm "mov esi,page_dir_ptr_base+0x2000")
        (asm "mov ecx,512")
        (label loop-pt)
        (asm "mov dword [esi],ebx")
        (asm "mov dword [esi+4],0")
        (asm "add ebx,0x1000")
        (asm "add esi,8")
        (asm "loop loop.pt")
        
        (asm "ret")

        (data boot "loader kernel")
        (data load.success " success")
        (data disk.erro "read disk erro")

        ;;gdt info
        (label gdtinfo)
        (asm "dw gdt_end - gdt - 1 ")
        (asm "dd gdt       ")
        (asm "gdt   dd 0,0") ;;gdt 0 unuse
        ;;                 limit       base     type/s/dpl/p    limith/avl/l/db/g   baseh
        (asm "flatcode  db 0xff, 0xff, 0, 0, 0, 10011010b,      11001111b,          0") ;;0x08
        (asm "flatdata  db 0xff, 0xff, 0, 0, 0, 10010010b,      11001111b,          0") ;;0x10
        (asm "flatdesc  db 0xff, 0xff, 0, 0, 0, 10010010b,      11001111b,          0") ;;0x18
        (asm "flattss  db 0xff, 0xff, 0, 0, 0, 10010010b,      11001111b,          0")  ;;0x20
        (label gdt_end)


        (asm "pcr0: dd 0")
        
    )
    
)

