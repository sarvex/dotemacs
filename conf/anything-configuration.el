(setq anything-command-map-prefix-key "C-c a"
      anything-debug nil
      anything-google-suggest-use-curl-p t)

(require 'anything-startup)

(define-key global-map (kbd "M-y") 'anything-show-kill-ring)
(define-key global-map (kbd "C-x f") 'anything-recentf)
(define-key global-map (kbd "C-c a g") 'anything-google-suggest)
(define-key global-map (kbd "C-c a :") 'anything-eval-expression-with-eldoc)
