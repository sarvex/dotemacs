(unless (require 'el-get nil 'noerror)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

(defun el-get-regenerate-all-autoloads ()
  "Regenerates all autoloads for el-get"
  (interactive)
  (let ((f el-get-autoload-file))
    (unless (file-writable-p f)
      (error "Autoloads file can not be written"))
    (delete-file f)
    (el-get)
    (byte-compile-file f)))

(setq
 el-get-sources
 '((:name el-get)
   (:name ack)
   (:name ahg)
   (:name autopair)
   (:name bookmark+)
   (:name cedet)
   (:name clojure-mode)
   (:name diminish)
   (:name emacs-jabber)
   (:name emacs-w3m)
   (:name haskell-mode)
   (:name helm)
   (:name magit)
   (:name paredit)
   (:name rdebug)
   (:name rhtml-mode)
   (:name textile-mode)
   (:name yaml-mode)

   (:name asciidoc :lazy t)
   (:name dired+ :lazy t)
   (:name dired-details :lazy t)
   (:name erc-highlight-nicknames :lazy t)
   (:name gist :lazy t)
   (:name haml-mode :lazy t)
   (:name iedit :lazy t)
   (:name io-mode :lazy t)
   (:name nognus :lazy t)
   (:name php-mode :lazy t)
   (:name quack :lazy t)
   (:name rainbow-mode :lazy t)
   (:name sass-mode :lazy t)
   (:name scss-mode :lazy t)
   (:name slim-mode :lazy t)
   (:name twittering-mode :lazy t)
   (:name yari :lazy t)

   (:name smex
    :post-init nil
    :lazy t)

   (:name org-mode
    :autoloads t
    :lazy t)

   (:name coffee-mode
    :post-init nil
    :lazy t)

   (:name openwith
    :description "Open files with external programs"
    :type hg
    :url "https://bitbucket.org/jpkotta/openwith"
    :features openwith
    :post-init (openwith-mode t))

   (:name drag-stuff
    :type http
    :url "https://raw.github.com/rejeep/drag-stuff/master/drag-stuff.el"
    :lazy t)

   (:name ruby-mode
    :type http
    :url "https://raw.github.com/ruby/ruby/trunk/misc/ruby-mode.el")

   (:name inf-ruby
    :type http
    :url "https://raw.github.com/ruby/ruby/trunk/misc/inf-ruby.el"
    :features nil)

   (:name ruby-electric
    :type http
    :url "https://raw.github.com/ruby/ruby/trunk/misc/ruby-electric.el"
    :post-init nil)



   (:name handlebars-mode
    :type github
    :pkgname "danielevans/handlebars-mode"
    :lazy t
    :features nil)

   (:name yasnippet
    :features yasnippet
    :compile ("dropdown-list.el" "yasnippet.el")
    :post-init nil
    :lazy t)

   (:name nrepl.el
    :type github
    :pkgname " kingtim/nrepl.el"
    :features nil
    :lazy t)

   (:name crontab-mode
    :url "http://web.archive.org/web/20080716014153/http://www.mahalito.net/~harley/elisp/crontab-mode.el"
    :post-init (progn (add-to-list 'auto-mode-alist '("crontab\\'" . crontab-mode))))

   (:name scratch
    :post-init (progn (autoload 'scratch "scratch" nil t)))

   (:name multi-term
    :type emacswiki
    :features nil
    :post-init (progn (autoload 'multi-term-next "multi-term" nil t)))

   (:name irfc
    :type emacswiki
    :post-init (progn
                 (autoload 'irfc-mode "irfc" "Mode for viewing IETF RFC documents" t)
                 (autoload 'irfc-visit "irfc" nil t)
                 (add-to-list 'auto-mode-alist '("rfc[0-9]+\\.txt\\'" . irfc-mode))))

   (:name dired-details+
    :type emacswiki)

   (:name doc-mode
    :post-init (progn
                 (autoload 'doc-mode "doc-mode" nil t)
                 (add-to-list 'auto-mode-alist '("\\.a\\(scii\\)?doc\\'" . doc-mode))))

   (:name markdown-mode
    :features nil
    :post-init nil)

   (:name mic-paren
    :type emacswiki
    :features mic-paren)

   (:name auto-complete
    :features auto-complete-config)

   (:name feature-mode
    :type github
    :pkgname "michaelklishin/cucumber.el"
    :post-init (progn
                 (setq feature-default-language "en"
                       feature-default-i18n-file (expand-file-name "feature-mode/i18n.yml" el-get-dir))
                 (add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))))

   (:name popwin
    :type github
    :pkgname "m2ym/popwin-el"
    :compile "popwin.el"
    :features popwin)

   (:name pomodoro
    :type github
    :pkgname "vderyagin/pomodoro.el"
    :post-init (progn (setq pomodoro-icon (expand-file-name "pomodoro/pomodoro_technique.png" el-get-dir))))

   (:name graphviz-dot-mode
    :type http
    :url "http://www.graphviz.org/Misc/graphviz-dot-mode.el"
    :post-init (progn (add-to-list 'auto-mode-alist '("\\.gv\\'" . graphviz-dot-mode))))

   (:name ido-ubiquitous
    :type github
    :pkgname "technomancy/ido-ubiquitous")

   (:name nginx-mode
    :type github
    :pkgname "ajc/nginx-mode")

   (:name rake.el
    :type github
    :pkgname "vderyagin/rake.el")

   (:name projectur
    :type github
    :pkgname "vderyagin/projectur")))

(el-get 'wait)
(load (file-name-sans-extension el-get-autoload-file))
