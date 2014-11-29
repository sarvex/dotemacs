;;; -*- lexical-binding: t -*-

(require 'slime-autoloads)

(custom-set-variables
 '(common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/HyperSpec/")
 '(inferior-lisp-program "/usr/bin/sbcl --noinform --core /usr/lib/sbcl/sbcl.core")
 '(slime-autodoc-use-multiline-p t)
 '(slime-header-line-p nil)
 '(slime-net-coding-system 'utf-8-unix)
 '(slime-repl-history-file "~/.emacs.d/slime-repl-history")
 '(slime-repl-history-remove-duplicates t)
 '(slime-repl-history-size 2000)
 '(slime-repl-history-trim-whitespaces t)
 '(slime-startup-animation nil)
 )

(with-eval-after-load 'slime
  (slime-setup '(slime-fancy)))
