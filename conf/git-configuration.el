;;; -*- lexical-binding: t -*-

(require 'magit)

(magit-wip-mode 1)
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
 '(magit-log-auto-more t)
 '(magit-process-connection-type nil)
 '(magit-process-popup-time 5)
 '(magit-repo-dirs-depth 6)
 '(magit-save-some-buffers t)
 '(magit-status-buffer-switch-function 'switch-to-buffer))
