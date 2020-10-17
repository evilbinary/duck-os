;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (magic-break)
    ($asm (asm "xchg bx,bx"))
)

(define (loop-forever)
    ($asm
        (label forever)
        (asm (nop))
        (asm (hlt))
        (jmp forever))
)


(define (task-init tcb)
    ($asm
        (asm "cli")
        (asm "mov ebx,0x4000")
        (asm "mov esi,0x3400")
        (asm "mov [esi+0x1c],ebx");;cr3
        (asm "mov word [esi+0x50],0x10");;ss
        (asm "mov word [esi+0x4c],0x08");;cs
        (asm "mov word [esi+0x54],0x10");;ds
        (asm "mov word [esi+0x38],0x3800");;esp
        (asm "mov word [esi+0x3c],0x3800");;ebp

        (asm "mov word [esi+0x00],0x3400");;link

        (set reg0 (local 0))
        (sar reg0 3)
        ;;(asm "xchg bx,bx")

        (asm "mov [current.taskp],eax");;set current task ptr
        (asm "mov edi,eax")
        (asm "mov eax,[edi]") ;;get tcb eip
        (asm "mov [esi+0x20],eax");;eip
        ;;(asm "sti")
        ;;(asm "xchg bx,bx")   
        (asm "jmp 0x20:0")
        
    )
)

($asm 
    (label switch-to)

        ;;(asm "cli")
        (asm "mov esi,0x3400")
        (asm "mov edi,[current.taskp]");;get current task info
        (asm "mov eax,[esi+0x20]");;get eip
        (asm "mov [edi],eax");;save eip into current task
        (asm "mov eax,[esi+0x38]") ;;get esp
        (asm "mov [edi+4],eax") ;;save esp into current task


        (asm "mov edi,[next.taskp]")
        (asm "mov [current.taskp],edi");;set current task ptr

        (asm "mov eax,[edi+4]") ;;get new esp
        (asm "mov [esi+0x38],eax")

        (asm "mov eax,[edi]") ;;get new eip
        (asm "mov [esi+0x20],eax")

        ;;(asm "sti")
        
        ;;(asm "xchg bx,bx")    
        (asm "jmp eax")
)


;;gdt u32 base u32 limit u16 type
(define (gdt-set-base-limit base limit type)
    ($asm
        (set reg3 #x3200)
        (mref reg3 reg3)

        (set reg0 (local 0));;base
        (set reg1 (local 1));;limit
        (sar reg0 3);;cast to val
        (sar reg1 3);;cast to val
        (sal reg0 16);;basel
        (land reg1 #x0000FFFF);;limitl
        (lor reg0 reg1);;low

        (add reg3 #x20)
        (mset reg3 reg0);;set low

        (set reg1 (local 1))
        (sar reg1 3);;cast to val
        (land reg1 #x000F0000)
        (sal reg2 8)
        (land reg2 #x00F0FF00)
        (lor reg1 reg2)

        (set reg0 (local 0))
        (sar reg0 3);;cast to val
        (sar reg0 16)
        (land reg0 #x000000FF);;limit

        (set reg2 (local 0))
        (sar reg2 3);;cast to val
        (land reg2 #xFF000000)
        (lor reg0 reg2);;hi

        (add reg3 #x20)
        (mset reg3 reg0);;set hi

    )
    ; (let ([gdt-addr (+ (mem-ref #x3200) #x20)])
    ;     (let ([low (bit-or (bit-shift-left base 16) 
    ;                        (bit-and limit #x0000FFFF))]
    ;           [hi  (bit-or (bit-or (bit-and limit #x000F0000)
    ;                                 (bit-and (bit-shift-left type 8) #x00F0FF00))
    ;                        (bit-or (bit-and (bit-shift-right base 16) #x000000FF)
    ;                               (bit-and base #xFF000000))
    ;                    ) ])
              
    ;           (mem-set gdt-addr low)
    ;           (mem-set (+ gdt-addr 1) hi)
    ;           )
    ; )
    )