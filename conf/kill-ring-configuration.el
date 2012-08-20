(setq delete-active-region nil)

(define-key global-map (kbd "C-w") 'backward-kill-word)
(define-key global-map (kbd "C-x C-k") 'kill-region)

(define-key global-map (kbd "M-w")
  (lambda ()
    (interactive)
    (if (region-active-p)
        (call-interactively 'kill-ring-save)
        (kill-ring-save
         (line-beginning-position)
         (line-beginning-position 2))
        (message "Copied line"))))

(define-key global-map (kbd "C-x C-k")
  (lambda ()
    (interactive)
    (if (region-active-p)
        (call-interactively 'kill-region)
        (kill-region
         (line-beginning-position)
         (line-beginning-position 2))
        (message "Killed line"))))
