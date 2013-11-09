;;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist (cons (rx ".zsh" (optional "-theme") string-end) 'sh-mode))
(add-to-list 'auto-mode-alist (cons (rx ".env" (optional ".example") string-end) 'sh-mode))

(custom-set-variables
 '(sh-basic-offset 2))

(eval-after-load 'sh-script
  '(progn
    (define-key sh-mode-map (kbd "M-l") nil)
    (define-key sh-mode-map (kbd "<f9>") 'executable-interpret)
    (define-key sh-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)))
