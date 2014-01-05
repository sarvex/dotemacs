;;; -*- lexical-binding: t; no-byte-compile: t -*-

(custom-set-variables
 '(user-full-name "Victor Deryagin")
 '(user-mail-address "vderyagin@gmail.com"))

(require 'ert)
(require 'cl-lib)

(add-to-list 'load-path "~/.emacs.d/dotemacs")

;; (add-to-list 'load-path "~/.emacs.d/slime")
(add-to-list 'load-path "~/.emacs.d/ensime/elisp")

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(load "conf/before-init-configuration")

(load "conf/defuns")
(load "conf/package-configuration")
(load "conf/el-get-configuration")
(load "conf/misc-configuration")
(load "conf/parens-configuration")
(load "conf/erc-configuration")
(load "conf/yasnippet-configuration")
(load "conf/auto-complete-configuration")
(load "conf/ido-configuration")
(load "conf/ibuffer-configuration")
(load "conf/hist-configuration")
(load "conf/cursor-configuration")
(load "conf/cedet-configuration")

(load "conf/cc-mode-configuration")
(load "conf/sh-configuration")
(load "conf/haskell-configuration")
(load "conf/lisps-configuration")
(load "conf/slime-configuration")
(load "conf/ruby-configuration")
(load "conf/scala-configuration")
(load "conf/go-configuration")
(load "conf/rust-configuration")
(load "conf/javascript-configuration")
(load "conf/html-css-configuration")
(load "conf/markdown-configuration")

(load "conf/eval-expr-configuration")
(load "conf/dired-configuration")
(load "conf/file-associations-configuration")
(load "conf/diminish-configuration")
(load "conf/org-configuration")
(load "conf/twitter-configuration")
(load "conf/bookmark-configuration")
(load "conf/eshell-configuration")
(load "conf/git-configuration")
(load "conf/helm-configuration")
(load "conf/projects-configuration")
(load "conf/i18n-configuration")
(load "conf/hook-configuration")
(load "conf/keys-configuration")
