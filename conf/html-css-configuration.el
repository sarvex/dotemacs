(setq css-indent-offset 2)

(setq scss-compile-at-save nil)

(setq js-indent-level 2)

(setq coffee-js-mode 'js-mode)

(eval-after-load 'sgml-mode
  '(define-key sgml-mode-map (kbd "<return>") 'reindent-then-newline-and-indent))

(eval-after-load 'haml-mode
  '(define-key haml-mode-map (kbd "<return>") 'newline-and-indent))

(dolist (hook '(css-mode-hook
                sass-mode-hook
                scss-mode-hook))
  (add-hook hook (lambda () (rainbow-mode))))

(eval-after-load 'js
  '(define-key js-mode-map (kbd "<return>") 'reindent-then-newline-and-indent))

(add-to-list 'interpreter-mode-alist '("node" . js-mode))
