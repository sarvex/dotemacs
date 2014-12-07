;;; -*- lexical-binding: t -*-

(define-key global-map (kbd "M-:") 'eval-expr)

(custom-set-variables
 '(eval-expr-print-length nil)
 '(eval-expr-use-echo-area-or-buffer 3))
