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
   emmet-mode
   ensime
   go-autocomplete
   go-eldoc
   go-mode
   graphviz-dot-mode
   helm
   helm-descbinds
   iedit
   ledger-mode
   lexbind-mode
   lua-mode
   macrostep
   markdown-mode
   paredit
   popup
   project-explorer
   rainbow-mode
   rust-mode
   s
   sass-mode
   scala-mode2
   slim-mode
   smex
   textile-mode
   tuareg
   twittering-mode
   web-mode
   yaml-mode
   yari
   yasnippet
   ))
