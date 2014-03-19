;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(rust-indent-offset 2))

(eval-after-load 'rust-mode
  (quote
   (progn
     (add-hook 'rust-mode-hook 'yas-minor-mode-on)
     (define-key rust-mode-map (kbd "C-c C-c") 'rust-compile-and-maybe-run))))

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

(defun rust-test-file-p (filename)
  (string-match-p
   (rx not-newline word-boundary "test.rs" string-end)
   filename))

(defun rust-compile-command ()
  (when buffer-file-name
    (let ((source-file (file-name-nondirectory buffer-file-name)))
      (format (if (rust-test-file-p source-file) "rustc --test %s" "rustc %s")
              source-file))))

(defun rust-compile-and-run-command ()
  (let* ((compile-cmd (rust-compile-command))
         (executable (file-name-sans-extension (file-name-nondirectory buffer-file-name))))
    (concat compile-cmd "; ./" executable)))

(defun rust-compile-and-maybe-run (&optional force-run)
  "Compile current file, when it is a test file or when command
is run with prefix argument - also execute resulting binary."
  (interactive "P")
  (let ((compile-command
         (if (or force-run
                 (rust-test-file-p buffer-file-name))
             (rust-compile-and-run-command)
           (rust-compile-command))))
    (recompile)))
