;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(js-indent-level 2)
 '(coffee-tab-width 2))

(add-to-list 'auto-mode-alist (cons (rx not-newline ".js" string-end) 'js2-mode))
(add-to-list 'auto-mode-alist (cons (rx ".bowerrc" string-end) 'js-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
