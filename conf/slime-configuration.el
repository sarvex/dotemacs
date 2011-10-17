(setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/HyperSpec/"
      inferior-lisp-program "/usr/bin/sbcl --noinform"
      lisp-indent-function 'common-lisp-indent-function
      slime-autodoc-use-multiline-p t
      slime-header-line-p nil
      slime-net-coding-system 'utf-8-unix
      slime-repl-history-file "~/.emacs.d/slime-history.eld"
      slime-repl-history-remove-duplicates t
      slime-repl-history-size 2000
      slime-repl-history-trim-whitespaces t
      slime-startup-animation nil
      slime-truncate-lines nil)

(setq slime-lisp-implementations
      '((sbcl ("/usr/bin/sbcl" "--noinform") :coding-system utf-8-unix)))


(require 'slime-autoloads)

(eval-after-load 'slime
  '(progn
    (slime-setup '(slime-fancy))

    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

    (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

    ;; Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
    (define-key slime-repl-mode-map (read-kbd-macro paredit-backward-delete-key) nil)

    (define-key slime-repl-mode-map (kbd "C-l") 'recenter-top)))
