(setq anything-command-map-prefix-key "C-c a"
      anything-debug nil
      anything-google-suggest-use-curl-p t)

(eval-after-load 'anything
  '(require 'anything-startup))

(define-key global-map (kbd "M-y") 'anything-show-kill-ring)
