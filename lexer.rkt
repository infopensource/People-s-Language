#lang br
(require brag/support)

(define-lex-abbrev digits (:+ (char-set "零一二三四五六七八九十百千万〇壹贰叁肆伍陆柒捌玖拾佰仟萬")))

(define rh-lexer 
  (lexer-srcloc
    ["，" (token 'COMMA (string->symbol lexeme))]
    ["。" (token 'END (string->symbol lexeme))]
    ["；" (token 'SEMICOLON (string->symbol lexeme))]
    ["入" (token 'LAMBDA lexeme)]
    [whitespace (token lexeme #:skip? #t)]
    [(from/to "，即" "。") (token lexeme #:skip? #t)]
    ["与" (token lexeme #:skip? #t)]
    [digits (token 'INTEGER (chinese-string->number lexeme))]
    [(:or (:seq (:? digits) "点" digits)
          (:seq digits "点"))
     (token 'DECIMAL (chinese-string->number lexeme))]
    [(:or (from/to "“" "”") (from/to "‘" "’"))
     (token 'STRING
            (substring lexeme
                       1 (sub1 (string-length lexeme))))]
    [(:or "真" "阳") (token 'TRUE #t)]
    [(:or "假" "阴") (token 'FALSE #f)]
    [(:or (from/to "【" "】") (from/to "「" "」"))
     (token 'ID
            (string->symbol (substring lexeme
                                       1 (sub1 (string-length lexeme)))))]
    [(:or "以" "为" "取" "者" "之" "相" "当" "时" "否则" "引用" "导出") (token lexeme lexeme)]
        ;[(any-string exn:fail:read) (token 'NEW-ID lexeme)]
        ))

(define (chinese-string->number chinese-string)
  (define number-list (hash #\零 #\0
                            #\一 #\1
                            #\二 #\2
                            #\三 #\3
                            #\四 #\4
                            #\五 #\5
                            #\六 #\6
                            #\七 #\7
                            #\八 #\8
                            #\九 #\9
                            #\点 #\.))
  ;(hash-ref number-list "三")
  (string->number (list->string (map (lambda (char) 
                                             (hash-ref number-list char))
                                (string->list chinese-string))))
)

(provide rh-lexer)
