;;; -*- lexical-binding: t -*-

(eval-after-load 'rust-mode
  (quote
   (progn
     (add-hook 'rust-mode-hook 'yas-minor-mode-on)
     (add-hook 'rust-mode-hook 'flycheck-mode)
     (add-hook 'rust-mode-hook
               (lambda ()
                 (setq show-trailing-whitespace t)
                 (set (make-local-variable 'compile-command)
                      (format "rust %s %s"
                              (if (string-match-p (rx not-newline word-boundary "test.rs" string-end)
                                                  buffer-file-name)
                                  "test"
                                  "build")
                              (file-name-nondirectory buffer-file-name)))))

     (define-key rust-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
     (define-key rust-mode-map (kbd "<f9>") 'recompile))))

(eval-after-load 'compile
  (quote
   (progn
     (add-to-list 'compilation-error-regexp-alist 'rust-test)
     (add-to-list 'compilation-error-regexp-alist-alist
                  (list 'rust-test
                        (rx line-start
                            "rust: task failed at '"
                            (*? anything)
                            "', "
                            (group (+ not-newline) ".rs") ; file name
                            ":"
                            (group (+ (char digit)))      ; line number
                            line-end)
                        1 2))

     (add-to-list 'compilation-error-regexp-alist 'rust-build)
     (add-to-list 'compilation-error-regexp-alist-alist
                  (list 'rust-build
                        (rx line-start
                            (group (+ not-newline) ".r" (char "sc")) ; file name
                            ":"
                            (group (+ (char digit)))                 ; line number
                            ":"
                            (group (+ (char digit)))                 ; column number
                            ": "
                            (* not-newline)
                            line-end)
                        1 2 3)))))
