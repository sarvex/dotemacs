;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(custom-file "~/.emacs.d/custom.el")
 '(enable-local-variables :all)
 '(save-abbrevs 'silently)
 '(smex-save-file "~/.emacs.d/smex-items"))

(make-variable-buffer-local 'compile-command)

(load "misc/temporary-stuff" 'noerror)
