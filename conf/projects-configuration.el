;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(projectur-rspec-use-bundler nil))

(define-key global-map (kbd "C-c f") 'projectur-find-file)
(define-key global-map (kbd "C-c p +") 'projectur-set-project-root)
(define-key global-map (kbd "C-c p .") 'projectur-show-current-file)
(define-key global-map (kbd "C-c p C-x C-s") 'projectur-save)
(define-key global-map (kbd "C-c p C-x k") 'projectur-kill-buffers)
(define-key global-map (kbd "C-c p T") 'projectur-generate-tags)
(define-key global-map (kbd "C-c p a") 'projectur-ack)
(define-key global-map (kbd "C-c p d") 'projectur-delete-from-history)
(define-key global-map (kbd "C-c p f") 'projectur-find-file)
(define-key global-map (kbd "C-c p g") 'projectur-rgrep)
(define-key global-map (kbd "C-c p r") 'projectur-goto-root)
(define-key global-map (kbd "C-c p R") 'projectur-goto-readme)
(define-key global-map (kbd "C-c p !") 'projectur-execute-shell-command)
(define-key global-map (kbd "C-c p v") 'projectur-version-control)
