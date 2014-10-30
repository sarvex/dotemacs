;;; -*- lexical-binding: t -*-

(require 'package)

(setq package-enable-at-startup nil)

(mapc
 (lambda (archive)
   (add-to-list 'package-archives archive 'append))
 '(
   ("marmalade" . "http://marmalade-repo.org/packages/")
   ("melpa" . "http://melpa.org/packages/")
   ))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 '(
   aggressive-indent
   ensime
   scala-mode2
   lexbind-mode
   rainbow-mode
   ))
