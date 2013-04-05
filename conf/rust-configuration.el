;;; -*- lexical-binding: t -*-

(eval-after-load 'rust-mode
  (quote
   (progn
     (add-hook 'rust-mode-hook 'yas-minor-mode-on)
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

(eval-after-load 'compile
  (quote
   (progn
     (add-to-list 'compilation-error-regexp-alist 'rust-test)
     (add-to-list 'compilation-error-regexp-alist-alist
                  (list 'rust-test
                        (rx line-start
                            "rust: task failed at '"
                            (* not-newline)
                            "', "
                            (group (+ not-newline) ".rs")
                            ":"
                            (group (+ (char digit)))
                            line-end)
                        1 2))

     (add-to-list 'compilation-error-regexp-alist 'rust-build)
     (add-to-list 'compilation-error-regexp-alist-alist
                  (list 'rust-build
                        (rx line-start
                            (group (+ not-newline) ".r" (char "sc"))
                            ":"
                            (group (+ (char digit)))
                            ":"
                            (group (+ (char digit)))
                            ": ")
                        1 2 3)))))
