;;; -*- lexical-binding: t -*-

(eval-after-load 'haskell-mode
  (quote
   (progn

     (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
     ;; (add-hook 'haskell-mode-hook 'structured-haskell-mode)

     (add-hook 'haskell-mode-hook
               (lambda () (set (make-local-variable 'compile-command) "cabal test")))

     (define-key haskell-mode-map (kbd "<f8>") 'haskell-navigate-imports)

     )))
