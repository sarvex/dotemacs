;;; -*- lexical-binding: t -*-

(defun switch-to-irc-buffer ()
  "Connect to IRC server or switch to an IRC buffer if connected already."
  (interactive)
  (let ((buffers (and (fboundp 'erc-buffer-list)
                      (erc-buffer-list))))
    (if buffers
        (switch-to-buffer (ido-completing-read
                           "IRC channel: "
                           (mapcar 'buffer-name buffers)
                           nil
                           'require-match))
      (when (y-or-n-p "Connect to IRC? ") (erc)))))

(with-eval-after-load 'erc
  (define-key erc-mode-map (kbd "<return>") 'browse-url-at-point)
  (define-key erc-mode-map (kbd "C-c C-<return>") 'erc-send-current-line))

(custom-set-variables
 '(erc-fill-column 67)
 '(erc-fill-mode t)
 '(erc-fill-function 'erc-fill-variable)
 '(erc-fill-prefix "   ")
 '(erc-fill-variable-maximum-indentation 8)

 '(erc-prompt-for-nickserv-password nil)
 '(erc-prompt-for-password nil)

 '(erc-autojoin-timing 'ident)
 '(erc-autojoin-delay most-positive-fixnum)

 '(erc-kill-buffer-on-part t)
 '(erc-kill-server-buffer-on-quit t)
 '(erc-kill-queries-on-quit t)

 '(erc-anonymous-login nil)
 '(erc-header-line-format nil)
 '(erc-hide-list '("324" "329" "333" "353" "MODE" "JOIN" "PART" "QUIT" ))
 '(erc-hide-prompt nil)
 '(erc-interpret-mirc-color t)
 '(erc-join-buffer 'buffer)
 '(erc-log-channels-directory "~/.irclogs")
 '(erc-log-file-coding-system 'utf-8)
 '(erc-max-buffer-size 20000)
 '(erc-prompt ">>>")
 '(erc-send-whitespace-lines nil)
 '(erc-truncate-buffer-on-save t)
 '(erc-warn-about-blank-lines t)

 '(erc-modules '(
                 autojoin
                 button
                 completion
                 fill
                 highlight-nicknames
                 irccontrols
                 list
                 log
                 match
                 move-to-prompt
                 netsplit
                 networks
                 noncommands
                 readonly
                 ring
                 scrolltobottom
                 services
                 smiley
                 spelling
                 stamp
                 truncate
                 )))
