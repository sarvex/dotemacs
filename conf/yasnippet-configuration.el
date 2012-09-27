(setq yas-trigger-key "M-["
      yas-skip-and-clear-key '("C-d")
      yas-also-auto-indent-first-line nil
      yas-good-grace nil
      yas-choose-tables-first t)

(setq yas-prompt-functions
      '(yas-dropdown-prompt
        yas-ido-prompt
        yas-x-prompt
        yas-completing-prompt
        yas-no-prompt))


(eval-after-load 'yasnippet
  '(progn
    (setq yas-snippet-dirs '("~/.emacs.d/yasnippets"))

    (add-hook 'snippet-mode-hook 'dont-require-final-newline)
    (add-hook 'snippet-mode-hook
     (lambda ()
       (add-hook 'after-save-hook 'yas-recompile-all 'append 'make-it-local)
       (add-hook 'after-save-hook 'yas-reload-all 'append 'make-it-local)))))

(defun dont-require-final-newline ()
  (setq require-final-newline nil))

(add-to-list 'auto-mode-alist '("\\.yasnippet\\'" . snippet-mode))

(yas-global-mode t)
