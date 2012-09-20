(define-key global-map (kbd "C-c g") 'magit-status)

(setq magit-commit-all-when-nothing-staged 'ask-stage
      magit-repo-dirs-depth 6
      magit-process-popup-time 5
      magit-save-some-buffers t
      magit-log-auto-more t
      magit-status-buffer-switch-function 'switch-to-buffer)

(defun my-magit-log-edit-hook ()
  (turn-on-auto-fill)
  (flyspell-mode t))

(eval-after-load 'magit
  '(progn
    ;; solving conflicts with my windows-operating keys
    (define-key magit-mode-map (kbd "M-1") nil)
    (define-key magit-mode-map (kbd "M-2") nil)
    (define-key magit-mode-map (kbd "M-3") nil)
    (define-key magit-mode-map (kbd "M-4") nil)

    (define-key magit-mode-map (kbd "M-n") 'magit-show-commit-forward)
    (define-key magit-mode-map (kbd "M-p") 'magit-show-commit-backward)

    (add-hook 'magit-log-edit-mode-hook 'my-magit-log-edit-hook)))

(setq gist-authenticate-function 'gist-basic-authentication
      github-user my-github-username
      gist-user-password my-github-password
      gist-view-gist nil
      gist-working-directory "~/repos/gists")
