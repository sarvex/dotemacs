(setq directory-free-space-args "-Pkh"
      dired-dwim-target t
      dired-isearch-filenames nil
      dired-keep-marker-rename nil
      dired-keep-marker-copy nil
      dired-keep-marker-hardlink nil
      dired-keep-marker-symlink nil
      dired-listing-switches "-hAFl --group-directories-first"
      dired-ls-F-marks-symlinks t
      list-directory-brief-switches "-CF1shA"
      list-directory-verbose-switches "-lhA"
      wdired-allow-to-change-permissions 'advanced
      wdired-allow-to-redirect-links t)

(setq dired-details-hide-extra-lines t
      dired-details-hide-link-targets nil
      dired-details-hidden-string "")

(setq image-dired-external-viewer "feh"
      image-dired-line-up-method 'dynamic
      image-dired-show-all-from-dir-max-files 150
      image-dired-thumb-height 160
      image-dired-thumb-margin 4
      image-dired-thumb-relief 0
      image-dired-thumb-size 196
      image-dired-thumb-width 196)

(defun my-next-subdir-of-current-dir-parent (&optional jump)
  "Moves to the n-th next directory of the same level"
  (interactive "P")
  (if (and (dired-up-directory)
           (dired-next-dirline
            (if jump (prefix-numeric-value jump) 1)))
      (diredp-find-file-reuse-dir-buffer)))

(defun my-previous-subdir-of-current-dir-parent (&optional jump)
  "Moves to the n-th previous directory of the same level"
  (interactive "P")
  (if (and (dired-up-directory)
           (dired-prev-dirline
            (if jump (prefix-numeric-value jump) 1)))
      (diredp-find-file-reuse-dir-buffer)))

(defun dired-get-size ()
  "Get size of marked files"
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message "Size of all marked files: %s"
               (progn
                 (re-search-backward "\\(^[0-9.,]+[A-Za-z]+\\).*total$")
                 (match-string 1))))))

(defun dired-next-file-line ()
  "Moves to the next dired line that have a file or directory name on it"
  (interactive)
  (call-interactively 'dired-next-line)
  (if (not (or (dired-move-to-filename) (eobp)))
      (dired-next-file-line)))

(defun dired-previous-file-line ()
  "Moves to the previous dired line that have a file or directory name on it"
  (interactive)
  (call-interactively 'dired-previous-line)
  (if (not (or (dired-move-to-filename) (bobp)))
      (dired-previous-file-line)))

(defun my-dired-mode-hook ()
  (setq truncate-lines t))

(eval-after-load 'dired
  '(progn

    (require 'dired-x)
    (require 'dired+)
    (require 'dired-details+)

    (diredp-toggle-find-file-reuse-dir 1)

    (setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))

    (defadvice dired-advertised-find-file (around dired-subst-directory activate)
     "Replace current buffer if file is a directory."
     (interactive)
     (let ((orig (current-buffer))
           (filename (dired-get-filename)))
       ad-do-it
       (when (and (file-directory-p filename)
                  (not (eq (current-buffer) orig)))
         (kill-buffer orig))))

    (defun dired-up-directory (&optional other-window)
      "Run Dired on parent directory of current directory."
      (interactive "P")
      (let* ((dir (dired-current-directory))
             (orig (current-buffer))
             (up (file-name-directory (directory-file-name dir))))
        (or (dired-goto-file (directory-file-name dir))
            ;; Only try dired-goto-subdir if buffer has more than one dir.
            (and (cdr dired-subdir-alist)
                 (dired-goto-subdir up))
            (progn
              (kill-buffer orig)
              (dired up)
              (dired-goto-file dir)))))

    (define-key dired-mode-map (kbd "M-n") 'my-next-subdir-of-current-dir-parent)
    (define-key dired-mode-map (kbd "M-p") 'my-previous-subdir-of-current-dir-parent)
    (define-key dired-mode-map (kbd "C-?") 'dired-get-size)
    (define-key dired-mode-map (kbd ";") 'dired-up-directory)
    (define-key dired-mode-map (kbd "p") 'dired-previous-file-line)
    (define-key dired-mode-map (kbd "n") 'dired-next-file-line)
    (define-key dired-mode-map (kbd "C-w") 'dired-unmark-backward)
    (define-key dired-mode-map (kbd "<down>") nil)
    (define-key dired-mode-map (kbd "<up>") nil)
    (define-key dired-mode-map (kbd "M-=") nil)
    (define-key dired-mode-map (kbd "M-b") 'backward-word)
    (define-key dired-mode-map (kbd "<SPC>") 'dired-next-file-line)
    (define-key dired-mode-map (kbd "q") (lambda () (interactive) (kill-buffer-ask (current-buffer))))

    (add-hook 'dired-mode-hook 'my-dired-mode-hook)))

(eval-after-load 'wdired
  '(progn
    (define-key wdired-mode-map (kbd "<down>") nil)
    (define-key wdired-mode-map (kbd "<up>") nil)))
