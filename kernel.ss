;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(begin 
    ($asm "org 0x1000")
    ($asm "bits 32")

    (define a 1)
    (- a 30)
    (+ 111 2)
    ($asm
        (asm "mov ah,0x74")
	    (asm "mov al,'K'")
        (asm "mov edi,0xb8000")
        (asm "add edi,(80*1+0)*1")
        (asm "mov word [ds:edi],ax")
        (asm "jmp $")
    )
)

