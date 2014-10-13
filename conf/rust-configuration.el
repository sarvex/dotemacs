;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(rust-indent-offset 2))

(with-eval-after-load 'rust-mode
  (add-hook 'rust-mode-hook 'yas-minor-mode-on)
  (add-hook 'rust-mode-hook
            (lambda ()
              (setq compile-command
                    (rust-compile-command (rust-test-file-p buffer-file-name)))))
  (define-key rust-mode-map (kbd "C-c C-c") 'rust-compile-and-maybe-run))

(defun rust-test-file-p (filename)
  (string-match-p
   (rx not-newline word-boundary "test.rs" string-end)
   filename))

(defun rust-compile-command (&optional run)
  (when buffer-file-name
    (let* ((source-file (file-name-nondirectory buffer-file-name))
           (executable (file-name-sans-extension source-file))
           (cmd (format (if (rust-test-file-p source-file)
                            "rustc --test %s"
                          "rustc %s")
                        source-file)))
      (if run
          (concat cmd " && ./" executable)
        cmd))))

(defun rust-compile-and-maybe-run (&optional force-run)
  "Compile current file, when it is a test file or when command
is run with prefix argument - also execute resulting binary."
  (interactive "P")
  (let ((compile-command
         (rust-compile-command (or force-run
                                   (rust-test-file-p buffer-file-name)))))
    (recompile)))
