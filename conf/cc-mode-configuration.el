(setq c-basic-offset 4
      c-strict-syntax-p t
      c-default-style "bsd"
      c-syntactic-indentation t)

(setq compilation-window-height 18)

;; add in your commonly used packages/include directories here, for
;; example, SDL or OpenGL. this shouldn't slow down cpp, even if
;; you've got a lot of them
(setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../ -I/usr/include/")

(eval-after-load 'cc-mode
  '(progn
    (define-key c-mode-base-map (kbd "<f9>") 'recompile)
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)))

(eval-after-load 'make-mode
  '(dolist (mode-map '(makefile-automake-mode-map
                       makefile-bsdmake-mode-map
                       makefile-gmake-mode-map
                       makefile-imake-mode-map
                       makefile-makepp-mode-map))
    define-key mode-map (kbd "<f9>") 'recompile))



