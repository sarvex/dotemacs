(setq jabber-account-list
      `((,my-jabber-org-jid
         (:network-server . "jabber.org")
         (:password . ,my-jabber-org-password)
         (:disabled . nil))))

(setq jabber-mode-line-compact t)
