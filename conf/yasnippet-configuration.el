(setq
 yas/trigger-key "M-["
 ;; yas/trigger-key "<backtab>"
 ;; yas/trigger-key "<tab>"
 yas/choose-tables-first t)

(setq yas/prompt-functions
      '(yas/dropdown-prompt
        yas/ido-prompt
        yas/x-prompt
        yas/completing-prompt
        yas/no-prompt))

(eval-after-load 'yasnippet
  '(progn
    (require 'dropdown-list)
    (add-to-list 'yas/snippet-dirs (expand-file-name "~/.emacs.d/yasnippet/snippets/my"))
    (yas/load-snippet-dirs)))

;; hook for automatic reloading of changed snippets
(defun my-update-yasnippets-on-save ()
  (when (string-match "/yasnippet/snippets" buffer-file-name)
    (yas/load-snippet-dirs)))

(add-hook 'after-save-hook 'my-update-yasnippets-on-save)

(dolist (hook '(c-mode-hook
                css-mode-hook
                java-mode-hook
                emacs-lisp-mode-hook
                erlang-mode-hook
                html-mode-hook
                markdown-mode-hook
                nxml-mode-hook
                perl-mode-hook
                python-mode-hook
                rst-mode-hook
                ruby-mode-hook
                scala-mode-hook
                snippet-mode-hook
                text-mode-hook))
  (add-hook hook (lambda () (yas/minor-mode t))))

(add-to-list 'auto-mode-alist '("\\.yasnippet\\'" . snippet-mode))
