;;; -*- lexical-binding: t -*-

(make-face 'vderyagin-twittering-username-face)
(make-face 'vderyagin-twittering-metainfo-face)

(setq twittering-auth-method 'xauth
      twittering-private-info-file (expand-file-name "~/.emacs.d/dotemacs/misc/twittering.gpg")
      twittering-timer-interval 150
      twittering-use-master-password t
      twittering-status-format (concat
                                "%i %FACE[vderyagin-twittering-username-face]{%s} (%S), %@:\n"
                                "%FILL[ ]{%T}\n"
                                "%FILL[  ]{%FACE[vderyagin-twittering-metainfo-face]{from %f%L%r%R}}"))

(eval-after-load 'twittering-mode
  '(progn
    (mapc
     (lambda (item)
       (twittering-add-timeline-history item))
     vderyagin/twittering-additional-timelines)

    (add-hook 'twittering-mode-hook (lambda () (twittering-icon-mode 1)))
    (add-hook 'twittering-mode-hook 'turn-on-visual-line-mode)
    (add-hook 'twittering-edit-mode-hook 'turn-on-visual-line-mode)

    (define-key twittering-mode-map (kbd "RET") 'twittering-click)))


(defun switch-to-twittering-buffer()
  "Switch to one of the `twittering-mode' buffers or launch `twittering-mode' if none."
  (interactive)
  (let ((twittering-buffers (mapcar 'buffer-name (get-buffers-with-major-mode 'twittering-mode))))
    (if twittering-buffers
        (switch-to-buffer
         (if (equal 1 (length twittering-buffers))
             (car twittering-buffers)
             (ido-completing-read "Twitter timeline: " twittering-buffers)))
        (twit))))
