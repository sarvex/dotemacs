;;; -*- lexical-binding: t -*-

(eval-after-load 'haskell-mode
  '(progn
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
    ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
    (add-hook 'haskell-mode-hook 'structured-haskell-mode)
    (add-hook 'haskell-mode-hook
              (lambda () (setq (make-local-variable 'compile-command) "cabal test")))))
