;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(el-get-notify-type 'message)
 '(el-get-sources
   '(el-get

     auto-complete
     cider
     clojure-mode
     dired+
     dockerfile-mode
     drag-stuff
     emacs-async
     ghc-mod
     git-commit-mode
     gnus
     graphviz-dot-mode
     haml-mode
     helm-descbinds
     lua-mode
     magit
     paredit
     php-mode
     popup
     rcodetools
     s
     scala-mode2
     scratch
     slim-mode
     slime
     smex
     structured-haskell-mode
     textile-mode
     tuareg-mode
     web-mode
     yaml-mode

     (:name erc-highlight-nicknames :lazy t)
     (:name rust-mode :lazy t)
     (:name twittering-mode :lazy t)
     (:name yari :lazy t)

     (:name iedit
            :type github
            :pkgname "victorhge/iedit"
            :features (iedit iedit-rect))

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
            :url "https://raw.githubusercontent.com/ruby/ruby/trunk/misc/inf-ruby.el"
            :features nil)

     (:name yasnippet
            :features yasnippet
            :compile ("dropdown-list.el" "yasnippet.el")
            :post-init nil)

     (:name eval-expr
            :type emacsmirror)

     (:name irfc
            :type emacswiki
            :before (progn
                      (setq irfc-directory "~/doc/RFC"
                            irfc-assoc-mode t)
                      (add-to-list 'auto-mode-alist '("/rfc[0-9]+\\.txt\\'" . irfc-mode))))

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
            :url "https://raw.githubusercontent.com/nsf/gocode/master/emacs/go-autocomplete.el")

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
            :after (add-hook 'after-init-hook #'global-flycheck-mode))

     (:name macrostep
            :type github
            :pkgname "joddie/macrostep")

     (:name emmet-mode
            :type github
            :pkgname "smihica/emmet")

     (:name elixir-mode
            :type github
            :pkgname "elixir-lang/emacs-elixir")

     (:name haskell-mode
            :load "haskell-mode-autoloads.el"
            :post-init nil)

     (:name project-explorer
            :lazy t)

     (:name fancy-narrow
            :type github
            :pkgname "bruce-connor/fancy-narrow"
            :after (fancy-narrow-mode))

     (:name go-oracle
            :type http
            :url "http://tools.go.googlecode.com/hg/cmd/oracle/oracle.el"
            :load-path "."
            :post-init nil)

     (:name org-mode
            :url "http://orgmode.org/org-mode.git")

     (:name ensime
            :type http-tar
            :options ("xzf")
            :url "https://github.com/downloads/ensime/ensime-src/ensime_2.10.0-RC3-0.9.8.2.tar.gz"
            :load-path "elisp"
            :build `((,el-get-emacs "--quick" "--batch"
                                    "--directory" "elisp"
                                    "--load" "elisp/ensime.el"
                                    "--eval" "(defun batch-force-byte-recompile-directory () (batch-byte-recompile-directory 0))"
                                    "--funcall" "batch-force-byte-recompile-directory" "elisp"))
            :post-init nil)

     (:name ac-cider-compliment
            :features nil)

     (:name rspec-simple
            :type github
            :pkgname "code-mancers/rspec-simple"
            :features nil)

     (:name flycheck-hdevtools
            :features nil)

     (:name flycheck-haskell
            :type github
            :pkgname "flycheck/flycheck-haskell"
            :features nil)

     (:name sass-mode
            :post-init nil)

     (:name markdown-mode
            :type github
            :pkgname "defunkt/markdown-mode")

     (:name helm
            :build (("make")))

     (:name smart-mode-line
            :after (progn (sml/setup)
                          (sml/apply-theme 'respectful)))

     (:name bookmark+
            :before (setq bookmark-default-file "~/.emacs.d/bookmarks/default"))

     (:name projectur
            :type github
            :pkgname "vderyagin/projectur"))))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync
        (cl-remove-if
         (lambda (name) (member name '("el-get" "es-windows")))
         (mapcar 'el-get-source-name el-get-sources)))

(load (file-name-sans-extension el-get-autoload-file) 'noerror)

(defun el-get-regenerate-all-autoloads ()
  "Regenerates all autoloads for el-get"
  (interactive)
  (let ((f el-get-autoload-file))
    (unless (file-writable-p f)
      (error "Autoloads file can not be written"))
    (delete-file f)
    (el-get)
    (byte-compile-file f)))

(defun el-get-update-most ()
  "Update most el-get-packages (except those not in need of update)"
  (interactive)
  (let ((el-get-default-process-sync t)
        (el-get-elpa-do-refresh 'once)
        (packages (cl-remove-if
                   (lambda (pkg) (member pkg '("ensime" "erc-highlight-nicknames" "erc")))
                   (el-get-list-package-names-with-status "installed"))))
    (mapc 'el-get-update packages)))
