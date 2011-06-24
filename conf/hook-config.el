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
                             '(bookmark-bmenu-mode-hook
                               speedbar-mode-hook
                               ibuffer-mode-hook
                               twittering-mode-hook
                               org-agenda-mode-hook
                               irfc-mode-hook
                               gnus-article-mode-hook
                               gnus-group-mode-hook)))
       (autopair-modes-hooks (append
                              conf-modes-hooks
                              '(c-mode-common-hook
                                python-mode-hook
                                inf-ruby-mode-hook
                                js2-mode-hook
                                js-mode-hook
                                ruby-mode-hook
                                haskell-mode-hook
                                haml-mode-hook
                                css-mode-hook
                                cperl-mode-hook
                                sh-mode-hook
                                graphviz-dot-mode-hook
                                makefile-mode-hook)))
       (whitespace-modes-hooks (append
                                conf-modes-hooks
                                '(haskell-mode-hook
                                  haml-mode-hook
                                  emacs-lisp-mode-hook
                                  lisp-mode-hook
                                  c-mode-common-hook
                                  python-mode-hook
                                  cperl-mode-hook
                                  sh-mode-hook
                                  sgml-mode-hook
                                  nxml-mode-hook
                                  js2-mode-hook
                                  markdown-mode-hook
                                  js-mode-hook
                                  ruby-mode-hook
                                  css-mode-hook
                                  graphviz-dot-mode-hook
                                  lisp-interaction-mode-hook
                                  change-log-mode-hook
                                  makefile-mode-hook)))
       (hl-keywords-modes-hooks (append
                                 conf-modes-hooks
                                 '(haskell-mode-hook
                                   emacs-lisp-mode-hook
                                   lisp-mode-hook
                                   c-mode-common-hook
                                   python-mode-hook
                                   cperl-mode-hook
                                   sh-mode-hook
                                   nxml-mode-hook
                                   sgml-mode-hook
                                   haml-mode-hook
                                   ruby-mode-hook
                                   js2-mode-hook
                                   css-mode-hook
                                   lisp-interaction-mode-hook
                                   graphviz-dot-mode-hook
                                   makefile-mode-hook))))

  ;; hl-line
  (dolist (hook hl-line-modes-hooks)
    (add-hook hook (lambda () (hl-line-mode t))))

  ;; automatic matching paren insertion
  (dolist (hook autopair-modes-hooks)
    (add-hook hook (lambda () (autopair-mode t))))

  ;; whitespaces
  (dolist (hook whitespace-modes-hooks)
    (add-hook hook (lambda () (whitespace-mode t))))

  ;; highlight keywords
  (dolist (hook hl-keywords-modes-hooks)
    (add-hook hook
              (lambda ()
                (font-lock-add-keywords
                 nil
                 '(("\\<\\(XXX\\|TODO\\|NOTE\\|BUG\\|FIXME\\|HACK\\|REFACTOR\\|IMPORTANT\\|HERE BE DRAGONS\\):"
                    1 font-lock-warning-face t)))))))

(add-hook 'before-save-hook
          (lambda () (delete-trailing-whitespace)))

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(add-hook 'after-save-hook 'desktop-save-in-desktop-dir)

(add-hook 'term-mode-hook (lambda () (setq word-wrap nil)))

;; (add-hook 'text-mode-hook 'turn-on-orgstruct++)
;; (add-hook 'text-mode-hook 'turn-on-orgtbl)
(add-hook 'text-mode-hook (lambda () (visual-line-mode t)))

(add-hook 'help-mode-hook (lambda () (visual-line-mode t)))

(add-hook 'prog-mode-hook 'yas/minor-mode-on)
