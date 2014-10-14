;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(custom-file "~/.emacs.d/custom.el")
 '(custom-safe-themes t)
 '(enable-local-variables :all)
 '(save-abbrevs 'silently)
 '(smex-save-file "~/.emacs.d/smex-items"))

(make-variable-buffer-local 'compile-command)

(load "misc/temporary-stuff" 'noerror)
