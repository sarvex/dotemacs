(setq anything-command-map-prefix-key "C-c a"
      anything-debug nil
      anything-google-suggest-use-curl-p t)

(require 'anything-config)
(require 'anything-match-plugin)

(define-key global-map (kbd "M-y") 'anything-show-kill-ring)
