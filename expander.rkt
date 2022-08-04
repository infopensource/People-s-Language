#lang br/quicklang
(define-macro (r-begin (r-program EXPR ...))
  #'(#%module-begin
     EXPR ...
     ;(display 123)
     ;(define expr-list
     ;  (list EXPR ...))
     ;(display expr-list)
     ;(void (run expr-list))
     ))
(provide (rename-out [r-begin #%module-begin]))

;(define-macro (r-expr PARAM ...)
;  #' (PARAM ...))
;(provide r-expr)

(define-macro-cases r-import
  [(r-import (r-id NAME)) #'(require NAME)]
  [(r-import NAME) #'(require NAME)])
(provide r-import)

(define-macro-cases r-export
  [(r-export (r-id NAME)) #'(provide NAME)]
  [(r-export (r-id NAME) (r-id EXP-NAME)) 
  #'(provide (rename-out [NAME EXP-NAME]))])
(provide r-export)

(define-macro (r-eval PARAM ... (r-id ID))
  #'(ID PARAM ...))
(provide r-eval)

(define-macro (r-cond (r-if COND-EXPR  EXPR ...) ... (r-else ELSE-EXPR ...))
  ;(with-pattern ([(r-if COND-EXPR ， EXPR ...) #'IF ...]
  ;               [(r-else ELSE-EXPR ...) #'ELSE]))
  #'(cond [COND-EXPR EXPR ...] ... [else ELSE-EXPR ...] ))
(provide r-cond)

(define-macro (r-if COND-EXPR  EXPR ...)
  #'[COND-EXPR EXPR ...])
(provide r-if)

(define-macro (r-else EXPR ...)
  #'[else EXPR ...])
(provide r-else)

(define-macro (r-func (r-id ID) EXPR)
  #'(define ID EXPR))
(provide r-func)

(define-macro (r-lamb (r-id ID) ... EXPR ...)
  #'(lambda (ID ...) EXPR ...))
(provide r-lamb)

(define (run expr-list) 2)
(provide run)