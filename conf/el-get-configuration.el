;;; -*- lexical-binding: t -*-

(require 'el-get)

(custom-set-variables
 '(el-get-notify-type 'message)
 '(el-get-sources
   '(el-get

     bookmark+
     cider
     clojure-mode
     diminish
     dired+
     drag-stuff
     expand-region
     ghc-mod
     gist
     gnus
     graphviz-dot-mode
     haml-mode
     helm
     helm-descbinds
     lua-mode
     magit
     markdown-mode
     org-mode
     paredit
     php-mode
     po-mode
     rcodetools
     rdebug
     redshank
     rhtml-mode
     s
     sass-mode
     scala-mode
     scratch
     slim-mode
     slime
     smex
     structured-haskell-mode
     textile-mode
     tuareg-mode
     wtf
     yaml-mode

     (:name erc-highlight-nicknames :lazy t)
     (:name iedit :lazy t)
     (:name io-mode :lazy t)
     (:name quack :lazy t)
     (:name rust-mode :lazy t)
     (:name scss-mode :lazy t)
     (:name twittering-mode :lazy t)
     (:name yari :lazy t)

     (:name coffee-mode
            :lazy t
            :post-init nil)

     (:name openwith
            :description "Open files with external programs"
            :type hg
            :url "https://bitbucket.org/jpkotta/openwith"
            :features openwith
            :after (openwith-mode 1))

     (:name inf-ruby
            :type http
            :url "https://raw.github.com/ruby/ruby/trunk/misc/inf-ruby.el"
            :features nil)

     (:name handlebars-mode
            :type github
            :pkgname "danielevans/handlebars-mode")

     (:name yasnippet
            :features yasnippet
            :compile ("dropdown-list.el" "yasnippet.el")
            :post-init nil)

     (:name multi-term
            :type emacsmirror)

     (:name eval-expr
            :type emacsmirror)

     (:name irfc
            :type emacswiki
            :before (progn
                      (setq irfc-directory "~/doc/RFC"
                            irfc-assoc-mode t)
                      (add-to-list 'auto-mode-alist '("/rfc[0-9]+\\.txt\\'" . irfc-mode))))

     (:name auto-complete
            :features auto-complete-config)

     (:name feature-mode
            :type github
            :pkgname "michaelklishin/cucumber.el"
            :after (setq
                    feature-default-language "en"
                    feature-default-i18n-file (expand-file-name "feature-mode/i18n.yml" el-get-dir)))

     (:name pomodoro
            :type github
            :pkgname "vderyagin/pomodoro.el"
            :after (setq pomodoro-icon (expand-file-name "pomodoro/pomodoro_technique.png" el-get-dir)))

     (:name ido-ubiquitous
            :type github
            :pkgname "DarwinAwardWinner/ido-ubiquitous")

     (:name rake.el
            :type github
            :pkgname "vderyagin/rake.el")

     (:name ack
            :type github
            :pkgname "leoliu/ack-el"
            :features nil
            :after (setq ack-command "ag --smart-case "))

     (:name go-autocomplete
            :type http
            :url "https://raw.github.com/nsf/gocode/master/emacs/go-autocomplete.el")

     (:name go-eldoc
            :type github
            :pkgname "syohex/emacs-go-eldoc")

     (:name smartparens
            :features smartparens-config)

     (:name go-mode
            :type github
            :pkgname "dominikh/go-mode.el")

     (:name dart-mode
            :type github
            :pkgname "nex3/dart-mode")

     (:name miniedit
            :type emacsmirror
            :after (miniedit-install))

     (:name flycheck
            :build (("make" "info"))
            :info "doc"
            :after (add-hook 'after-init-hook #'global-flycheck-mode))

     (:name macrostep
            :type github
            :pkgname "joddie/macrostep")

     (:name multiple-cursors
            :features nil
            :before (setq mc/list-file "~/.emacs.d/multiple-cursors-lists"))

     (:name scriptify
            :type github
            :pkgname "vderyagin/scriptify"
            :after (setq scriptify-scripts-directory (expand-file-name "~/bin/")))

     (:name palimpsest-mode
            :post-init nil)

     (:name emmet-mode
            :type github
            :pkgname "smihica/emmet")

     (:name elixir-mode
            :type github
            :pkgname "elixir-lang/emacs-elixir")

     (:name haskell-mode
            :load "haskell-mode-autoloads.el"
            :post-init nil)

     (:name es-windows
            :type github
            :pkgname "sabof/es-windows")

     (:name project-explorer
            :lazy t
            :depends (es-lib helm es-windows)
            :after (setq pe/omit-regex
                         (rx (or (and string-start "#")
                                 (and "~" string-end)
                                 (and ".elc" string-end)
                                 (and string-start ".git" (optional "keep") string-end)))))

     (:name fancy-narrow
            :type github
            :pkgname "bruce-connor/fancy-narrow"
            :after (fancy-narrow-mode))

     (:name projectur
            :type github
            :pkgname "vderyagin/projectur"))))

(load (file-name-sans-extension el-get-autoload-file) 'noerror)

(el-get 'sync
        (delq nil
              (mapcar (lambda (source)
                        (let ((name (el-get-source-name source)))
                          (unless (member name '("el-get" "es-windows"))
                            name)))
                      el-get-sources)))

(defun el-get-regenerate-all-autoloads ()
  "Regenerates all autoloads for el-get"
  (interactive)
  (let ((f el-get-autoload-file))
    (unless (file-writable-p f)
      (error "Autoloads file can not be written"))
    (delete-file f)
    (el-get)
    (byte-compile-file f)))
