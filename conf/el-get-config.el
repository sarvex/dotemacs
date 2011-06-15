(unless (require 'el-get "~/.emacs.d/el-get/el-get/el-get" 'noerror)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (goto-char (point-max))
     (eval-print-last-sexp))))

(defun el-get-regenerate-autoloads ()
  "Regenerates all autoloads"
  (interactive)
  (delete-file el-get-autoload-file)
  (el-get))

;; (setq  el-get-byte-compile-at-init t)

(setq
 el-get-sources
 '(el-get
   ack
   ahg
   bbcode-mode
   bookmark+
   clojure-mode
   diminish
   emacs-jabber
   emacs-w3m
   haskell-mode
   ;; haskell-mode-exts
   ;; shime
   ;; slime
   magit
   org-mode
   openwith
   rhtml-mode
   paredit
   ;; pylookup
   sicp
   textile-mode
   yaml-mode

   (:name yasnippet
    :type svn
    :url "http://yasnippet.googlecode.com/svn/trunk/"
    :features yasnippet
    :compile ("dropdown-list.el" "yasnippet.el")
    :post-init (lambda () (add-to-list 'yas/snippet-dirs (expand-file-name "yasnippet/snippets" el-get-dir))))

   (:name crontab-mode
    :url "http://web.archive.org/web/20080716014153/http://www.mahalito.net/~harley/elisp/crontab-mode.el"
    :post-init (lambda () (add-to-list 'auto-mode-alist '("crontab\\'" . crontab-mode))))

   (:name smex
    :before (lambda () (setq smex-save-file "~/.emacs.d/smex.save"))
    :after nil)

   (:name ac-slime
    :post-init (lambda () (autoload 'set-up-slime-ac "ac-slime")))

   (:name scratch
    :post-init (lambda () (autoload 'scratch "scratch" nil t)))

   (:name wikipedia-mode
    :features nil)

   (:name iedit
    :features nil)

   (:name ioccur
    :features nil
    :post-init (lambda () (autoload 'ioccur "ioccur" nil t)))

   (:name twittering-mode
    :features nil)

   (:name rainbow-mode
    :features nil)

   (:name multi-term
    :type emacswiki
    :features nil
    :post-init (lambda () (autoload 'multi-term-next "multi-term" nil t)))

   (:name drag-stuff
    :compile "drag-stuff.el")

   (:name irfc
    :type emacswiki
    :post-init (lambda ()
                 (autoload 'irfc-mode "irfc" "Mode for viewing IETF RFC documents" t)
                 (autoload 'irfc-visit "irfc" nil t)
                 (add-to-list 'auto-mode-alist '("/rfc[0-9]+\\.txt\\'" . irfc-mode))))

   (:name dired-details
    :features nil)

   (:name dired-details+
    :type emacswiki)

   (:name asciidoc
    :features nil)

   (:name doc-mode
    :post-init (lambda ()
                 (autoload 'doc-mode "doc-mode" nil t)
                 (add-to-list 'auto-mode-alist '("\\.a\\(scii\\)?doc\\'" . doc-mode))))

   (:name c-eldoc
    :type emacswiki)

   (:name erc-highlight-nicknames
    :features nil)

   (:name dired+
    :features nil)

   (:name js2-mode
    :autoloads nil)

   (:name markdown-mode
    :post-init (lambda ()
                 (dolist (ext '("\\.text\\'" "\\.markdown\\'"
                                "\\.mdwn\\'" "\\.mk?dt?\\'"))
                   (add-to-list 'auto-mode-alist `(,ext . markdown-mode)))))

   (:name mic-paren
    :type emacswiki
    :features mic-paren)

   (:name coffee-mode
    :features nil
    :post-init nil)

   (:name haml-mode
    :features nil
    :post-init (lambda () (add-to-list 'auto-mode-alist '("\\.haml\\'" . haml-mode))))

   (:name sass-mode
    :features nil
    :post-init (lambda () (add-to-list 'auto-mode-alist '("\\.sass\\'" . 'sass-mode))))

   (:name scss-mode
    :type git
    :url "https://github.com/antonj/scss-mode.git"
    :post-init (lambda () (add-to-list 'auto-mode-alist '("\\.scss\\'" . 'scss-mode))))

   (:name yari
    :features nil)

   (:name gist
    :type git
    :url "https://github.com/defunkt/gist.el.git"
    :features nil)

   (:name auto-complete
    :features auto-complete-config)

   (:name rinari
    :compile ("\.el$" "util/.*\.el")
    :load-path ("." "util")
    :features nil)

   (:name anything
    :features (anything-config anything-match-plugin))

   (:name cucumber
    :type git
    :url "https://github.com/michaelklishin/cucumber.el.git"
    :post-init (lambda ()
                 (setq feature-default-language "en"
                       feature-default-i18n-file (expand-file-name "cucumber/i18n.yml" el-get-dir))
                 (add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))))

   (:name popwin
    :type git
    :url "https://github.com/m2ym/popwin-el.git"
    :compile "popwin.el"
    :features popwin)

   (:name pomodoro
    :type git
    :url "https://github.com/vderyagin/pomodoro.el.git"
    :post-init (lambda ()
                 (setq pomodoro-icon (expand-file-name "pomodoro/pomodoro_technique.png" el-get-dir))))

   (:name autopair
    :type svn
    :url "http://autopair.googlecode.com/svn/trunk/"
    :compile "autopair.el"
    :features autopair)

   (:name sass-convert
    :type git
    :url "https://github.com/vderyagin/sass-convert.el.git")

   ))

;; (el-get 'sync)
(el-get)
