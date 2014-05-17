;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(save-abbrevs 'silently)
 '(smex-save-file "~/.emacs.d/smex-items"))

(make-variable-buffer-local 'compile-command)

(load "misc/temporary-stuff" 'noerror)
(load "misc/passwords.el.gpg")
