;;; -*- lexical-binding: t; no-byte-compile: t -*-

(setq
 debug-on-error t
 ;; byte-compile-error-on-warn t
 smex-save-file "~/.emacs.d/smex-items"
 )

(defvar inferior-lisp-program nil)
(defvar common-lisp-hyperspec-root nil)

(defvar vderyagin/twittering-additional-timelines nil)
(defvar gnus-tmp-group nil)
(defvar local-file nil)

(add-to-list 'load-path "~/.emacs.d/dotemacs")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(load "conf/defuns")
(load "conf/el-get-configuration")
(load "conf/package-configuration")

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
(require 'scala-mode2)
(require 'sgml-mode)
(require 'sh-script)
(require 'speedbar)
(require 'tar-mode)
(require 'twittering-mode)
(require 'wdired)
