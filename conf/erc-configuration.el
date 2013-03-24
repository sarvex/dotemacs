;;; -*- lexical-binding: t -*-

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

 '(erc-track-exclude-server-buffer t)
 '(erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE" "324" "329" "332" "333" "353" "477"))

 '(erc-kill-buffer-on-part t)
 '(erc-kill-server-buffer-on-quit t)
 '(erc-kill-queries-on-quit t)

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

 '(erc-modules '(autojoin
                 button
                 completion
                 fill
                 irccontrols
                 list
                 log
                 match
                 menu
                 move-to-prompt
                 netsplit
                 networks
                 noncommands
                 readonly
                 ring
                 highlight-nicknames
                 scrolltobottom
                 smiley
                 stamp
                 truncate)))

(eval-after-load 'erc
  '(progn
    (require 'erc-highlight-nicknames)
    (require 'erc-services)
    (require 'erc-join)
    (require 'erc-fill)

    (erc-update-modules)

    ;; (require 'erc-track)
    ;; (erc-track-mode t)

    (define-key erc-mode-map (kbd "<return>") 'browse-url-at-point)
    (define-key erc-mode-map (kbd "C-c C-<return>") 'erc-send-current-line)))

(defun vderyagin/erc-join ()
  (interactive)
  (when (y-or-n-p "Connect to IRC? ")
    (erc-services-mode)
    (erc-autojoin-mode)

    (erc-select :server "irc.freenode.net"
                :port 6667
                :nick my-freenode-username
                :password my-freenode-password
                :full-name my-full-name)))

(defun vderyagin/switch-to-irc-buffer ()
  "Switch to an IRC buffer, or run `vderyagin/erc-join'."
  (interactive)
  (let ((buffers (and (fboundp 'erc-buffer-list)
                      (erc-buffer-list))))
    (if buffers
        (switch-to-buffer (ido-completing-read
                           "IRC channel: "
                           (mapcar 'buffer-name buffers)
                           nil
                           'require-match))
        (call-interactively 'vderyagin/erc-join))))
