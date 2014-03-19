;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(rust-indent-offset 2))

(defun rust-set-compile-command ()
  (when buffer-file-name
    (set (make-local-variable 'compile-command)
         (let* ((source-file (file-name-nondirectory buffer-file-name))
                (executable (file-name-sans-extension source-file)))
           (if (string-match-p (rx not-newline word-boundary "test.rs" string-end)
                               buffer-file-name)
               (format "rustc --test %s; ./%s" source-file executable)
             (format "rustc %s" source-file))))))

(eval-after-load 'rust-mode
  (quote
   (progn
     (add-hook 'rust-mode-hook 'yas-minor-mode-on)
     (add-hook 'rust-mode-hook 'rust-set-compile-command)
     (define-key rust-mode-map (kbd "<f9>")
       (lambda ()
         (interactive)
         (rust-set-compile-command)
         (recompile)))
     (define-key rust-mode-map (kbd "<return>") 'reindent-then-newline-and-indent))))

(eval-after-load 'compile
  (quote
   (progn
     (add-to-list 'compilation-error-regexp-alist 'rust-test)
     (add-to-list 'compilation-error-regexp-alist-alist
                  (list 'rust-test
                        (rx line-start
                            "\ttask '"
                            (*? anything)
                            "' failed at '"
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
                            (group (+ not-newline) ".rs") ; file name
                            ":"
                            (group (+ (char digit)))      ; line number
                            ":"
                            (group (+ (char digit)))      ; column number
                            ": "
                            (* not-newline)
                            line-end)
                        1 2 3)))))
