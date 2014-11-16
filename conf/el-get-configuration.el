;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(el-get-notify-type 'message)
 '(el-get-sources
   '(el-get

     clojure-mode
     drag-stuff
     emacs-async
     ghc-mod
     git-commit-mode
     gnus
     haml-mode
     magit
     php-mode
     rcodetools
     scratch
     slime
     structured-haskell-mode

     (:name erc-highlight-nicknames :lazy t)

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

     (:name smartparens
            :features smartparens-config)

     (:name miniedit
            :type emacsmirror
            :after (miniedit-install))

     (:name flycheck
            :after (add-hook 'after-init-hook #'global-flycheck-mode))

     (:name haskell-mode
            :load "haskell-mode-autoloads.el"
            :post-init nil)

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
