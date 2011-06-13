(setq jabber-account-list
      `((,my-jabber-com-ua-jid
         (:network-server . "jabber.com.ua")
         (:password . ,my-jabber-com-ua-password)
         (:disabled . t))
        (,my-richim-org-jid
         (:network-server . "richim.org")
         (:password . ,my-richim-org-password)
         (:disabled . t))
        (,my-jabber-org-jid
         (:network-server . "jabber.org")
         (:password . ,my-jabber-org-password)
         (:disabled . nil))))

(setq jabber-mode-line-compact t)
