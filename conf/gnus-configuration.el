;;; -*- lexical-binding: t -*-

(require 'gnus-html)
(require 'epg)

(custom-set-variables
 '(gnus-select-method '(nntp "news.gmane.org"))
 '(gnus-always-read-dribble-file t)
 '(gnus-extract-address-components 'mail-extract-address-components)
 '(gnus-buttonized-mime-types '("multipart/alternative"
                                "multipart/encrypted"
                                "multipart/signed"))

 '(gnus-secondary-select-methods
   '((nnimap "gmail"
      (nnimap-address "imap.gmail.com")
      (nnimap-server-port 993)
      (nnimap-stream ssl))))

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
 '(gnus-group-line-format "%M\%S\%p\%P\%5y: %(%-60,60g%) %ud\n")

 '(gnus-check-new-newsgroups nil)
 '(gnus-save-killed-list nil)
 '(gnus-asynchronous t)
 '(gnus-save-newsrc-file nil)
 '(gnus-auto-select-next nil)
 '(gnus-summary-check-current t)
 '(gnus-auto-extend-newsgroup t)
 '(gnus-article-truncate-lines nil)
 '(gnus-break-pages nil)
 '(gnus-body-boundary-delimiter nil)
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

 '(gnus-treat-from-gravatar 'head)
 '(gnus-treat-mail-gravatar 'head)
 '(gnus-treat-mail-picon 'head)
 '(gnus-treat-x-pgp-sig 'head))


(eval-after-load 'mm-decode
  '(progn
    (add-to-list 'mm-inlined-types "application/pgp$")
    (add-to-list 'mm-inline-media-tests '("application/pgp$" mm-inline-text identity))
    (add-to-list 'mm-automatic-display "application/pgp$")
    (setq mm-automatic-display (remove "application/pgp-signature" mm-automatic-display))))

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
                  (setq message-sendmail-extra-arguments (list "-a" account)))))))

(define-key gnus-summary-mode-map (kbd "[") 'gnus-summary-refer-thread)

(defun gnus-user-format-function-d (headers)
  (let ((time (gnus-group-timestamp gnus-tmp-group)))
    (if time
        (format-time-string "%b %d %Y, %H:%M" time)
        "")))

(defadvice save-some-buffers (before save-gnus-dribble-file activate)
  "Unconditionally save gnus dribble file."
  (let ((buf (get-buffer "newsrc-dribble")))
    (when buf
      (with-current-buffer buf
        (save-buffer)))))
