(setq
 yas/trigger-key "M-["
 ;; yas/trigger-key "<backtab>"
 ;; yas/trigger-key "<tab>"
 yas/skip-and-clear-key '("C-d")
 yas/also-auto-indent-first-line nil
 yas/good-grace nil
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
    (setq yas/snippet-dirs '("~/.emacs.d/yasnippets"))
    (yas/load-snippet-dirs)
    (add-hook 'snippet-mode-hook 'my-snippet-mode-hook)))

(defun my-snippet-mode-hook ()
  (setq require-final-newline nil))

;; hook for automatic reloading of changed snippets
(defun my-update-yasnippets-on-save ()
  (when (eq major-mode 'snippet-mode)
    (yas/load-snippet-dirs)))

(add-hook 'after-save-hook 'my-update-yasnippets-on-save)

(dolist (hook '(c-mode-hook
                css-mode-hook
                emacs-lisp-mode-hook
                erlang-mode-hook
                feature-mode-hook
                html-mode-hook
                java-mode-hook
                js-mode-hook
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
