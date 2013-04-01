;;; -*- lexical-binding: t; coding: utf-8 -*-

(require 'gnus-html)

(custom-set-variables
 '(gnus-select-method '(nntp "news.gmane.org"))

 '(gnus-secondary-select-methods
   '((nnimap "gmail"
      (nnimap-address "imap.gmail.com")
      (nnimap-server-port 993)
      (nnimap-stream ssl))
     (nnml "")))

 '(mail-sources
   `((pop
      :server "mail.poshta.te.ua"
      :user ,vderyagin/poshta.te.ua-username
      :password ,vderyagin/poshta.te.ua-password)))

 '(gnus-always-read-dribble-file t)
 '(gnus-extract-address-components 'mail-extract-address-components)
 '(gnus-buttonized-mime-types '("multipart/alternative"
                                "multipart/encrypted"
                                "multipart/signed"))

 '(mm-discouraged-alternatives '("text/html"))

 '(mm-decrypt-option 'known)
 '(mm-inline-large-images t)
 '(mm-inline-text-html-with-images t)
 '(mm-text-html-renderer 'shr)
 '(mm-verify-option 'known)

 '(message-send-mail-function 'message-send-mail-with-sendmail)
 '(message-sendmail-envelope-from 'header)
 '(sendmail-program "msmtp")

 '(gnus-summary-line-format "%U%R%z%I%(%[%4L: %-23,23f%]%) %s\n")
 '(gnus-summary-mode-line-format "Gnus: %p [%A] %Z")
 '(gnus-article-mode-line-format "Gnus: %p [%w] %Z %S")
 '(gnus-topic-line-format "%i[ %(%{%n%}%) — %A ]%v\n")
 '(gnus-group-line-format "%M%S%p%P%5y: %(%-50,50g%) %ud\n")

 '(gnus-article-truncate-lines nil)
 '(gnus-asynchronous t)
 '(gnus-auto-extend-newsgroup t)
 '(gnus-auto-select-first t)
 '(gnus-auto-select-next nil)
 '(gnus-auto-select-subject 'first)
 '(gnus-break-pages nil)
 '(gnus-check-new-newsgroups nil)
 '(gnus-group-default-list-level 1)
 '(gnus-keep-backlog 150)
 '(gnus-save-killed-list nil)
 '(gnus-save-newsrc-file nil)
 '(gnus-summary-gather-subject-limit 'fuzzy)
 '(gnus-thread-indent-level 2)
 '(gnus-topic-display-empty-topics t)
 '(gnus-use-cache t)

 '(gnus-treat-body-boundary nil)
 '(gnus-treat-fill-article t)
 '(gnus-treat-from-gravatar 'head)
 '(gnus-treat-hide-signature t)
 '(gnus-treat-mail-gravatar 'head)
 '(gnus-treat-mail-picon 'head)
 '(gnus-treat-strip-leading-blank-lines t)
 '(gnus-treat-strip-multiple-blank-lines t)
 '(gnus-treat-strip-trailing-blank-lines t)
 '(gnus-treat-x-pgp-sig 'head)

 '(gnus-agent-directory "~/.mail/gnus/agent")
 '(gnus-article-save-directory "~/.mail/gnus")
 '(gnus-default-directory "~/.mail/gnus")
 '(gnus-directory "~/.mail/gnus")
 '(gnus-home-directory "~/.mail/gnus")
 '(gnus-kill-files-directory "~/.mail/gnus")
 '(gnus-startup-file "~/.mail/gnus/newsrc")

 '(gnus-cache-active-file "~/.mail/gnus/cache/active")
 '(gnus-cache-directory "~/.mail/gnus/cache/")
 '(mail-default-directory "~/.mail")
 '(mail-source-directory "~/.mail")
 '(message-auto-save-directory "~/.mail/drafts/")
 '(message-directory "~/.mail")
 '(nndraft-current-directory "~/.mail/gnus/nndraft")
 '(nndraft-directory "~/.mail/gnus/nndraft")
 '(nnfolder-active-file "~/.mail/archive/active")
 '(nnfolder-directory "~/.mail/archive")
 '(nnmail-message-id-cache-file "~/.mail/nnmail-cache")

 '(gnus-gravatar-properties '(:ascent center :relief 0))
 '(gnus-gravatar-size 64))


(eval-after-load 'mm-decode
  '(add-to-list 'mm-inline-media-tests '("application/pgp$" mm-inline-text identity)))

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
(define-key gnus-summary-mode-map (kbd "w") 'gnus-summary-wide-reply)


(dolist (key (mapcar 'number-to-string (number-sequence 1 5)))
  (define-key gnus-group-mode-map key
    (lambda ()
      (interactive)
      (gnus-group-list-groups (- last-command-event ?0)))))


(defun gnus-user-format-function-d (_)
  (let ((time (gnus-group-timestamp gnus-tmp-group)))
    (if time
        (format-time-string "%b %d %Y, %H:%M" time)
        "")))

(defadvice save-some-buffers (before save-gnus-newsrc-file activate)
  "Unconditionally save gnus newsrc file."
  (when (fboundp 'gnus-group-save-newsrc)
    (gnus-group-save-newsrc)))
