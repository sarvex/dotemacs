;;; -*- lexical-binding: t -*-

(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")
             'append)

(package-initialize)

(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 '(
   rainbow-mode
   lexbind-mode
   ))
