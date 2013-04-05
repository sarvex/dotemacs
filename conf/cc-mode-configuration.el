;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(c-basic-offset 4)
 '(c-strict-syntax-p t)
 '(c-syntactic-indentation t))

(eval-after-load 'cc-mode
  '(progn
    (define-key c-mode-base-map (kbd "<f9>") 'compile-no-comint)
    (define-key c-mode-base-map (kbd "<return>") 'reindent-then-newline-and-indent)))
