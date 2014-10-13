;;; -*- lexical-binding: t -*-

(with-eval-after-load 'align

  (add-to-list 'align-rules-list
               '(haskell-types
                 (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
                 (modes . '(haskell-mode literate-haskell-mode))))

  (add-to-list 'align-rules-list
               '(haskell-assignment
                 (regexp . "\\(\\s-+\\)=\\s-+")
                 (modes . '(haskell-mode literate-haskell-mode))))

  (add-to-list 'align-rules-list
               '(haskell-arrows
                 (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
                 (modes . '(haskell-mode literate-haskell-mode))))

  (add-to-list 'align-rules-list
               '(haskell-left-arrows
                 (regexp . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+")
                 (modes . '(haskell-mode literate-haskell-mode))))

  (add-to-list 'align-rules-list
               '(ruby-assignment-or-hashrockets
                 (regexp . "\\(\\s-+\\)=\\(\\s-+\\|\\(>\\s-+\\)\\)")
                 (modes . '(ruby-mode))))

  (add-to-list 'align-rules-list
               '(ruby-symbol-hash-new-syntax
                 (regexp . ".:\\(\\s-+\\).")
                 (modes . '(ruby-mode))))

  )
