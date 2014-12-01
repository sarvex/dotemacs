(custom-set-variables
 '(markdown-command "hsmarkdown")
 '(markdown-coding-system 'utf-8))

(with-eval-after-load 'markdown-mode
  (add-hook 'markdown-mode-hook 'turn-on-orgtbl)
  (add-hook 'markdown-mode-hook 'yas-minor-mode-on)

  (define-key markdown-mode-map (kbd "<f9>") 'markdown-other-window)

  (add-to-list 'auto-mode-alist (cons (rx not-newline "."
                                          (or "text" "markdown" (and "md" (optional "pp")))
                                          string-end)
                                      'markdown-mode)))
