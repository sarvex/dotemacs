;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(jabber-mode-line-compact t)
 '(jabber-account-list
   (list
    (list vderyagin/jabber-org-jid
     (cons :network-server "jabber.org")
     (cons :password vderyagin/jabber-org-password)
     (cons :disabled nil)))))
