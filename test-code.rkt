#lang br/quicklang
(define-macro (r-eval PARAM ... (r-id ID))
  #'(#'ID PARAM ...))