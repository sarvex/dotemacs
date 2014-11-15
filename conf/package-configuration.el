;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(package-enable-at-startup nil)
 '(package-archives '(
                      ("gnu" . "http://elpa.gnu.org/packages/")
                      ("marmalade" . "http://marmalade-repo.org/packages/")
                      ("melpa" . "http://melpa.org/packages/")
                      ))
 )

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 '(
   adoc-mode
   auto-complete
   dired+
   dockerfile-mode
   ensime
   go-autocomplete
   graphviz-dot-mode
   helm
   helm-descbinds
   ledger-mode
   lexbind-mode
   lua-mode
   paredit
   rainbow-mode
   rust-mode
   scala-mode2
   slim-mode
   smex
   tuareg
   yaml-mode
   yari
   ))
