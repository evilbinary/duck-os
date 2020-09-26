;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Copyright 2016-2080 evilbinary.
;作者:evilbinary on 12/24/16.
;邮箱:rootdebug@163.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(import (scheme) (duck)
        (options)
        (x86-os))

(define (read-file name)
    (let ((p (open-input-file name)))
        (let f ((x (read p)))
            (if (eof-object? x)
                (begin
                (close-input-port p)
                '())
                (cons x (f (read p)))))))

(define (compile-file name)
    (let ((code (read-file (format "../~a.ss" name))))
        (printf "compile ~a\n   ===>" name)
        (pretty-print code )
        (duck-compile-exp `(begin ,@code ) name)
    ))

(define (compile-files names)
    (let loop ([name names])
        (if (pair? name)
            (begin 
                (printf "file-name=>~a\n" (car name) )
                (if (equal? (car name) "start/boot")
                    (begin 
                        (option-set 'need-boot #t)
                        (compile-file (car name))
                    )
                    (begin 
                        (option-set 'need-boot #f)
                        (compile-file (car name))
                    )
                )
                (loop (cdr name))
            ))))

(define file-names '())

(define (process-args)
  (if (>= (length (command-line)) 1)
     (set! file-names (list-tail (command-line) 1))
  ))

(process-args)
(option-set 'need-primitive #f)
(compile-files file-names)


