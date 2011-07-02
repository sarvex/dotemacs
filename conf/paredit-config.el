(dolist (mode-hook '(emacs-lisp-mode-hook
                     clojure-mode-hook
                     scheme-mode
                     lisp-mode-hook
                     lisp-interaction-mode-hook
                     slime-repl-mode-hook
                     ielm-mode-hook))
  (add-hook mode-hook (lambda () (paredit-mode t))))

(eval-after-load 'slime
  '(progn
    ;; Stop SLIME's REPL from grabbing DEL,
    ;; which is annoying when backspacing over a '('
    (defun override-slime-repl-bindings-with-paredit ()
      (define-key slime-repl-mode-map
          (read-kbd-macro paredit-backward-delete-key) nil))
    (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)))

