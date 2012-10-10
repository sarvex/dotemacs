(custom-set-variables
 '(yas-trigger-key "M-[")
 '(yas-skip-and-clear-key '("C-d"))
 '(yas-also-auto-indent-first-line nil)
 '(yas-good-grace nil)
 '(yas-choose-tables-first t)
 '(yas-snippet-dirs '("~/.emacs.d/yasnippets"))
 '(yas-prompt-functions '(yas-dropdown-prompt
                          yas-ido-prompt
                          yas-x-prompt
                          yas-completing-prompt
                          yas-no-prompt)))

(eval-after-load 'yasnippet
  (quote
   (progn
     (require 'dropdown-list)

     (add-hook 'snippet-mode-hook
               (lambda ()
                 (setq require-final-newline nil)
                 (add-hook 'after-save-hook 'yas-recompile-all 'append 'make-it-local)
                 (add-hook 'after-save-hook 'yas-reload-all 'append 'make-it-local))))))

(add-to-list 'auto-mode-alist '("\\.yasnippet\\'" . snippet-mode))

(yas-global-mode t)
