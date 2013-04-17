;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(c-basic-offset 4)
 '(c-strict-syntax-p t)
 '(c-syntactic-indentation t))

(eval-after-load 'cc-mode
  '(define-key c-mode-base-map (kbd "<return>") 'reindent-then-newline-and-indent))
