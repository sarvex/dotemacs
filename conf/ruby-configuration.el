;;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist (cons (rx not-newline "." (or "rb" "ru" "builder" "rake" "thor" "gemspec") string-end) 'ruby-mode))
(add-to-list 'auto-mode-alist (cons (rx line-start (or "rake" "thor" "guard" "gem" "cap" "vagrant") "file" string-end) 'ruby-mode))


(custom-set-variables
 '(ruby-electric-expand-delimiters-list '(124)))

(defun flymake-ruby-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-intemp))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(defun flymake-ruby-enable ()
  (when (and buffer-file-name
             (file-writable-p
              (file-name-directory buffer-file-name))
             (file-writable-p buffer-file-name)
             (if (fboundp 'tramp-list-remote-buffers)
                 (not (member (current-buffer) (tramp-list-remote-buffers)))
                 t))
    (local-set-key (kbd "C-c e")
                   'flymake-display-err-menu-for-current-line)
    (flymake-mode t)))

(eval-after-load 'ruby-mode
  (quote
   (progn
     (require 'ruby-electric)
     (require 'inf-ruby)
     (require 'rcodetools)
     (require 'flymake)
     (require 'ffap)

     (inf-ruby-keys)
     (define-key inferior-ruby-mode-map (kbd "C-l") 'recenter-top)

     (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
           flymake-err-line-patterns)
     (push (list (rx not-newline "." (or "rb" "ru" "builder" "rake" "thor" "gemspec") string-end) 'flymake-ruby-init)
           flymake-allowed-file-name-masks)

     (define-key ruby-mode-map (kbd "C-c C-c") 'projectur-rspec)
     (define-key ruby-mode-map (kbd "<f9>") 'xmp)
     (define-key ruby-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)

     (add-hook 'ruby-mode-hook 'flymake-ruby-enable)
     (add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))
     (add-hook 'ruby-mode-hook (lambda () (setq comment-column 42)))

     (add-to-list 'ffap-alist
                  (cons
                   'ruby-mode
                   (lambda (library)
                     "Figure out path to ruby LIBRARY file. Depends on 'devel-which' gem."
                     (shell-command-to-string
                      (format "ruby -r devel/which -r %s -e 'print which_library %%(%s)'" name name)))))

     (defadvice ruby-indent-exp (after delete-trailing-whitespace-on-indention activate)
       "Clean buffer of trailing whitespaces after indentation."
       (delete-trailing-whitespace))

     (defadvice xmp (after delete-trailing-whitespace-on-execution activate)
       "Clean buffer of trailing whitespaces after execution via `xmp'."
       (delete-trailing-whitespace)))))
