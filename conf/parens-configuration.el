(custom-set-variables
 '(paren-delay 0.2)
 '(paren-highlight-offscreen t))

(paren-activate)


(custom-set-variables
 '(sp-highlight-pair-overlay nil))

(sp-with-modes '(cperl-mode
                 go-mode
                 haskell-mode
                 perl-mode
                 ruby-mode
                 scala-mode
                 sh-mode)
  (sp-local-pair "`" "`"))

(mapc
 (lambda (mode)
   (add-to-list 'sp-ignore-modes-list mode))
 '(lisp-mode
   emacs-lisp-mode
   twittering-mode
   term-mode))

(smartparens-global-mode)


(defun goto-match-paren ()
  "Go to the matching paren if on a paren."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (backward-char 1) (call-interactively 'goto-match-paren))))
