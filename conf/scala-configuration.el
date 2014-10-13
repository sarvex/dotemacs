;;; -*- lexical-binding: t -*-

(add-to-list 'interpreter-mode-alist '("scala" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . scala-mode))

(with-eval-after-load 'scala-mode2
  (require 'ensime)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

  (define-key scala-mode-map (kbd "C-<tab>") nil))
