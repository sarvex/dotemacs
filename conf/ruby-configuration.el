(mapc
 (lambda (file)
   (add-to-list 'auto-mode-alist `(,file . ruby-mode)))
 '("\\.\\(rb\\|ru\\|builder\\|rake\\|thor\\|gemspec\\)\\'"
   "\\(rake\\|thor\\|guard\\|gem\\|cap\\|vagrant\\)file\\'"))

(setq ruby-electric-matching-delimeter-alist nil
      ruby-electric-expand-delimiters-list '(124))

;; Flymake setup
(defun flymake-ruby-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    ;; Invoke ruby with '-c' to get syntax checking
    (list "ruby" (list "-c" local-file))))

(defun flymake-ruby-enable ()
  (when (and buffer-file-name
             (file-writable-p
              (file-name-directory buffer-file-name))
             (file-writable-p buffer-file-name)
             (if (fboundp 'tramp-list-remote-buffers)
                 (not (subsetp
                       (list (current-buffer))
                       (tramp-list-remote-buffers)))
                 t))
    (local-set-key (kbd "C-c e")
                   'flymake-display-err-menu-for-current-line)
    (turn-on-flymake-mode)))

(defun my-ruby-mode-hook ()
  (ruby-electric-mode t)
  (setq comment-column 42)
  (flymake-ruby-enable))

(eval-after-load 'ruby-mode
  '(progn
    (require 'ruby-electric)
    (require 'inf-ruby)
    (require 'rcodetools)

    (inf-ruby-keys)
    (define-key inferior-ruby-mode-map (kbd "<f1>") 'yari)
    (define-key inferior-ruby-mode-map (kbd "C-l") 'recenter-top)

    ;; enable flymake
    (require 'flymake)

    (mapc
     (lambda (file)
       (push `(,file flymake-ruby-init) flymake-allowed-file-name-masks))
     '(".+\\.\\(rb\\|ru\\|rake\\|thor\\|gemspec\\)\\'"
       "\\([Rr]ake\\|[Tt]hor\\|[Gg]\\(uard\\|em\\)\\|[Cc]ap\\|[Vv]agrant\\)file\\'"))

    (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

    (define-key ruby-mode-map (kbd "<f9>") 'xmp)
    (define-key ruby-mode-map (kbd "<f1>") 'yari)
    (define-key ruby-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
    (define-key ruby-mode-map (kbd "C-<return>")
     (lambda () (interactive) (move-end-of-line 1) (reindent-then-newline-and-indent)))
    (define-key ruby-mode-map (kbd "M-<return>")
     (lambda () (interactive) (previous-line 1) (move-end-of-line 1) (reindent-then-newline-and-indent)))

    (add-hook 'ruby-mode-hook 'my-ruby-mode-hook)))

(eval-after-load 'yari
  '(define-key yari-mode-map (kbd "<f1>") 'yari))

(defadvice ruby-indent-exp (after delete-trailing-whitespace-on-indention activate)
  "Clean up buffer of trailing whitespaces after indentation."
  (delete-trailing-whitespace))
