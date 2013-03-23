;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(css-indent-offset 2)
 '(scss-compile-at-save nil))

(eval-after-load 'sgml-mode
  '(define-key sgml-mode-map (kbd "<return>") 'reindent-then-newline-and-indent))


(mapc
 (lambda (hooks)
   (add-hook hooks 'rainbow-mode))
 '(css-mode-hook sass-mode-hook scss-mode-hook))
