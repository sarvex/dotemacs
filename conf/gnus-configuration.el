(setq gnus-select-method '(nntp "news.gmane.org"))

(setq gnus-secondary-select-methods
      '(
        ;; (nnml "")
        (nnimap "gmail"
         (nnimap-address "imap.gmail.com")
         (nnimap-server-port 993)
         (nnimap-stream ssl))))


(require 'pop3)
(setq mail-sources
      `((pop
         :server ,my-dilines-server
         :user ,my-dilines-username
         :password ,my-dilines-password)))


(setq user-full-name my-full-name
      user-mail-address my-email-address)

(require 'gnus-html)
(setq gnus-max-image-proportion 100.0
      mm-text-html-renderer 'shr)


(setq mm-discouraged-alternatives nil
      mm-inline-large-images t
      mm-inline-text-html-with-images t)


(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/bin/msmtp")


;; Choose account label to feed msmtp -a option based on From header in Message buffer;
;; This function must be added to message-send-mail-hook for on-the-fly change of From address
;; before sending message since message-send-mail-hook is processed right before sending message.
(defun my-feed-msmtp ()
  (if (message-mail-p)
      (save-excursion
        (let* ((from (save-restriction
                       (message-narrow-to-headers)
                       (message-fetch-field "from")))
               (account (cond
                          ((string-match my-email-address from)
                           "google")
                          ((string-match my-dilines-email from)
                           "dilines"))))
          (setq message-sendmail-extra-arguments (list "-a" account))))))
(setq message-sendmail-envelope-from 'header)
(add-hook 'message-send-mail-hook 'my-feed-msmtp)


(require 'epg)
(setq mm-verify-option 'known
      mm-decrypt-option 'known)
(setq gnus-buttonized-mime-types '("multipart/alternative" "multipart/encrypted" "multipart/signed"))
;; handling signed and encrypted messages
(eval-after-load 'mm-decode
  '(progn
    ;; Tells Gnus to inline the part
    (add-to-list 'mm-inlined-types "application/pgp$")
    ;; Tells Gnus how to display the part when it is requested
    (add-to-list 'mm-inline-media-tests '("application/pgp$" mm-inline-text identity))
    ;; Tell Gnus not to wait for a request, just display the thing straight away.
    (add-to-list 'mm-automatic-display "application/pgp$")
    ;; But don't display the signatures, please.
    (setq mm-automatic-display (remove "application/pgp-signature" mm-automatic-display))))



(defun gnus-user-format-function-d (headers)
  (let ((time (gnus-group-timestamp gnus-tmp-group)))
    (if time
        (format-time-string "%b %d %Y, %H:%M" time)
        "")))

(setq gnus-summary-line-format "%U%R%z%I%(%[%4L: %-23,23f%]%) %s\n"
      gnus-summary-mode-line-format "Gnus: %G [%A] %Z"
      gnus-article-mode-line-format "Gnus: %G [%w] %Z %S"
      gnus-topic-line-format "%i[ %(%{%n%}%) — %A ]%v\n"
      gnus-group-line-format "%M\%S\%p\%P\%5y: %(%-60,60g%) %ud\n")

(setq gnus-check-new-newsgroups nil
      gnus-save-killed-list nil
      gnus-asynchronous t
      gnus-save-newsrc-file nil
      gnus-auto-select-next nil
      gnus-summary-check-current t
      gnus-auto-extend-newsgroup t
      gnus-thread-indent-level 2)

(setq gnus-agent-directory         "~/.mail/gnus/agent"
      gnus-article-save-directory  "~/.mail/gnus"
      gnus-default-directory       "~/.mail/gnus"
      gnus-directory               "~/.mail/gnus"
      gnus-home-directory          "~/.mail/gnus"
      gnus-kill-files-directory    "~/.mail/gnus"
      gnus-startup-file            "~/.mail/gnus/newsrc")

(setq mail-default-directory       "~/.mail"
      mail-source-directory        "~/.mail"
      message-auto-save-directory  "~/.mail/drafts/"
      message-directory            "~/.mail"
      nndraft-current-directory    "~/.mail/gnus/nndraft"
      nndraft-directory            "~/.mail/gnus/nndraft"
      nnfolder-active-file         "~/.mail/archive/active"
      nnfolder-directory           "~/.mail/archive"
      nnmail-message-id-cache-file "~/.mail/nnmail-cache")

(setq gnus-treat-from-gravatar 'head
      gnus-treat-mail-gravatar 'head
      gnus-treat-mail-picon 'head
      gnus-treat-x-pgp-sig 'head)

(setq gnus-extract-address-components 'mail-extract-address-components)


(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)

(define-key gnus-summary-mode-map (kbd "[") 'gnus-summary-refer-thread)


(add-hook 'message-mode-hook 'turn-on-orgstruct++)
(add-hook 'message-mode-hook 'turn-on-orgtbl)
(add-hook 'message-mode-hook
          (defun vderyagin/message-mode-hook ()
            (epa-mail-mode t)
            (flyspell-mode t)))
