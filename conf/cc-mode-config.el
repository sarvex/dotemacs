(require 'cc-mode)
(require 'make-mode)

(setq c-basic-offset 4
      c-strict-syntax-p t
      c-default-style "bsd"
      c-syntactic-indentation t)

(setq compilation-window-height 18)

(define-key c-mode-base-map (kbd "<f9>") 'recompile)
(define-key makefile-gmake-mode-map (kbd "<f9>") 'recompile)


(eval-after-load 'c-eldoc
  '(progn
    ;; add in your commonly used packages/include directories here, for
    ;; example, SDL or OpenGL. this shouldn't slow down cpp, even if
    ;; you've got a lot of them
    (setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../ -I/usr/include/")
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)))
