(setq c-basic-offset 4
      c-strict-syntax-p t
      c-syntactic-indentation t)

(setq c-default-style
      '((java-mode . "java")
        (awk-mode . "awk")
        (c-mode . "bsd")))

(eval-after-load 'cc-mode
  '(progn
    (define-key c-mode-base-map (kbd "<return>") 'reindent-then-newline-and-indent)
    (define-key c-mode-base-map (kbd "<f9>") 'recompile)))
