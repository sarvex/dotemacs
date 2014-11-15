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
   ac-cider-compliment
   adoc-mode
   auto-complete
   cider
   coffee-mode
   dart-mode
   dired+
   dockerfile-mode
   elixir-mode
   ensime
   go-autocomplete
   go-eldoc
   go-mode
   graphviz-dot-mode
   helm
   helm-descbinds
   ledger-mode
   lexbind-mode
   lua-mode
   markdown-mode
   paredit
   popup
   rainbow-mode
   rust-mode
   sass-mode
   scala-mode2
   slim-mode
   smex
   tuareg
   yaml-mode
   yari
   ))
