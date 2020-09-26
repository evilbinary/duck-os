;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;gdt u32 base u32 limit u16 type
(define (gdt-set-base-limit base limit type)
    (let ([gdt-addr (mem-ref #x3200)])
        (let ([low (bit-or (bit-shift-left base 16) 
                           (bit-and limit #x0000FFFF))]
              [hi  (bit-or (bit-or (bit-and limit #x000F0000)
                                    (bit-and (bit-shift-left type 8) #x00F0FF00))
                           (bit-or (bit-and (bit-shift-right base 16) #x000000FF)
                                  (bit-and base #x000000FF))
                       ) ])
              (mem-set gdt low)
              (mem-set (+ gdt 1) hi)
              )
    ))