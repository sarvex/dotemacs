;;; -*- lexical-binding: t -*-

(define-key global-map (kbd "M-:") 'eval-expr)

(eval-after-load 'eval-expr
  (quote
   (progn
     (defun eval-expr-minibuffer-setup ()
       "Monkey-patched version to turn on paredit-mode."
       (set-syntax-table emacs-lisp-mode-syntax-table)
       (paredit-mode)))))

(custom-set-variables
 '(eval-expr-print-length nil)
 '(eval-expr-use-echo-area-or-buffer 3))
