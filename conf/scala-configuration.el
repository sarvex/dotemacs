;;; -*- lexical-binding: t -*-

(add-to-list 'interpreter-mode-alist '("scala" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . scala-mode))

(eval-after-load 'scala-mode
  '(progn
    (require 'ensime)
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

    (define-key scala-mode-map (kbd "C-<tab>") nil)
    (define-key scala-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)))
