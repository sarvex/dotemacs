(let* ((conf-modes '(conf-colon-mode
                     conf-javaprop-mode
                     conf-mode
                     conf-ppd-mode
                     conf-space-mode
                     conf-unix-mode
                     conf-windows-mode
                     conf-xdefaults-mode))
       (conf-modes-hooks (mapcar (lambda (mode)
                                   (intern (concat (symbol-name mode)
                                                   "-hook")))
                                 conf-modes))
       (hl-line-modes-hooks (append
                             '(archive-mode-hook
                               Info-mode-hook
                               emacs-lisp-mode-hook
                               special-mode-hook
                               scheme-mode-hook
                               bookmark-bmenu-mode-hook
                               gnus-article-mode-hook
                               gnus-group-mode-hook
                               gist-list-mode-hook
                               compilation-mode-hook
                               ibuffer-mode-hook
                               irfc-mode-hook
                               speedbar-mode-hook
                               tar-mode-hook
                               vc-annotate-mode-hook
                               twittering-mode-hook)))
       (whitespace-modes-hooks (append
                                conf-modes-hooks
                                '(text-mode-hook
                                  change-log-mode-hook
                                  coffee-mode-hook
                                  prog-mode-hook
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
                                  sgml-mode-hook
                                  sh-mode-hook
                                  yaml-mode-hook)))
       (hl-keywords-modes-hooks (append
                                 conf-modes-hooks
                                 '(c-mode-common-hook
                                   coffee-mode-hook
                                   cperl-mode-hook
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
                                   nxml-mode-hook
                                   python-mode-hook
                                   ruby-mode-hook
                                   sgml-mode-hook
                                   sh-mode-hook
                                   yaml-mode-hook)))
       (drag-stuff-modes-hooks (append
                                conf-modes-hooks
                                '(c-mode-common-hook
                                  coffee-mode-hook
                                  cperl-mode-hook
                                  css-mode-hook
                                  feature-mode-hook
                                  graphviz-dot-mode-hook
                                  haml-mode-hook
                                  haskell-mode-hook
                                  js-mode-hook
                                  magit-log-edit-mode-hook
                                  makefile-mode-hook
                                  nxml-mode-hook
                                  python-mode-hook
                                  ruby-mode-hook
                                  sgml-mode-hook
                                  sh-mode-hook
                                  yaml-mode-hook)))
       (eldoc-modes-hooks '(c-mode-hook
                            emacs-lisp-mode-hook
                            inferior-emacs-lisp-mode-hook
                            cperl-mode-hook)))

  ;; hl-line
  (mapc
   (lambda (hooks)
     (add-hook hooks 'turn-on-hl-line-mode))
   hl-line-modes-hooks)

  ;; whitespaces
  (mapc
   (lambda (hooks)
     (add-hook hooks 'turn-on-whitespace-mode))
   whitespace-modes-hooks)

  ;; highlight keywords
  (mapc
   (lambda (hooks)
     (add-hook hooks 'turn-on-hl-keywords))
   hl-keywords-modes-hooks)

  ;; drag-stuff mode
  (mapc
   (lambda (hooks)
     (add-hook hooks 'turn-on-drag-stuff-mode))
   drag-stuff-modes-hooks)

  ;; eldoc
  (mapc
   (lambda (hooks)
     (add-hook hooks 'turn-on-eldoc-mode))
   eldoc-modes-hooks))

(defun turn-on-hl-line-mode ()
  (hl-line-mode t))

(defun turn-on-whitespace-mode ()
  (whitespace-mode t))

(defun turn-on-hl-keywords ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(XXX\\|TODO\\|NOTE\\|BUG\\|FIXME\\|WARNING\\|HACK\\|REFACTOR\\|IMPORTANT\\|HERE BE DRAGONS\\):"
      1 font-lock-warning-face t))))


(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(add-hook 'after-save-hook 'desktop-save-in-desktop-dir)

(defun turn-off-word-wrap ()
  (setq word-wrap nil))
(add-hook 'term-mode-hook 'turn-off-word-wrap)

;; (add-hook 'text-mode-hook 'turn-on-orgstruct++)
;; (add-hook 'text-mode-hook 'turn-on-orgtbl)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(add-hook 'help-mode-hook 'turn-on-visual-line-mode)

(add-hook 'find-file-hook 'create-parent-directories-for-file)
(defun create-parent-directories-for-file ()
  "Automatically create file's parent path if it does not exist."
  (let ((dir (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p dir))
               (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
      (make-directory dir t))))


(when (fboundp 'customize-themes)
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (setq custom-safe-themes t)
  (load-theme 'quiet-light)
  (add-hook 'after-make-frame-functions (lambda (frame) (load-file "~/.emacs.d/themes/quiet-light-theme.el"))))
