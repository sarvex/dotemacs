;; (setq haskell-font-lock-symbols t)

(defun pretty-lambdas-haskell ()
  (font-lock-add-keywords
   nil `((,(concat "(?\\(" (regexp-quote "\\") "\\)")
           (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                     ,(make-char 'greek-iso8859-7 107))
                     nil))))))

(eval-after-load 'haskell-mode
  (quote
   (progn
     ;; (add-hook 'haskell-mode-hook 'pretty-lambdas-haskell)
     (add-hook 'haskell-mode-hook (lambda () (subword-mode 1)))
     (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
     ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
     ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
     )))
