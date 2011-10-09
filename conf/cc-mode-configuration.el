(setq c-basic-offset 4
      c-strict-syntax-p t
      c-syntactic-indentation t)

(setq c-default-style
      '((java-mode . "java")
        (awk-mode . "awk")
        (c-mode . "bsd")))

;; add in your commonly used packages/include directories here, for
;; example, SDL or OpenGL. this shouldn't slow down cpp, even if
;; you've got a lot of them
(setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../ -I/usr/include/")

(eval-after-load 'cc-mode
  '(progn
    (define-key c-mode-base-map (kbd "<return>") 'reindent-then-newline-and-indent)
    (define-key c-mode-base-map (kbd "<f9>") 'recompile)))
