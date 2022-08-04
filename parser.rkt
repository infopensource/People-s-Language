#lang brag
r-program : [r-import]*  [r-expr]*
@r-expr : /["取"] (r-eval | r-lamb | r-func | r-export| r-cond | DECIMAL | INTEGER | STRING | ID) 
r-func : /"以" r-id /"为" [/COMMA] r-expr
r-lamb : /LAMBDA [r-id]* /COMMA [r-expr]* /END
r-eval : r-id /"取" r-arguments /"为" r-contents /"者"
       | /[COMMA "取"] [r-expr]* (/"之" | /"相") r-id
r-arguments : [r-id]*
r-contents : [r-expr]*
r-import: /"引用" (r-id | STRING)
r-export: /"导出" r-id [/"为" r-id]
r-cond:  r-if+ r-else
r-if: /"当" r-expr /"时" /COMMA [r-expr]* /SEMICOLON
r-else: [/"否则" [r-expr]* /END]
r-id: ID
r-end: END

