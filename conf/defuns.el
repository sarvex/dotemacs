;;; -*- lexical-binding: t -*-

(defun duplicate-line (&optional times)
  "Copy line at point TIMES times."
  (interactive "p")
  (let* ((beg (save-excursion (beginning-of-line) (point)))
         (end (save-excursion (end-of-line) (point)))
         (str (buffer-substring beg end)))
    (loop repeat times
       do (save-excursion
            (end-of-line)
            (insert "\n" str)))
    (call-interactively 'next-line)))


(defun rename-file-and-buffer ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer '%s' is not visiting a file!" name)
        (let ((new-name (read-file-name "New name: " filename)))
          (cond ((get-buffer new-name)
                 (message "A buffer named '%s' already exists!" new-name))
                (t
                 (rename-file name new-name 1)
                 (rename-buffer new-name)
                 (set-visited-file-name new-name)
                 (set-buffer-modified-p nil)))))))


(defun delete-file-and-buffer ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
        (when (yes-or-no-p "Are you sure you want to remove this file? ")
          (delete-file filename)
          (kill-buffer buffer)
          (message "File '%s' successfully removed" filename)))))


(defun comment-or-uncomment-current-line-or-region ()
  "Comments or uncomments (if already commented) current line or lines in region."
  (interactive)
  (save-excursion
    (let (min max)
      (if (region-active-p)
          (setq min (region-beginning) max (region-end))
          (setq min (point) max (point)))
      (comment-or-uncomment-region
       (progn (goto-char min) (line-beginning-position))
       (progn (goto-char max) (line-end-position))))))


(defun ido-sudo-find-file ()
  (interactive)
  (find-file (concat "/sudo::" (ido-read-file-name "Find file (sudo): " "/"))))


(defun minor-modes ()
  "Get the list of minor modes for the current buffer."
  (let (minor-modes)
    ;; Older packages do not register in minor-mode-list but only in
    ;; minor-mode-alist.
    (mapc
     (lambda (x)
       (setq x (car x))
       (unless (memq x minor-mode-list)
         (push x minor-mode-list)))
     minor-mode-alist)
    ;; Find enabled minor mode we will want to mention.
    (mapc
     (lambda (mode)
       ;; Document a minor mode if it is listed in minor-mode-alist,
       ;; non-nil, and has a function definition.
       (let ((fmode (or (get mode :minor-mode-function) mode)))
         (and (boundp mode) (symbol-value mode)
              (fboundp fmode)
              (push fmode minor-modes))))
     minor-mode-list)
    minor-modes))


(defun get-buffers-with-major-mode (mode)
  "Returns list of buffers with major-mode MODE or derived from MODE."
  (loop
     for buf in (buffer-list)
     if (and (buffer-live-p buf)
             (with-current-buffer buf
               (derived-mode-p mode)))
     collect buf))


(defun transpose-windows (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0)
                      'next-window
                      'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg)
                    (1- arg)
                    (1+ arg))))))


(defun split-change-direction ()
  "Changes splitting from vertical to horizontal and vice-versa for 2-windowed frames."
  (interactive)
  (let ((nwin (length (window-list))))
    (cond
      ((= 1 nwin)
       (message "Can not change split direction for single-window frame."))
      ((= 2 nwin)
       (let ((this-buf (window-buffer))
             (next-buf (progn (other-window 1) (buffer-name)))
             (split-direction (if (>= (window-total-width) (frame-width))
                                  'split-window-horizontally
                                  'split-window-vertically)))
         (delete-other-windows)
         (funcall split-direction)
         (set-window-buffer nil this-buf)
         (set-window-buffer (next-window) next-buf)))
      (t
       (message "This command works for 2 windows only, %d is too much." nwin)))))


(defun generate-password (&optional arg)
  "Generates random password and adds it to kill-ring.
If ARG is non-nil also inserts result at point. Requires pwgen(1)"
  (interactive "P")
  (let ((pw (replace-regexp-in-string
             "\n\\'" ""
             (shell-command-to-string "pwgen --secure --numerals --capitalize -1 16"))))
    (kill-new pw)
    (when arg
      (save-excursion (insert pw))
      ;; for convenient use with org tables:
      (when (and (fboundp 'org-at-table-p)
                 (org-at-table-p))
        (org-ctrl-c-ctrl-c)))))


(defun toggle-current-window-dedication ()
  (interactive)
  (let* ((window (selected-window))
         (dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not dedicated))
    (message "Window is %s dedicated to %s"
             (if dedicated "no longer" "currently")
             (buffer-name))))


(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))


(defun recompile-init (&optional force)
  "Byte-compile all emacs configs."
  (interactive "P")
  (byte-recompile-directory "~/.emacs.d/dotemacs/conf" 0 force))


(defun shuffle-lines (beg end)
  "Shuffle lines in region."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ((inhibit-field-text-motion t))
        (sort-subr nil 'forward-line 'end-of-line nil nil
                   (lambda (&rest _) (eq (random 2) 0)))))))


(defun gist ()
  "gist current file, clone repository and show it in dired"
  (interactive)
  (call-interactively 'gist-region-or-buffer)
  (lexical-let* ((gists-dir (expand-file-name "~/repos/gists"))
                 (gist-url-regexp (rx string-start "https://gist.github.com/" (group (+ (char hex-digit))) string-end))
                 (url (car kill-ring))
                 (gist-id (progn
                            (string-match gist-url-regexp url)
                            (match-string 1 url)))
                 (gist-dir (expand-file-name gist-id gists-dir)))
    (set-process-sentinel
     (start-process "gist-clone" nil "gist-clone" gist-id)
     (lambda (_ event)
       (when (string= event "finished\n")
         (dired gist-dir))))))


(defun unfill-paragraph-or-region ()
  "Make a paragraph (or region) into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (call-interactively
     (if (region-active-p)
         'fill-region
         'fill-paragraph))))


(defun compile-no-comint (&optional arg)
  "Run `compile', when prefix ARG is non-nil first ask for shell command to run.
Avoids `compilation-shell-minor-mode' in *compilation* buffer."
  (interactive "P")
  (let ((compilation-read-command arg)
        (current-prefix-arg nil))
    (call-interactively 'compile)))


(defun find-symbol-at-point ()
  "Find definition of symbol at point in the other window."
  (interactive)
  (let ((sym (symbol-at-point)))
    (call-interactively
     (cond
       ((fboundp sym)
        'find-function-at-point)
       ((boundp sym)
        'find-variable-at-point)
       (t
        (error "Symbol `%s' not found" (symbol-name sym)))))))
