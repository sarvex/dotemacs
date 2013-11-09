;;; -*- lexical-binding: t -*-

(require 'magit)

(global-magit-wip-save-mode)

(add-hook 'magit-log-edit-mode-hook 'turn-on-auto-fill)
(add-hook 'magit-log-edit-mode-hook 'flyspell-mode)

;; solving conflicts with my windows-operating keys
(define-key magit-mode-map (kbd "M-1") nil)
(define-key magit-mode-map (kbd "M-2") nil)
(define-key magit-mode-map (kbd "M-3") nil)
(define-key magit-mode-map (kbd "M-4") nil)

(define-key magit-mode-map (kbd "M-n") 'magit-show-commit-forward)
(define-key magit-mode-map (kbd "M-p") 'magit-show-commit-backward)

(custom-set-variables
 '(magit-commit-all-when-nothing-staged 'ask-stage)
 '(magit-expand-staged-on-commit t)
 '(magit-log-auto-more t)
 '(magit-process-connection-type nil)
 '(magit-process-popup-time -1)
 '(magit-repo-dirs-depth 6)
 '(magit-save-some-buffers t)
 '(magit-status-buffer-switch-function 'switch-to-buffer))

(defun switch-to-magit-buffer ()
  "Switch to one of `magit-status' buffers."
  (interactive)
  (let ((magit-buffers (mapcar 'buffer-name (get-buffers-with-major-mode 'magit-status-mode))))
    (if magit-buffers
        (switch-to-buffer
         (if (equal 1 (length magit-buffers))
             (car magit-buffers)
           (ido-completing-read "Magit buffer: " magit-buffers)))
      (message "No `magit-status' buffers currently opened."))))
