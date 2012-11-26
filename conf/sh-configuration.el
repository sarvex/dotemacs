(eval-after-load 'sh-script
  '(define-key sh-mode-map (kbd "<return>") 'reindent-then-newline-and-indent))
