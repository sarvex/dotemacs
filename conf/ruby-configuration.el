;;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist (cons (rx not-newline "." (or "rb" "ru" "builder" "rake" "thor" "gemspec") string-end) 'ruby-mode))
(add-to-list 'auto-mode-alist (cons (rx (or "rake" "thor" "guard" "gem" "cap" "vagrant") "file" string-end) 'ruby-mode))


(custom-set-variables
 '(ruby-electric-expand-delimiters-list '(124)))

(eval-after-load 'ruby-mode
  (quote
   (progn
     (require 'ruby-electric)
     (require 'inf-ruby)
     (require 'rcodetools)
     (require 'ffap)

     (inf-ruby-keys)

     (define-key ruby-mode-map (kbd "C-c C-c") 'projectur-rspec)
     (define-key ruby-mode-map (kbd "<f9>") 'xmp)
     (define-key ruby-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)

     (add-hook 'ruby-mode-hook 'flycheck-mode)
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
