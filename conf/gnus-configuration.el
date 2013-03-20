;;; -*- lexical-binding: t; coding: utf-8 -*-

(require 'gnus-html)
(require 'epg)

(custom-set-variables
 '(gnus-select-method '(nntp "news.gmane.org"))
 '(gnus-secondary-select-methods
   '((nnimap "gmail"
      (nnimap-address "imap.gmail.com")
      (nnimap-server-port 993)
      (nnimap-stream ssl))))

 '(gnus-always-read-dribble-file t)
 '(gnus-extract-address-components 'mail-extract-address-components)
 '(gnus-buttonized-mime-types '("multipart/alternative"
                                "multipart/encrypted"
                                "multipart/signed"))

 '(user-full-name my-full-name)
 '(user-mail-address my-email-address)


 '(gnus-max-image-proportion 100.0)
 '(mm-text-html-renderer 'shr)
 '(mm-discouraged-alternatives nil)
 '(mm-inline-large-images t)
 '(mm-inline-text-html-with-images t)
 '(mm-verify-option 'known)
 '(mm-decrypt-option 'known)

 '(message-send-mail-function 'message-send-mail-with-sendmail)
 '(message-sendmail-envelope-from 'header)
 '(sendmail-program "msmtp")

 '(gnus-summary-line-format "%U%R%z%I%(%[%4L: %-23,23f%]%) %s\n")
 '(gnus-summary-mode-line-format "Gnus: %G [%A] %Z")
 '(gnus-article-mode-line-format "Gnus: %G [%w] %Z %S")
 '(gnus-topic-line-format "%i[ %(%{%n%}%) — %A ]%v\n")
 '(gnus-group-line-format "%M%S%p%P%5y: %(%-50,50g%) %ud\n")

 '(gnus-topic-display-empty-topics t)
 '(gnus-group-default-list-level 1)
 '(gnus-article-truncate-lines nil)
 '(gnus-treat-hide-signature t)
 '(gnus-asynchronous t)
 '(gnus-auto-extend-newsgroup t)
 '(gnus-auto-select-first 'unread)
 '(gnus-auto-select-next nil)
 '(gnus-body-boundary-delimiter nil)
 '(gnus-break-pages nil)
 '(gnus-check-new-newsgroups nil)
 '(gnus-save-killed-list nil)
 '(gnus-save-newsrc-file nil)
 '(gnus-summary-check-current t)
 '(gnus-thread-indent-level 2)

 '(gnus-agent-directory "~/.mail/gnus/agent")
 '(gnus-article-save-directory "~/.mail/gnus")
 '(gnus-default-directory "~/.mail/gnus")
 '(gnus-directory "~/.mail/gnus")
 '(gnus-home-directory "~/.mail/gnus")
 '(gnus-kill-files-directory "~/.mail/gnus")
 '(gnus-startup-file "~/.mail/gnus/newsrc")

 '(mail-default-directory "~/.mail")
 '(mail-source-directory "~/.mail")
 '(message-auto-save-directory "~/.mail/drafts/")
 '(message-directory "~/.mail")
 '(nndraft-directory "~/.mail/gnus/nndraft")
 '(nndraft-current-directory "~/.mail/gnus/nndraft")
 '(nnfolder-active-file "~/.mail/archive/active")
 '(nnfolder-directory "~/.mail/archive")
 '(nnmail-message-id-cache-file "~/.mail/nnmail-cache")


 '(gravatar-size 64)
 '(gnus-gravatar-properties '(:ascent center :relief 0))
 '(gnus-treat-from-gravatar 'head)
 '(gnus-treat-mail-gravatar 'head)
 '(gnus-treat-mail-picon 'head)
 '(gnus-treat-x-pgp-sig 'head))


(eval-after-load 'mm-decode
  '(add-to-list 'mm-inline-media-tests '("application/pgp$" mm-inline-text identity)))

(add-hook 'gnus-message-setup-hook 'mml-secure-message-sign)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)

(add-hook 'message-mode-hook 'turn-on-orgstruct++)
(add-hook 'message-mode-hook 'turn-on-orgtbl)
(add-hook 'message-mode-hook 'epa-mail-mode)
(add-hook 'message-mode-hook 'flyspell-mode)

(add-hook 'message-send-mail-hook
          (lambda ()
            (when (message-mail-p)
              (save-excursion
                (let* ((from (save-restriction
                               (message-narrow-to-headers)
                               (message-fetch-field "from")))
                       (account (cond
                                  ((string-match "gmail.com" from)
                                   "gmail")
                                  ((string-match "poshta.te.ua" from)
                                   "poshta.te.ua"))))
                  (setq message-sendmail-extra-arguments
                        (list "-a" account)))))))

(define-key gnus-summary-mode-map (kbd "[") 'gnus-summary-refer-thread)

(define-key gnus-group-mode-map "1" (lambda () (interactive) (gnus-group-list-groups 1)))
(define-key gnus-group-mode-map "2" (lambda () (interactive) (gnus-group-list-groups 2)))
(define-key gnus-group-mode-map "3" (lambda () (interactive) (gnus-group-list-groups 3)))


(defun gnus-user-format-function-d (headers)
  (let ((time (gnus-group-timestamp gnus-tmp-group)))
    (if time
        (format-time-string "%b %d %Y, %H:%M" time)
        "")))

(defadvice save-some-buffers (before save-gnus-newsrc-file activate)
  "Unconditionally save gnus newsrc file."
  (when (fboundp 'gnus-group-save-newsrc)
    (gnus-group-save-newsrc)))
