;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(js-indent-level 2)
 '(coffee-tab-width 2))

(add-to-list 'auto-mode-alist (cons (rx ".bowerrc" string-end) 'js-mode))
(add-to-list 'interpreter-mode-alist '("node" . js-mode))
(add-to-list 'auto-mode-alist (cons (rx not-newline "." (or "hbs" "handlebars")) 'handlebars-mode))
