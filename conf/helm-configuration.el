(setq helm-c-kill-ring-max-lines-number 5
      helm-candidate-number-limit 500
      helm-command-prefix-key "C-c h"
      helm-google-suggest-use-curl-p t)

(define-key global-map (kbd "C-c h") helm-command-map)

(require 'helm-config)

(define-key global-map (kbd "C-c h o") 'helm-occur)
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)
(define-key global-map (kbd "C-x f") 'helm-recentf)
