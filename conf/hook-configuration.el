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
                             ;; conf-modes-hooks
                             '(archive-mode-hook
                               bookmark-bmenu-mode-hook
                               gnus-article-mode-hook
                               gnus-group-mode-hook
                               ibuffer-mode-hook
                               irfc-mode-hook
                               speedbar-mode-hook
                               tar-mode-hook
                               twittering-mode-hook)))
       (autopair-modes-hooks (append
                              conf-modes-hooks
                              '(c-mode-common-hook
                                coffee-mode-hook
                                cperl-mode-hook
                                sgml-mode-hook
                                css-mode-hook
                                feature-mode-hook
                                graphviz-dot-mode-hook
                                haml-mode-hook
                                haskell-mode-hook
                                inf-ruby-mode-hook
                                js-mode-hook
                                makefile-mode-hook
                                python-mode-hook
                                ruby-mode-hook
                                sh-mode-hook)))
       (whitespace-modes-hooks (append
                                conf-modes-hooks
                                '(c-mode-common-hook
                                  change-log-mode-hook
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
                                  markdown-mode-hook
                                  nxml-mode-hook
                                  python-mode-hook
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
       (eldoc-modes-hooks '(;; python-mode-hook
                            c-mode-hook
                            emacs-lisp-mode-hook
                            inferior-emacs-lisp-mode-hook
                            cperl-mode-hook)))

  ;; hl-line
  (dolist (hook hl-line-modes-hooks)
    (add-hook hook 'my-turn-on-hl-line-mode))

  ;; automatic matching paren insertion
  (dolist (hook autopair-modes-hooks)
    (add-hook hook 'my-turn-on-autopair-mode))

  ;; whitespaces
  (dolist (hook whitespace-modes-hooks)
    (add-hook hook 'my-turn-on-whitespace-mode))

  ;; highlight keywords
  (dolist (hook hl-keywords-modes-hooks)
    (add-hook hook 'my-turn-on-hl-keywords))

  ;; drag-stuff mode
  (dolist (hook drag-stuff-modes-hooks)
    (add-hook hook 'turn-on-drag-stuff-mode))

  ;; eldoc
  (dolist (hook eldoc-modes-hooks)
    (add-hook hook 'turn-on-eldoc-mode)))

(defun my-turn-on-hl-line-mode ()
  (hl-line-mode t))

(defun my-turn-on-autopair-mode ()
  (autopair-mode t))

(defun my-turn-on-whitespace-mode ()
  (whitespace-mode t))

(defun my-turn-on-hl-keywords ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(XXX\\|TODO\\|NOTE\\|BUG\\|FIXME\\|WARNING\\|HACK\\|REFACTOR\\|IMPORTANT\\|HERE BE DRAGONS\\):"
      1 font-lock-warning-face t))))


(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(add-hook 'after-save-hook 'desktop-save-in-desktop-dir)

(add-hook 'term-mode-hook 'my-turn-off-word-wrap)
(defun my-turn-off-word-wrap ()
  (setq word-wrap nil))

;; (add-hook 'text-mode-hook 'turn-on-orgstruct++)
;; (add-hook 'text-mode-hook 'turn-on-orgtbl)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(add-hook 'help-mode-hook 'turn-on-visual-line-mode)

(add-hook 'find-file-hook 'my-create-parent-directories-for-file)
(defun my-create-parent-directories-for-file ()
  "Automatically create file's parent path if it does not exist."
  (let ((dir (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p dir))
               (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
      (make-directory dir t))))


(add-hook 'after-make-frame-functions
          (lambda (frame)
            (when (fboundp 'customize-themes)
              (load-file "~/.emacs.d/themes/quiet-light-theme.el"))))
