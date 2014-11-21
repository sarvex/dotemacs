;;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist (cons (rx not-newline "." (or "rb" "ru" "builder" "rake" "thor" "gemspec") string-end) 'ruby-mode))
(add-to-list 'auto-mode-alist (cons (rx (or "rake" "thor" "guard" "gem" "cap" "vagrant") "file" string-end) 'ruby-mode))

(with-eval-after-load 'ruby-mode
  (require 'ffap)
  (require 'rcodetools)
  (require 'rspec-simple)

  (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)

  (define-key *rspec-outline-mode-map* (kbd "p") 'previous-line)
  (define-key *rspec-outline-mode-map* (kbd "n") 'next-line)
  (define-key *rspec-outline-mode-map* (kbd "<space>") 'next-line)
  (define-key *rspec-outline-mode-map* (kbd "r") 'isearch-backward)
  (define-key *rspec-outline-mode-map* (kbd "s") 'isearch-forward)

  (add-hook 'ruby-mode-hook 'yas-minor-mode-on)
  (add-hook 'ruby-mode-hook (lambda () (setq comment-column 42)))
  (add-hook 'ruby-mode-hook
            (lambda ()
              (when buffer-file-name
                (set (make-local-variable 'compile-command) "rake"))))

  (add-to-list 'ffap-alist
               (cons
                'ruby-mode
                (lambda (library)
                  "Figure out path to ruby LIBRARY file. Depends on 'devel-which' gem."
                  (shell-command-to-string
                   (format "ruby -r devel/which -r %s -e 'print which_library %%(%s)'" library library)))))

  (defadvice ruby-indent-exp (after delete-trailing-whitespace-on-indention activate)
    "Clean buffer of trailing whitespaces after indentation."
    (delete-trailing-whitespace))

  (defadvice xmp (after delete-trailing-whitespace-on-execution activate)
    "Clean buffer of trailing whitespaces after execution via `xmp'."
    (delete-trailing-whitespace)))
