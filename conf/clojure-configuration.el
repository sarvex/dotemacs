;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(cider-auto-select-error-buffer t)
 '(cider-repl-tab-command 'indent-for-tab-command)
 '(cider-repl-use-clojure-font-lock t)
 )

(with-eval-after-load 'cider
  (require 'ac-cider)

  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)

  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  )
