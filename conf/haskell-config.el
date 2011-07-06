;; (setq haskell-font-lock-symbols t)

(defun pretty-lambdas-haskell ()
  (font-lock-add-keywords
   nil `((,(concat "(?\\(" (regexp-quote "\\") "\\)")
           (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                     ,(make-char 'greek-iso8859-7 107))
                     nil))))))

;; (add-hook 'haskell-mode-hook 'pretty-lambdas-haskell)
