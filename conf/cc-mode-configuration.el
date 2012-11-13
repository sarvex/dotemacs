(custom-set-variables
 '(c-basic-offset 4)
 '(c-strict-syntax-p t)
 '(c-syntactic-indentation t)
 '(c-default-style '((java-mode . "java")
                     (awk-mode . "awk")
                     (c-mode . "bsd"))))

(eval-after-load 'cc-mode
  '(progn
    (define-key c-mode-base-map (kbd "<f9>") 'compile)
    (define-key c-mode-base-map (kbd "<return>") 'reindent-then-newline-and-indent)))
