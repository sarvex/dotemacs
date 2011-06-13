(require 'yasnippet)

(setq
 yas/trigger-key "M-["
 ;; yas/trigger-key "<backtab>"
 ;; yas/trigger-key "<tab>"
 yas/choose-tables-first t)

(add-to-list 'yas/snippet-dirs
             (expand-file-name "~/.emacs.d/yasnippet/snippets/my"))
(yas/load-snippet-dirs)

(require 'dropdown-list)

(setq yas/prompt-functions
      '(yas/dropdown-prompt
        yas/ido-prompt
        yas/x-prompt
        yas/completing-prompt
        yas/no-prompt))

;; hook for automatic reloading of changed snippets
(defun my-update-yasnippets-on-save ()
  (when (string-match "/yasnippet/snippets" buffer-file-name)
    (yas/load-snippet-dirs)))

(add-hook 'after-save-hook 'my-update-yasnippets-on-save)

(dolist (hook '(
                c-mode-hook
                css-mode-hook
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
                text-mode-hook
                ))
  (add-hook hook (lambda () (yas/minor-mode 1))))
