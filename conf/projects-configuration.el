(setq projectur-rspec-use-bundler t)

(define-key global-map (kbd "C-c f") 'projectur-find-file)

(define-key global-map (kbd "C-c p .") 'projectur-show-current-file)
(define-key global-map (kbd "C-c p C-x C-s") 'projectur-save)
(define-key global-map (kbd "C-c p a") 'projectur-ack)
(define-key global-map (kbd "C-c p d") 'projectur-delete-from-history)
(define-key global-map (kbd "C-c p f") 'projectur-find-file)
(define-key global-map (kbd "C-c p g") 'projectur-rgrep)
(define-key global-map (kbd "C-c p r") 'projectur-goto-root)
(define-key global-map (kbd "C-c p s") 'projectur-execute-shell-command)
(define-key global-map (kbd "C-c p t") 'projectur-generate-tags)
(define-key global-map (kbd "C-c p v") 'projectur-version-control)
