;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(gofmt-command "goimports")
 '(go-oracle-command "oracle"))

(with-eval-after-load 'go-mode
  (require 'go-autocomplete)
  (require 'go-eldoc)
  (require 'go-oracle "oracle")

  (add-hook 'go-mode-hook
            (lambda ()
              (go-eldoc-setup)
              (go-oracle-mode)
              (add-hook 'before-save-hook 'gofmt nil 'make-it-local)
              (set (make-local-variable 'compile-command) "go test")
              (setq tab-width 2
                    show-trailing-whitespace t)))

  (define-key go-mode-map (kbd "M-i") 'go-import-add)
  (define-key go-mode-map (kbd "C-c C-r") 'go-remove-unused-imports)

  (define-key go-mode-map (kbd "M-.") 'godef-jump)
  (define-key go-mode-map (kbd "C-?") 'godef-describe)

  (define-key go-mode-map (kbd "C-c C-c") 'recompile))
