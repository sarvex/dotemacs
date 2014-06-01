;;; -*- lexical-binding: t -*-

(show-paren-mode)

(custom-set-variables
 '(sp-highlight-pair-overlay nil))


(sp-with-modes '(magit-log-edit-mode)
  (sp-local-pair "`" "'"))

(sp-with-modes '(
                 cider-repl-mode
                 clojure-mode
                 common-lisp-mode
                 emacs-lisp-mode
                 inferior-emacs-lisp-mode
                 lisp-interaction-mode
                 lisp-mode
                 scheme-mode
                 slime-repl-mode
                 )
  ;; paredit handles those
  (sp-local-pair "(" nil :actions nil)
  (sp-local-pair "[" nil :actions nil)
  (sp-local-pair "\"" nil :actions nil))

(mapc
 (lambda (mode)
   (add-to-list 'sp-ignore-modes-list mode))
 '(twittering-mode
   term-mode))

(defadvice wdired-finish-edit (before dired-turn-smartparens-mode-off activate)
  "Turn off `smartparens-mode' when switching from `wdired-mode' to `dired-mode'."
  (smartparens-mode -1))

(smartparens-global-mode)

(eval-after-load 'paredit
  '(define-key paredit-mode-map (kbd "C-w") 'paredit-backward-kill-word))

(mapc
 (lambda (hooks)
   (add-hook hooks 'enable-paredit-mode))
 '(
   cider-repl-mode-hook
   clojure-mode-hook
   emacs-lisp-mode-hook
   ielm-mode-hook
   inferior-scheme-mode-hook
   lisp-interaction-mode-hook
   lisp-mode-hook
   scheme-mode-hook
   slime-repl-mode-hook
   ))

(defun goto-match-paren ()
  "Go to the matching paren if on a paren."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (backward-char 1) (call-interactively 'goto-match-paren))))
