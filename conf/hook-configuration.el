;;; -*- lexical-binding: t -*-

(mapc
 (lambda (h)
   (add-hook h 'hl-line-mode))
 '(
   Info-mode-hook
   Man-mode-hook
   archive-mode-hook
   bookmark-bmenu-mode-hook
   c-mode-common-hook
   compilation-mode-hook
   conf-mode-hook
   dired-mode-hook
   emacs-lisp-mode-hook
   gist-list-mode-hook
   gnus-article-mode-hook
   gnus-browse-mode-hook
   gnus-group-mode-hook
   gnus-server-mode-hook
   gnus-summary-mode-hook
   go-mode-hook
   ibuffer-mode-hook
   irfc-mode-hook
   org-agenda-mode-hook
   scheme-mode-hook
   special-mode-hook
   speedbar-mode-hook
   tar-mode-hook
   twittering-mode-hook
   vc-annotate-mode-hook
   woman-mode-hook
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
   feature-mode-hook
   graphviz-dot-mode-hook
   haml-mode-hook
   haskell-mode-hook
   lisp-interaction-mode-hook
   makefile-mode-hook
   markdown-mode-hook
   nxml-mode-hook
   ruby-mode-hook
   scala-mode-hook
   sgml-mode-hook
   sh-mode-hook
   text-mode-hook
   yaml-mode-hook
   ))




(mapc
 (lambda (h)
   (add-hook h 'turn-on-hl-keywords))
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


(defun turn-on-hl-keywords ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(XXX\\|TODO\\|NOTE\\|BUG\\|FIXME\\|WARNING\\|HACK\\|REFACTOR\\|IMPORTANT\\|HERE BE DRAGONS\\):"
      1 font-lock-warning-face t))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(add-hook 'term-mode-hook (lambda () (setq word-wrap nil)))
(add-hook 'term-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'term-mode-hook
          (defun load-quiet-light-theme (&rest args)
            (load-file "~/repos/misc/color-theme-quiet-light/quiet-light-theme.el")))

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(add-hook 'help-mode-hook 'turn-on-visual-line-mode)

(add-hook 'find-file-hook
          (defun create-parent-directories-for-file ()
            "Automatically create file's parent path if it does not exist."
            (let ((dir (file-name-directory buffer-file-name)))
              (when (and (not (file-directory-p dir))
                         (y-or-n-p (format "Directory %s does not exist. Create it?" (abbreviate-file-name dir))))
                (make-directory dir t)))))

(defadvice save-buffers-kill-emacs (before do-not-ask-when-has-live-clients activate)
  "Do not ask before exiting Emacs if it has live clients."
  (remove-hook 'kill-emacs-query-functions 'server-kill-emacs-query-function))

(when (fboundp 'customize-themes)
  (add-to-list 'custom-theme-load-path "~/repos/misc/color-theme-quiet-light")
  (setq custom-safe-themes t)
  (load-theme 'quiet-light)
  (add-hook 'after-make-frame-functions 'load-quiet-light-theme))
