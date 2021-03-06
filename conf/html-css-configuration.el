;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(css-indent-offset 2)
 '(scss-compile-at-save nil))

(with-eval-after-load 'sgml-mode
  (add-hook 'html-mode-hook 'yas-minor-mode-on)
  (add-hook 'html-mode-hook 'emmet-mode)
  (define-key html-mode-map (kbd "M-<tab>") 'emmet-expand-yas))

(add-hook 'css-mode-hook 'emmet-mode)

(mapc
 (lambda (hooks)
   (add-hook hooks 'rainbow-mode))
 '(css-mode-hook sass-mode-hook scss-mode-hook))

(add-to-list 'auto-mode-alist (cons
                               (rx not-newline
                                   "."
                                   (or (and (optional (or "p" "r" "dj"))
                                            "htm"
                                            (optional "l"))
                                       "tpl.php"
                                       (and (char "gj") "sp")
                                       (and "as" (char "cp") "x")
                                       "erb"
                                       "mustache"
                                       "handlebars"
                                       "hbs"
                                       ) string-end)
                               'web-mode))
