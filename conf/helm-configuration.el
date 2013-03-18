;;; -*- lexical-binding: t -*-

(require 'helm-config)

(custom-set-variables
 '(helm-buffer-max-length 40)
 '(helm-c-default-external-file-browser "pcmanfm")
 '(helm-c-kill-ring-max-lines-number 5)
 '(helm-candidate-number-limit 1000)
 '(helm-command-prefix-key "C-c h")
 '(helm-google-suggest-use-curl-p t)
 '(helm-split-window-preferred-function (lambda (_) (cadr (popwin:create-popup-window 25)))))

(define-key global-map (kbd "C-c h") helm-command-map)

(define-key global-map (kbd "C-c h t") 'helm-world-time)
(define-key global-map (kbd "C-c h o") 'helm-occur)
(define-key global-map (kbd "C-x f") 'helm-recentf)
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)
