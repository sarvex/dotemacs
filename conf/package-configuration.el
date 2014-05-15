;;; -*- lexical-binding: t -*-

(require 'package)

(setq package-enable-at-startup nil)

(mapc
 (lambda (archive)
   (add-to-list 'package-archives archive 'append))
 '(
   ("marmalade" . "http://marmalade-repo.org/packages/")
   ("melpa" . "http://melpa.milkbox.net/packages/")
   ))

(package-initialize)

(unless (file-directory-p package-user-dir)
  (package-refresh-contents))

(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 '(
   rainbow-mode
   lexbind-mode
   scala-mode2
   ensime
   auto-complete
   ))
