;;; -*- lexical-binding: t; no-byte-compile: t -*-

(setq
 debug-on-error t
 byte-compile-error-on-warn t
 smex-save-file "~/.emacs.d/smex-items"
 )

(defvar inferior-lisp-program nil)
(defvar common-lisp-hyperspec-root nil)

(defvar vderyagin/twittering-additional-timelines nil)
(defvar gnus-tmp-group nil)
(defvar local-file nil)

(set-face-attribute 'default nil :height 100)

(add-to-list 'load-path "~/.emacs.d/dotemacs")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(load "conf/defuns")
(load "conf/el-get-configuration")
(load "conf/package-configuration")

(require 'go-oracle "oracle")

(mapc #'require
      '(
        align
        auto-complete-config
        bookmark+
        cus-edit
        em-dirs
        em-term
        erc
        gnus-topic
        go-mode
        haskell-cabal
        ibuf-ext
        ielm
        image-mode
        inferior-slime
        info
        ledger-mode
        markdown-mode
        org-agenda
        org-capture
        org-crypt
        paredit
        project-explorer
        rspec-simple
        ruby-mode
        rust-mode
        savehist
        scala-mode2
        sgml-mode
        sh-script
        slime-repl
        speedbar
        tar-mode
        twittering-mode
        wdired
        yasnippet
        ))
