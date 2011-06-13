(eval-after-load "erc"
  (quote
   (progn

     (require 'erc-highlight-nicknames)
     (require 'erc-services)
     (require 'erc-join)
     (require 'erc-fill)

     (define-key erc-mode-map (kbd "C-c n") 'switch-to-irc)
     (define-key erc-mode-map (kbd "<return>")
       (lambda ()
         (interactive)
         (message "Press 'C-c <return>' to send message.")))

     (define-key erc-mode-map (kbd "C-c <return>") 'erc-send-current-line)
     (define-key erc-mode-map (kbd "C-c C-<return>") 'erc-send-current-line))))



(setq erc-fill-column 67
      erc-fill-mode t
      erc-fill-function 'erc-fill-variable
      erc-fill-prefix "     "
      erc-fill-variable-maximum-indentation 8)

(setq erc-prompt-for-nickserv-password nil
      erc-prompt-for-password nil)

(defun my-join-erc ()
  (interactive)
  (erc-select :server "irc.freenode.net"
              :port 6667
              :nick my-freenode-username
              :password my-freenode-password)
  (erc-services-mode t)
  (erc-nickserv-mode t)
  (erc-autojoin-mode t))

(setq erc-user-full-name my-full-name
      erc-email-userid my-email-address)

(setq erc-autojoin-timing 'ident        ; rejoin after auth only
      erc-autojoin-delay most-positive-fixnum)

(defun switch-to-irc ()
  "Switch to an IRC buffer, or run `my-join-erc'.
    When called repeatedly, cycle through the buffers."
  (interactive)
  (let ((buffers (and (fboundp 'erc-buffer-list)
                      (erc-buffer-list))))
    (when (eq (current-buffer) (car buffers))
      (bury-buffer)
      (setq buffers (cdr buffers)))
    (if buffers
        (switch-to-buffer (car buffers))
        (call-interactively 'my-join-erc))))


;; check channels
;; (erc-track-mode t)
;; (setq erc-track-exclude-server-buffer t
;;       erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE" "324" "329" "332" "333" "353" "477"))

;; Clears out annoying erc-track-mode stuff for when we don't care.
;; (defun reset-erc-track-mode ()
;;   (interactive)
;;   (setq erc-modified-channels-alist nil)
;;   (erc-modified-channels-update))
;; (define-key global-map (kbd "C-c r") 'reset-erc-track-mode)


(setq erc-interpret-mirc-color t)
;; Kill buffers for channels after /part
;; (setq erc-kill-buffer-on-part t)
;; Kill buffers for private queries after quitting the server
;; (setq erc-kill-queries-on-quit t)
;; Kill buffers for server messages after quitting the server
;; (setq erc-kill-server-buffer-on-quit t)

(setq erc-hide-list '("324" "329" "333" "353" "MODE" "JOIN" "PART" "QUIT" )
      erc-header-line-face-method t
      erc-header-line-format nil
      erc-hide-prompt nil
      erc-input-line-position -4
      erc-join-buffer 'buffer
      erc-kill-buffer-on-part t
      erc-kill-queries-on-quit t
      erc-kill-server-buffer-on-quit t
      ;; erc-current-nick-highlight-type 'nick
      erc-max-buffer-size 20000
      erc-log-file-coding-system 'utf-8
      erc-log-channels-directory "~/.irclogs/"
      erc-log-insert-log-on-open nil
      erc-minibuffer-ignored nil
      erc-minibuffer-notice nil
      erc-modules '(autojoin
                    button
                    completion
                    fill
                    irccontrols
                    ;; keep-place
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
                    ;; track
                    truncate)
      erc-prompt ">>>>"
      erc-prompt-for-channel-key nil
      erc-send-whitespace-lines nil
      erc-truncate-buffer-on-save t
      erc-echo-notices-in-minibuffer-flag t
      erc-nick my-freenode-username
      erc-port 6667
      erc-prompt-for-password nil
      erc-warn-about-blank-lines t)

;; (erc-update-modules)
