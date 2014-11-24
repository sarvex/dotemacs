;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(package-enable-at-startup nil)
 '(package-archives '(
                      ("gnu" . "http://elpa.gnu.org/packages/")
                      ("marmalade" . "http://marmalade-repo.org/packages/")
                      ("melpa" . "http://melpa.org/packages/")
                      ("org" . "http://orgmode.org/elpa/")
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
   ack
   adoc-mode
   async
   auto-complete
   bookmark+
   cider
   clojure-mode
   coffee-mode
   dart-mode
   dired+
   dockerfile-mode
   drag-stuff
   elixir-mode
   emmet-mode
   ensime
   erc-hl-nicks
   fancy-narrow
   feature-mode
   flycheck
   flycheck-ledger
   ghc
   git-commit-mode
   go-autocomplete
   go-eldoc
   go-mode
   graphviz-dot-mode
   haml-mode
   haskell-mode
   helm
   helm-descbinds
   highlight
   ido-ubiquitous
   iedit
   inf-ruby
   ledger-mode
   lexbind-mode
   lua-mode
   macrostep
   magit
   markdown-mode
   miniedit
   openwith
   org-plus-contrib
   paredit
   php-mode
   popup
   project-explorer
   rainbow-mode
   rust-mode
   s
   sass-mode
   scala-mode2
   scratch
   shm
   slim-mode
   slime
   smart-mode-line
   smartparens
   smex
   textile-mode
   tuareg
   twittering-mode
   web-mode
   yaml-mode
   yari
   yasnippet
   ))

(sml/setup)
(sml/apply-theme 'respectful)

(require 'iedit)

(fancy-narrow-mode)

(custom-set-variables
 '(irfc-directory "~/doc/RFC")
 '(irfc-assoc-mode t))

(miniedit-install)

(openwith-mode 1)

(setq ack-command "ag --smart-case -- ")
