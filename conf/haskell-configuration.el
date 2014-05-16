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

(eval-after-load 'compile
  (quote
   (progn
     (add-to-list 'compilation-error-regexp-alist 'haskell-doctest)
     (add-to-list 'compilation-error-regexp-alist-alist
                  (list 'haskell-doctest
                        (rx line-start
                            "### Failure in "
                            (group (+ not-newline) "." (optional "l") "hs") ; file name
                            ":"
                            (group (+ (char digit)))      ; line number
                            ":")
                        1 2)))))
