(defun my-magit-log-edit-mode-hook ()
  (auto-fill-mode t))

(define-key global-map (kbd "C-c g") 'magit-status)

(setq magit-commit-all-when-nothing-staged 'ask-stage
      magit-repo-dirs-depth 6
      magit-status-buffer-switch-function 'pop-to-buffer-same-window)

(eval-after-load 'magit
  '(progn
    ;; solving conflicts with my windows-operating keys
    (define-key magit-mode-map (kbd "M-1") nil)
    (define-key magit-mode-map (kbd "M-2") nil)
    (define-key magit-mode-map (kbd "M-3") nil)
    (define-key magit-mode-map (kbd "M-4") nil)
    (add-hook 'magit-log-edit-mode-hook 'my-magit-log-edit-mode-hook)))


(setq gist-view-gist t
      github-user my-github-username
      github-token my-github-token)
