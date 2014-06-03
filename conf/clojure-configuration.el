;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(cider-auto-select-error-buffer t)
 '(cider-repl-tab-command 'indent-for-tab-command)
 '(cider-repl-use-clojure-font-lock t)
 )

(eval-after-load 'cider
  (quote
   (progn
     (require 'ac-nrepl)

     (add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
     (add-hook 'cider-mode-hook 'ac-nrepl-setup)

     (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

     )))
