;;; -*- lexical-binding: t -*-

(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")
             'append)

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
   ))
