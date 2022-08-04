#lang br
(require "lexer.rkt" brag/support rackunit)

(define (lex str)
  (apply-port-proc rh-lexer str))

(check-equal? (lex "") empty)

(check-equal?
 (lex "，即：注释。")
 (list (srcloc-token (token 'REM "，即：注释。")
                     (srcloc 'string 1 0 1 6))))

(check-equal?
 (lex "，")
 (list (srcloc-token (token 'COMMA "，")
                     (srcloc 'string 1 0 1 1))))

(check-equal?
 (lex "一二")
 (list (srcloc-token (token 'INTEGER 12)
                     (srcloc 'string 1 0 1 2))))

(check-equal?
 (lex "一点二")
 (list (srcloc-token (token 'DECIMAL 1.2)
                     (srcloc 'string 1 0 1 3))))

(check-equal?
 (lex "\"甲乙丙丁\"")
 (list (srcloc-token (token 'STRING "甲乙丙丁")
                     (srcloc 'string 1 0 1 6))))

(check-equal?
 (lex "'甲乙丙丁'")
 (list (srcloc-token (token 'STRING "甲乙丙丁")
                     (srcloc 'string 1 0 1 6))))

(check-equal?
  (lex "【标识符】")
  (list (srcloc-token (token 'ID "标识符")
                      (srcloc 'string 1 0 1 5))))

(check-equal?
  (lex "入")
  (list (srcloc-token (token 'LAMBDA "入")
                      (srcloc 'string 1 0 1 1))))
(lex "以【阶乘】为，
入【甲】，当【甲】与零相【等】时，取一；
         否则取【甲】与一之【差】之【阶乘】
            与【甲】之【积】。。
九之【阶乘】")

(check-exn exn:fail:read? (lambda () (lex "x")))