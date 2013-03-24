;;; -*- lexical-binding: t; no-byte-compile: t -*-

(setq
 debug-on-error t
 ;; byte-compile-error-on-warn t
 )

(defvar vderyagin/poshta.te.ua-username)
(defvar vderyagin/poshta.te.ua-password)

(defvar vderyagin/github-username)
(defvar vderyagin/github-password)

(defvar vderyagin/jabber-org-jid)
(defvar vderyagin/jabber-org-password)

(defvar inferior-lisp-program nil)
(defvar common-lisp-hyperspec-root nil)

(defvar gnus-tmp-group nil)
(defvar local-file nil)

(add-to-list 'load-path "~/.emacs.d/dotemacs/conf")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/slime")


(load "el-get-configuration")
(load "elpa-configuration")
(load "functions-configuration")

(require 'coffee-mode)
(require 'flymake)
(require 'ibuf-ext)
(require 'org-agenda)
(require 'savehist)
(require 'twittering-mode)
