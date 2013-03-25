;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(paren-delay 0.2)
 '(paren-highlight-offscreen t))

(paren-activate)


(custom-set-variables
 '(sp-highlight-pair-overlay nil))


(sp-with-modes '(magit-log-edit-mode)
  (sp-local-pair "`" "'"))

(sp-with-modes '(clojure-mode
                 common-lisp-mode
                 emacs-lisp-mode
                 inferior-emacs-lisp-mode
                 lisp-interaction-mode
                 lisp-mode
                 scheme-mode
                 slime-repl-mode)
  ;; paredit handles those
  (sp-local-pair "(" nil :actions nil)
  (sp-local-pair "[" nil :actions nil)
  (sp-local-pair "\"" nil :actions nil))

(mapc
 (lambda (mode)
   (add-to-list 'sp-ignore-modes-list mode))
 '(twittering-mode
   term-mode))

(smartparens-global-mode)

(eval-after-load 'paredit
  '(define-key paredit-mode-map (kbd "C-w") 'paredit-backward-kill-word))

(mapc
 (lambda (hooks)
   (add-hook hooks 'enable-paredit-mode))
 '(emacs-lisp-mode-hook
   clojure-mode-hook
   scheme-mode-hook
   inferior-scheme-mode-hook
   lisp-mode-hook
   lisp-interaction-mode-hook
   slime-repl-mode-hook
   ielm-mode-hook))

(defun goto-match-paren ()
  "Go to the matching paren if on a paren."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (backward-char 1) (call-interactively 'goto-match-paren))))
