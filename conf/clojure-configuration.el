;;; -*- lexical-binding: t -*-

(eval-after-load 'cider
  (quote
   (progn
     (require 'ac-nrepl)

     (add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
     (add-hook 'cider-mode-hook 'ac-nrepl-setup)

     (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

     )))
