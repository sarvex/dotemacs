(setq ahg-subprocess-coding-system 'utf-8
      ahg-global-key-prefix (kbd "C-c h g"))

(defun vderyagin/ahg-status-hook ()
  (define-key ahg-status-mode-map (kbd "m") 'ahg-status-toggle-mark)
  (define-key ahg-status-mode-map (kbd "n") 'next-line)
  (define-key ahg-status-mode-map (kbd "<SPC>") 'next-line)
  (define-key ahg-status-mode-map (kbd "p") 'previous-line)
  (define-key ahg-status-mode-map (kbd "P")
    (lambda () (interactive) (ahg-do-command "push"))))

(eval-after-load 'ahg
  '(add-hook 'ahg-status-mode-hook 'vderyagin/ahg-status-hook))


;; MQ patches:

(add-to-list 'auto-mode-alist '("\\.hg/patches\\(?:-[^/]+\\)?/" . diff-mode))

(defun mq-patch-set-default-directory ()
  (when (string= ".hg" (nth 2 (reverse (split-string default-directory "/"))))
    (setq default-directory (expand-file-name (concat default-directory "../../")))))

(add-hook 'diff-mode-hook 'mq-patch-set-default-directory)
