;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(jabber-mode-line-compact t)
 '(jabber-account-list
   (list
    (list my-jabber-org-jid
     (cons :network-server "jabber.org")
     (cons :password my-jabber-org-password)
     (cons :disabled nil)))))
