(define-key global-map (kbd "C-c g") 'magit-status)

(setq magit-commit-all-when-nothing-staged 'ask-stage
      magit-repo-dirs-depth 6
      magit-status-buffer-switch-function 'switch-to-buffer)

(eval-after-load 'magit
  '(progn
    ;; solving conflicts with my windows-operating keys
    (define-key magit-mode-map (kbd "M-1") nil)
    (define-key magit-mode-map (kbd "M-2") nil)
    (define-key magit-mode-map (kbd "M-3") nil)
    (define-key magit-mode-map (kbd "M-4") nil)
    (add-hook 'magit-log-edit-mode-hook 'turn-on-auto-fill)))

(setq gist-authenticate-function ' gist-basic-authentication
      ;; gist-authenticate-function 'gist-oauth2-authentication
      gist-user-password my-github-password
      gist-view-gist t
      github-user my-github-username
      github-token my-github-token)

(eval-after-load 'gist
  '(require 'eieio))
