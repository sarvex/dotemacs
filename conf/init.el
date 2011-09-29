(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d")

(add-to-list 'load-path "~/.emacs.d/slime")

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; loads passwords and othre stuff, required on startup
(load "conf/before-init-configuration")

;; needs to be loaded in the beginning to shadow bundled version:
(load "conf/cedet-configuration")

(load "conf/elpa-configuration")
(load "conf/el-get-configuration")
(load "conf/misc-modes-configuration")
(load "conf/contrib-configuration")
(load "conf/jabber-configuration")
(load "conf/erc-configuration")
(load "conf/functions-configuration")
(load "conf/yasnippet-configuration")
(load "conf/ido-configuration")
(load "conf/ibuffer-configuration")
(load "conf/hist-configuration")
(load "conf/cursor-configuration")

(load "conf/cc-mode-configuration")
(load "conf/haskell-configuration")
(load "conf/lisps-configuration")
(load "conf/slime-configuration")
(load "conf/perl-configuration")
(load "conf/python-configuration")
(load "conf/ruby-configuration")
(load "conf/html-css-configuration")

(load "conf/dired-configuration")
(load "conf/openwith-configuration")
(load "conf/diminish-configuration")
(load "conf/isearch-configuration")
(load "conf/w3m-configuration")
(load "conf/org-configuration")
(load "conf/kill-ring-configuration")
(load "conf/twitter-configuration")
(load "conf/bookmark-configuration")
(load "conf/eshell-configuration")
(load "conf/rainbow-configuration")
(load "conf/mercurial-configuration")
(load "conf/git-configuration")
(load "conf/anything-configuration")
(load "conf/projects-configuration")
(load "conf/etc-configuration")
(load "conf/i18n-configuration")
(load "conf/hook-configuration")
(load "conf/keys-configuration")
(load "conf/midnight-configuration")

(desktop-read "~/.emacs.d/")

;; Local Variables:
;; no-byte-compile: t
;; End:
