(setq c-basic-offset 4
      c-strict-syntax-p t
      c-default-style "bsd"
      c-syntactic-indentation t)

;; add in your commonly used packages/include directories here, for
;; example, SDL or OpenGL. this shouldn't slow down cpp, even if
;; you've got a lot of them
(setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../ -I/usr/include/")

(eval-after-load 'cc-mode
  '(define-key c-mode-base-map (kbd "<f9>") 'recompile))
