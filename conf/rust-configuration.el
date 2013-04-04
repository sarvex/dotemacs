;;; -*- lexical-binding: t -*-

(eval-after-load 'rust-mode
  (quote
   (progn
     (add-hook 'rust-mode-hook
               (lambda ()
                 (setq show-trailing-whitespace t)
                 (set (make-local-variable 'compile-command) "rust test")))

     (define-key rust-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
     (define-key rust-mode-map (kbd "<f9>") 'compile))))
