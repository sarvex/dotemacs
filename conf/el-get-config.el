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
   autopair
   ack
   ahg
   bbcode-mode
   bookmark+
   clojure-mode
   diminish
   emacs-jabber
   emacs-w3m
   haskell-mode
   swank-clojure
   magit
   openwith
   rhtml-mode
   paredit
   textile-mode
   yaml-mode

   (:name io-mode
    :lazy t)

   (:name yari
    :lazy t)

   (:name sass-mode
    :lazy t)

   (:name scss-mode
    :lazy t)

   (:name wikipedia-mode
    :lazy t)

   (:name iedit
    :lazy t)

   (:name ioccur
    :lazy t)

   (:name twittering-mode
    :lazy t)

   (:name rainbow-mode
    :lazy t)

   (:name erc-highlight-nicknames
    :lazy t)

   (:name dired+
    :lazy t)

   (:name asciidoc
    :lazy t)

   (:name dired-details
    :lazy t)

   (:name smex
    :post-init nil
    :lazy t)

   (:name org-mode
    :autoloads t
    :lazy t)

   (:name coffee-mode
    :post-init nil
    :lazy t)

   (:name haml-mode
    :lazy t
    :post-init (lambda () (add-to-list 'auto-mode-alist '("\\.haml\\'" . haml-mode))))

   (:name drag-stuff
    :type http
    :url "https://raw.github.com/rejeep/drag-stuff/master/drag-stuff.el"
    :lazy t)

   (:name gist
    :type git
    :url "https://github.com/defunkt/gist.el.git"
    :lazy t)

   (:name yasnippet
    :type svn
    :url "http://yasnippet.googlecode.com/svn/trunk/"
    :features yasnippet
    :compile ("dropdown-list.el" "yasnippet.el")
    :post-init (lambda () (add-to-list 'yas/snippet-dirs (expand-file-name "yasnippet/snippets" el-get-dir))))

   (:name crontab-mode
    :url "http://web.archive.org/web/20080716014153/http://www.mahalito.net/~harley/elisp/crontab-mode.el"
    :post-init (lambda () (add-to-list 'auto-mode-alist '("crontab\\'" . crontab-mode))))

   (:name ac-slime
    :post-init (lambda () (autoload 'set-up-slime-ac "ac-slime")))

   (:name scratch
    :post-init (lambda () (autoload 'scratch "scratch" nil t)))

   (:name multi-term
    :type emacswiki
    :features nil
    :post-init (lambda () (autoload 'multi-term-next "multi-term" nil t)))

   (:name irfc
    :type emacswiki
    :post-init (lambda ()
                 (autoload 'irfc-mode "irfc" "Mode for viewing IETF RFC documents" t)
                 (autoload 'irfc-visit "irfc" nil t)
                 (add-to-list 'auto-mode-alist '("rfc[0-9]+\\.txt\\'" . irfc-mode))))

   (:name dired-details+
    :type emacswiki)

   (:name doc-mode
    :post-init (lambda ()
                 (autoload 'doc-mode "doc-mode" nil t)
                 (add-to-list 'auto-mode-alist '("\\.a\\(scii\\)?doc\\'" . doc-mode))))

   (:name c-eldoc
    :type emacswiki)

   (:name markdown-mode
    :features nil
    :post-init (lambda ()
                 (dolist (ext '("\\.text\\'" "\\.markdown\\'" "\\.mdwn\\'" "\\.mk?dt?\\'"))
                   (add-to-list 'auto-mode-alist `(,ext . markdown-mode)))))

   (:name mic-paren
    :type emacswiki
    :features mic-paren)

   (:name auto-complete
    :features auto-complete-config)

   (:name rinari
    :compile ("\.el$" "util/.*\.el")
    :load-path ("." "util")
    :features nil)

   (:name anything
    :features (anything-config anything-match-plugin))

   (:name feature-mode
    :type git
    :url "https://github.com/michaelklishin/cucumber.el.git"
    :post-init (lambda ()
                 (setq feature-default-language "en"
                       feature-default-i18n-file (expand-file-name "feature-mode/i18n.yml" el-get-dir))
                 (add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))))

   (:name popwin
    :type git
    :url "https://github.com/m2ym/popwin-el.git"
    :compile "popwin.el"
    :features popwin)

   (:name pomodoro
    :type git
    :url "https://github.com/vderyagin/pomodoro.el.git"
    :post-init (lambda () (setq pomodoro-icon (expand-file-name "pomodoro/pomodoro_technique.png" el-get-dir))))

   (:name sass-convert
    :type git
    :url "https://github.com/vderyagin/sass-convert.el.git")

   (:name graphviz-dot-mode
    :type http
    :url "http://www.graphviz.org/Misc/graphviz-dot-mode.el"
    :post-init (lambda () (add-to-list 'auto-mode-alist '("\\.gv\\'" . graphviz-dot-mode))))

   ))

;; (el-get 'sync)
(el-get)
