(custom-set-variables
 '(markdown-command "hsmarkdown")
 '(markdown-coding-system 'utf-8))

(eval-after-load 'markdown-mode
  (quote
   (progn
     (add-hook 'markdown-mode-hook 'turn-on-auto-fill)
     (add-hook 'markdown-mode-hook 'turn-on-orgtbl)
     (add-hook 'markdown-mode-hook 'yas-minor-mode-on)
     (add-hook 'markdown-mode-hook (lambda () (set-fill-column 68)))

     (define-key markdown-mode-map (kbd "<f9>") 'markdown-other-window)

     (add-to-list 'auto-mode-alist (cons (rx not-newline "."
                                             (or "text" "markdown" (and "md" (optional "pp")))
                                             string-end)
                                         'markdown-mode)))))
