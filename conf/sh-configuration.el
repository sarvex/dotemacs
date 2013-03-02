(custom-set-variables
 '(sh-basic-offset 2))

(eval-after-load 'sh-script
  '(progn
    (define-key sh-mode-map (kbd "<f9>") 'executable-interpret)
    (define-key sh-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)))
