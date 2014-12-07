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
   php-mode
   popup
   project-explorer
   rainbow-mode
   rust-mode
   s
   sass-mode
   scala-mode2
   scratch
   shackle
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
   js2-mode
   skewer-mode
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

(add-hook 'after-init-hook #'global-flycheck-mode)

(shackle-mode)
(custom-set-variables
 '(shackle-rules
   '(("*Async Shell Command*"
      :align right
      :ratio 0.3)
     ("*Shell Command Output*"
      :align right
      :ratio 0.3))))


(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)
