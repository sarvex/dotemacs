(setq isearch-allow-scroll t)

;; I-search with initial contents

(defvar isearch-initial-string nil)

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
      (let* ((end (progn (skip-syntax-forward "w_") (point)))
             (begin (progn (skip-syntax-backward "w_") (point))))
        (if (eq begin end)
            (isearch-forward regexp-p no-recursive-edit)
            (setq isearch-initial-string (buffer-substring begin end))
            (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
            (isearch-forward regexp-p no-recursive-edit)))))

(defun isearch-backward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search backward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-backward regexp-p no-recursive-edit)
      (let* ((end (progn (skip-syntax-backward "w_") (point)))
             (begin (progn (skip-syntax-forward "w_") (point))))
        (if (eq begin end)
            (isearch-backward regexp-p no-recursive-edit)
            (setq isearch-initial-string (buffer-substring begin end))
            (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
            (isearch-backward regexp-p no-recursive-edit)))))

(define-key global-map (kbd "C-S-s") 'isearch-forward-at-point)
(define-key global-map (kbd "C-S-r") 'isearch-backward-at-point)