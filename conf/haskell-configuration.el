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

     (require 'align)

     (add-to-list 'align-rules-list
                  '(haskell-types
                    (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
                    (modes quote (haskell-mode literate-haskell-mode))))
     (add-to-list 'align-rules-list
                  '(haskell-assignment
                    (regexp . "\\(\\s-+\\)=\\s-+")
                    (modes quote (haskell-mode literate-haskell-mode))))
     (add-to-list 'align-rules-list
                  '(haskell-arrows
                    (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
                    (modes quote (haskell-mode literate-haskell-mode))))
     (add-to-list 'align-rules-list
                  '(haskell-left-arrows
                    (regexp . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+")
                    (modes quote (haskell-mode literate-haskell-mode))))
     )))
