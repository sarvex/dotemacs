(defun vderyagin/go-mode-hook ()
  (require 'flymake)
  (flymake-mode)
  (push '(".+\\.go\\'" flymake-go-init) flymake-allowed-file-name-masks)

  (when (fboundp 'whitespace-mode)
    (whitespace-mode -1))

  (setq compile-command "go build")

  (setq tab-width 2))

(defun flymake-go-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-intemp))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "go" (list "build" "-o" "/dev/null" temp-file))))

(eval-after-load 'go-mode
  '(progn
    (add-hook 'go-mode-hook 'vderyagin/go-mode-hook)
    (add-hook 'before-save-hook 'gofmt-before-save)

    (define-key go-mode-map (kbd "<f9>") 'compile)
    (define-key go-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
    (define-key go-mode-map (kbd "C-c e") 'flymake-display-err-menu-for-current-line)
    (define-key go-mode-map (kbd "C-c C-c") 'gofmt)))
