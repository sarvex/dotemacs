;;; -*- lexical-binding: t; no-byte-compile: t -*-

(custom-set-variables
 '(user-full-name "Victor Deryagin")
 '(user-mail-address "vderyagin@gmail.com"))

(require 'ert)
(require 'cl-lib)

(add-to-list 'load-path "~/.emacs.d")

(add-to-list 'load-path "~/.emacs.d/slime")
(add-to-list 'load-path "~/.emacs.d/ensime/elisp")

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(load "dotemacs/conf/before-init-configuration")

(load "dotemacs/conf/defuns")
(load "dotemacs/conf/elpa-configuration")
(load "dotemacs/conf/el-get-configuration")
(load "dotemacs/conf/misc-configuration")
(load "dotemacs/conf/parens-configuration")
(load "dotemacs/conf/jabber-configuration")
(load "dotemacs/conf/erc-configuration")
(load "dotemacs/conf/yasnippet-configuration")
(load "dotemacs/conf/auto-complete-configuration")
(load "dotemacs/conf/ido-configuration")
(load "dotemacs/conf/ibuffer-configuration")
(load "dotemacs/conf/hist-configuration")
(load "dotemacs/conf/cursor-configuration")
(load "dotemacs/conf/cedet-configuration")

(load "dotemacs/conf/cc-mode-configuration")
(load "dotemacs/conf/sh-configuration")
(load "dotemacs/conf/haskell-configuration")
(load "dotemacs/conf/lisps-configuration")
(load "dotemacs/conf/slime-configuration")
(load "dotemacs/conf/ruby-configuration")
(load "dotemacs/conf/scala-configuration")
(load "dotemacs/conf/go-configuration")
(load "dotemacs/conf/rust-configuration")
(load "dotemacs/conf/javascript-configuration")
(load "dotemacs/conf/html-css-configuration")

(load "dotemacs/conf/dired-configuration")
(load "dotemacs/conf/file-associations-configuration")
(load "dotemacs/conf/diminish-configuration")
(load "dotemacs/conf/org-configuration")
(load "dotemacs/conf/twitter-configuration")
(load "dotemacs/conf/bookmark-configuration")
(load "dotemacs/conf/eshell-configuration")
(load "dotemacs/conf/git-configuration")
(load "dotemacs/conf/helm-configuration")
(load "dotemacs/conf/projects-configuration")
(load "dotemacs/conf/i18n-configuration")
(load "dotemacs/conf/hook-configuration")
(load "dotemacs/conf/keys-configuration")
