;;; -*- lexical-binding: t -*-

(eval-after-load 'rust-mode
  (quote
   (progn
     (add-hook 'rust-mode-hook
               (lambda ()
                 (setq show-trailing-whitespace t)
                 (set (make-local-variable 'compile-command)
                      (format "rust %s %s"
                              (if (string-match-p (rx not-newline "-test.rs" string-end)
                                                  buffer-file-name)
                                  "test"
                                  "build")
                              (file-name-nondirectory buffer-file-name)))))

     (define-key rust-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
     (define-key rust-mode-map (kbd "<f9>") 'compile))))
