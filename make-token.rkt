#lang br/quicklang
(require brag/support "tokenizer.rkt")

(define (read-syntax path port)
  (define tokens (apply-tokenizer make-tokenizer port))
  (strip-bindings
   #`(module rh-tokens-mod rh/make-ast
       #,@tokens)))
(module+ reader (provide read-syntax))

(define-macro (make-ast-mb TOKEN ...)
  #'(#%module-begin
     (map (lambda (tok) (writeln tok)) (list TOKEN ...))))
(provide (rename-out [make-ast-mb #%module-begin]))