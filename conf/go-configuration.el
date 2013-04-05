;;; -*- lexical-binding: t -*-

(eval-after-load 'go-mode
  '(progn
    (require 'go-autocomplete)

    (add-hook 'go-mode-hook 'flycheck-mode)

    (add-hook 'go-mode-hook
     (lambda ()
       (add-hook 'before-save-hook 'gofmt nil 'make-it-local)
       (set (make-local-variable 'compile-command) "go test")
       (setq tab-width 2
             show-trailing-whitespace t)))

    (define-key go-mode-map (kbd "M-i") 'go-import-add)
    (define-key go-mode-map (kbd "C-c C-r") 'go-remove-unused-imports)

    (define-key go-mode-map (kbd "M-.") 'godef-jump)
    (define-key go-mode-map (kbd "C-?") 'godef-describe)

    (define-key go-mode-map (kbd "<f9>") 'compile-no-comint)

    (define-key go-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
    (define-key go-mode-map (kbd "C-c C-c") 'gofmt)))
