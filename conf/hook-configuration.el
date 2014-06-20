;;; -*- lexical-binding: t -*-

(mapc
 (lambda (h)
   (add-hook h 'hl-line-mode))
 '(
   Custom-mode-hook
   Info-mode-hook
   Man-mode-hook
   archive-mode-hook
   bookmark-bmenu-mode-hook
   c-mode-common-hook
   compilation-mode-hook
   conf-mode-hook
   css-mode-hook
   debugger-mode-hook
   dired-mode-hook
   emacs-lisp-mode-hook
   finder-mode-hook
   gist-list-mode-hook
   gnus-article-mode-hook
   gnus-browse-mode-hook
   gnus-group-mode-hook
   gnus-server-mode-hook
   gnus-summary-mode-hook
   go-mode-hook
   ibuffer-mode-hook
   irfc-mode-hook
   magit-log-mode-hook
   magit-status-mode-hook
   org-agenda-mode-hook
   rspec-outline-mode-hook
   ruby-mode-hook
   rust-mode-hook
   scheme-mode-hook
   sh-mode-hook
   slim-mode-hook
   special-mode-hook
   speedbar-mode-hook
   tar-mode-hook
   twittering-mode-hook
   vc-annotate-mode-hook
   woman-mode-hook
   yaml-mode-hook
   ))


(mapc
 (lambda (h)
   (add-hook h 'whitespace-mode))
 '(
   c-mode-common-hook
   change-log-mode-hook
   coffee-mode-hook
   conf-mode-hook
   css-mode-hook
   emacs-lisp-mode-hook
   feature-mode-hook
   graphviz-dot-mode-hook
   haml-mode-hook
   haskell-mode-hook
   js-mode-hook
   lisp-interaction-mode-hook
   lisp-mode-hook
   makefile-mode-hook
   markdown-mode-hook
   nxml-mode-hook
   python-mode-hook
   ruby-mode-hook
   rust-mode-hook
   scala-mode-hook
   sgml-mode-hook
   sh-mode-hook
   yaml-mode-hook
   ))


(mapc
 (lambda (h)
   (add-hook h
             (lambda ()
               (font-lock-add-keywords
                nil
                (list (list (rx word-start
                                (group (or "XXX" "TODO" "NOTE" "BUG" "WARNING" "HACK"
                                           "REFACTOR" "IMPORTANT" "HERE BE DRAGONS" ))
                                ":")
                            '(1 font-lock-warning-face t)))))))
 '(
   c-mode-common-hook
   coffee-mode-hook
   conf-mode-hook
   cperl-mode-hook
   css-mode-hook
   emacs-lisp-mode-hook
   feature-mode-hook
   go-mode-hook
   graphviz-dot-mode-hook
   haml-mode-hook
   haskell-mode-hook
   js-mode-hook
   lisp-interaction-mode-hook
   lisp-mode-hook
   makefile-mode-hook
   nxml-mode-hook
   python-mode-hook
   ruby-mode-hook
   scala-mode-hook
   sgml-mode-hook
   sh-mode-hook
   yaml-mode-hook
   ))


(mapc
 (lambda (h)
   (add-hook h 'turn-on-drag-stuff-mode))
 '(
   c-mode-common-hook
   coffee-mode-hook
   conf-mode-hook
   cperl-mode-hook
   css-mode-hook
   feature-mode-hook
   go-mode-hook
   graphviz-dot-mode-hook
   haml-mode-hook
   haskell-mode-hook
   js-mode-hook
   magit-log-edit-mode-hook
   makefile-mode-hook
   nxml-mode-hook
   python-mode-hook
   ruby-mode-hook
   rust-mode-hook
   scala-mode-hook
   sgml-mode-hook
   sh-mode-hook
   yaml-mode-hook
   ))


(mapc
 (lambda (h)
   (add-hook h 'turn-on-eldoc-mode))
 '(
   c-mode-hook
   cperl-mode-hook
   emacs-lisp-mode-hook
   ))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(eval-after-load 'term
  (quote
   (add-hook 'term-mode-hook
             (lambda ()
               (setq truncate-lines t
                     word-wrap nil)))))

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(add-hook 'help-mode-hook 'turn-on-visual-line-mode)

(add-hook 'find-file-hook
          (defun create-parent-directories-for-file ()
            "Automatically create file's parent path if it does not exist."
            (let ((dir (file-name-directory buffer-file-name)))
              (when (and (not (file-directory-p dir))
                         (y-or-n-p (format "Directory %s does not exist. Create it?" (abbreviate-file-name dir))))
                (make-directory dir t)))))

(when (fboundp 'customize-themes)
  (add-to-list 'custom-theme-load-path "~/.emacs.d/color-theme-quiet-light")
  (setq custom-safe-themes t)
  (load-theme 'quiet-light)
  (add-hook 'after-make-frame-functions
            (lambda (_)
              (load-file "~/.emacs.d/color-theme-quiet-light/quiet-light-theme.el"))))
