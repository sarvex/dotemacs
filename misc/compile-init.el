;;; -*- lexical-binding: t; no-byte-compile: t -*-

(setq
 debug-on-error t
 ;; byte-compile-error-on-warn t
 )

(defvar inferior-lisp-program nil)
(defvar common-lisp-hyperspec-root nil)

(defvar gnus-tmp-group nil)
(defvar local-file nil)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/slime")

(load "dotemacs/conf/defuns")
(load "dotemacs/conf/el-get-configuration")
(load "dotemacs/conf/package-configuration")

(require 'coffee-mode)
(require 'compile)
(require 'ibuf-ext)
(require 'org-agenda)
(require 'savehist)
(require 'twittering-mode)
