;;; -*- lexical-binding: t -*-

(eval-after-load 'haskell-mode
  '(progn
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)))
