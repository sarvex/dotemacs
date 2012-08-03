(unless (require 'el-get nil 'noerror)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

(defun el-get-regenerate-all-autoloads ()
  "Regenerates all autoloads"
  (interactive)
  (let ((f el-get-autoload-file))
    (if (not (file-writable-p f))
        (message "Autoloads file can not be written. Aborting")
        (when (file-exists-p f) (delete-file f))
        (el-get)
        (byte-compile-file f))))

(setq
 el-get-sources
 '(el-get
   autopair
   ack
   ahg
   cedet
   bookmark+
   clojure-mode
   diminish
   emacs-jabber
   emacs-w3m
   haskell-mode
   swank-clojure
   magit
   (:name   openwith
    :description "Open files with external programs"
    :type hg
    :url "https://bitbucket.org/jpkotta/openwith"
    :features openwith
    :post-init (openwith-mode t))
   rdebug
   rhtml-mode
   paredit
   textile-mode
   yaml-mode

   (:name asciidoc :lazy t)
   (:name csharp-mode :lazy t)
   (:name dired+ :lazy t)
   (:name dired-details :lazy t)
   (:name erc-highlight-nicknames :lazy t)
   (:name haml-mode :lazy t)
   (:name iedit :lazy t)
   (:name nognus :lazy t)
   (:name io-mode :lazy t)
   (:name ioccur :lazy t)
   (:name php-mode :lazy t)
   (:name quack :lazy t)
   (:name rainbow-mode :lazy t)
   (:name sass-mode :lazy t)
   (:name scss-mode :lazy t)
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

   (:name anything
    :lazy t
    :load-path ("." "extensions" "contrib"))

   (:name typing
    :type emacswiki
    :post-init (progn (autoload 'typing-of-emacs "typing" "The Typing Of Emacs, a game." t)))

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

   ;; (:name gh
   ;;  :type git
   ;;  :url "https://github.com/sigma/gh.el")

   (:name gist
    :type git
    :url "https://github.com/mhayashi1120/gist.el.git"
    :lazy t)

   (:name yasnippet
    :features yasnippet
    :compile ("dropdown-list.el" "yasnippet.el")
    :post-init nil
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

   ;; (:name c-eldoc
   ;;  :type emacswiki)

   (:name markdown-mode
    :features nil
    :post-init nil)

   (:name mic-paren
    :type emacswiki
    :features mic-paren)

   (:name auto-complete
    :features auto-complete-config)

   (:name feature-mode
    :type git
    :url "https://github.com/michaelklishin/cucumber.el.git"
    :post-init (progn
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
    :post-init (progn (setq pomodoro-icon (expand-file-name "pomodoro/pomodoro_technique.png" el-get-dir))))

   (:name sass-convert
    :type git
    :url "https://github.com/vderyagin/sass-convert.el.git")

   (:name graphviz-dot-mode
    :type http
    :url "http://www.graphviz.org/Misc/graphviz-dot-mode.el"
    :post-init (progn (add-to-list 'auto-mode-alist '("\\.gv\\'" . graphviz-dot-mode))))

   (:name ido-ubiquitous
    :type git
    :url "https://github.com/technomancy/ido-ubiquitous.git")

   (:name nginx-mode
    :type git
    :url "https://github.com/ajc/nginx-mode.git")

   (:name slim-mode
    :type http
    :url "https://raw.github.com/stonean/slim/master/extra/slim-mode.el")

   (:name project-root
    :type git
    :url "https://github.com/vderyagin/project-root.git")))

(el-get 'wait)
(load (file-name-sans-extension el-get-autoload-file))
