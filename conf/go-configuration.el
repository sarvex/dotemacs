(defun vderyagin/go-mode-hook ()
  (require 'flymake)
  (push '(".+\\.go\\'" flymake-go-init) flymake-allowed-file-name-masks)
  (flymake-mode -1)

  (require 'go-autocomplete)

  (set (make-local-variable 'compile-command) "go test")

  (setq tab-width 2))

(defun flymake-go-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "go" (list "build" "-o" "/dev/null" temp-file))))

(eval-after-load 'go-mode
  '(progn
    (add-hook 'go-mode-hook 'vderyagin/go-mode-hook)
    (add-hook 'before-save-hook 'gofmt-before-save)

    (define-key go-mode-map (kbd "<f9>") 'compile)
    (define-key go-mode-map (kbd "<f10>") 'flymake-mode)
    (define-key go-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
    (define-key go-mode-map (kbd "C-c e") 'flymake-display-err-menu-for-current-line)
    (define-key go-mode-map (kbd "C-c C-c") 'gofmt)))
