;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(css-indent-offset 2)
 '(scss-compile-at-save nil))

(eval-after-load 'sgml-mode
  (quote
   (progn
     (add-hook 'html-mode-hook 'yas-minor-mode-on)
     (add-hook 'html-mode-hook 'emmet-mode)
     (define-key html-mode-map (kbd "M-<tab>") 'emmet-expand-yas))))

(add-hook 'css-mode-hook 'emmet-mode)


(add-hook 'scss-mode-hook
          (lambda ()
            (electric-indent-local-mode -1)))

(mapc
 (lambda (hooks)
   (add-hook hooks 'rainbow-mode))
 '(css-mode-hook sass-mode-hook scss-mode-hook))
