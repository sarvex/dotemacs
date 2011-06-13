(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d")

(load "conf/before-init-config")

(load "misc/passwords.el.gpg")            ; load passwords

;; needs to be loaded in the beginning to shadow bundled version:
(load "conf/cedet-config")

(load "misc/temporary-stuff")

(load "conf/functions-config")

(load "conf/elpa-config")
(load "conf/el-get-config")

(load "conf/misc-modes-config")
(load "conf/contrib-config")

;; need encrypted passwords:
(load "conf/jabber-config")
(load "conf/erc-config")

(load "conf/yasnippet-config")
(load "conf/ido-config")
(load "conf/ibuffer-config")
(load "conf/hist-config")
(load "conf/cursor-config")

(load "conf/cc-mode-config")
(load "conf/haskell-config")
(load "conf/lisps-config")
(load "conf/slime-config")
(load "conf/paredit-config")
(load "conf/perl-config")
(load "conf/python-config")
(load "conf/ruby-config")
(load "conf/html-css-config")

(load "conf/dired-config")
(load "conf/openwith-config")
(load "conf/diminish-config")
(load "conf/isearch-config")
(load "conf/w3m-config")
(load "conf/org-config")
(load "conf/kill-ring-config")
(load "conf/twitter-config")
(load "conf/bookmark-config")
(load "conf/eshell-config")
(load "conf/rainbow-config")
(load "conf/mercurial-config")
(load "conf/git-config")
(load "conf/projects-config")
(load "conf/etc-config")
(load "conf/i18n-config")
(load "conf/hook-config")
(load "conf/keys-config")
(load "conf/midnight-config")


(desktop-read "~/.emacs.d/")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Local Variables:
;; no-byte-compile: t
;; End:
