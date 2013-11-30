;;; -*- lexical-binding: t; no-byte-compile: t -*-

(setq
 debug-on-error t
 ;; byte-compile-error-on-warn t
 )

(defvar inferior-lisp-program nil)
(defvar common-lisp-hyperspec-root nil)

(defvar vderyagin/twittering-additional-timelines nil)
(defvar gnus-tmp-group nil)
(defvar local-file nil)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/slime")

(load "dotemacs/conf/defuns")
(load "dotemacs/conf/el-get-configuration")
(load "dotemacs/conf/package-configuration")

(require 'arc-mode)
(require 'cc-mode)
(require 'coffee-mode)
(require 'compile)
(require 'cus-edit)
(require 'em-dirs)
(require 'em-term)
(require 'erc)
(require 'ffap)
(require 'gnus-topic)
(require 'go-mode)
(require 'ibuf-ext)
(require 'ielm)
(require 'image-mode)
(require 'info)
(require 'markdown-mode)
(require 'org-agenda)
(require 'org-capture)
(require 'org-crypt)
(require 'paredit)
(require 'ruby-mode)
(require 'rust-mode)
(require 'savehist)
(require 'scala-mode)
(require 'sgml-mode)
(require 'sh-script)
(require 'speedbar)
(require 'tar-mode)
(require 'twittering-mode)
(require 'wdired)
