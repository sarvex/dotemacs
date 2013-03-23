;;; -*- lexical-binding: t -*-

(setq inferior-lisp-program "/usr/bin/sbcl --noinform"
      common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/HyperSpec/")

(require 'slime-autoloads)

(eval-after-load 'slime
  '(progn
    (slime-setup '(slime-fancy))

    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

    ;; Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
    (define-key slime-repl-mode-map (read-kbd-macro paredit-backward-delete-key) nil)

    (define-key slime-repl-mode-map (kbd "C-l") 'recenter-top)))

(custom-set-variables
 '(slime-autodoc-use-multiline-p t)
 '(slime-header-line-p nil)
 '(slime-net-coding-system 'utf-8-unix)
 '(slime-repl-history-file "~/.emacs.d/slime-history.eld")
 '(slime-repl-history-remove-duplicates t)
 '(slime-repl-history-size 2000)
 '(slime-repl-history-trim-whitespaces t)
 '(slime-startup-animation nil))
