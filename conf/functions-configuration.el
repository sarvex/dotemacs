(eval-when-compile
  (require 'ert)
  (require 'cl))

(defun my-duplicate-line (&optional commentfirst)
  "Copy line at point; if COMMENTFIRST is non-nil, comment out the original"
  (interactive "P")
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when commentfirst
      (comment-region (region-beginning) (region-end)))
    (insert
     (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))


(defun fbread-mode()
  (interactive)
  (sgml-mode)
  (sgml-tags-invisible 0)
  (longlines-mode)
  (view-mode))


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


(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))


(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))


(defun clean-up-region-or-buffer ()
  "Untabifies, indents and deletes trailing whitespace from buffer or region."
  (interactive)
  (save-excursion
    (unless (region-active-p)
      (mark-whole-buffer))
    (untabify-buffer)
    (indent-buffer)
    (save-restriction
      (narrow-to-region (region-beginning) (region-end))
      (delete-trailing-whitespace))))


(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis. Else go to the
   opening parenthesis one level up."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1))
        (t
         (backward-char 1)
         (cond ((looking-at "\\s\)")
                (forward-char 1) (backward-list 1))
               (t
                (while (not (looking-at "\\s("))
                  (backward-char 1)
                  (cond ((looking-at "\\s\)")
                         (message "->> )")
                         (forward-char 1)
                         (backward-list 1)
                         (backward-char 1)))))))))


(defun ido-sudo-find-file ()
  (interactive)
  (find-file (concat "/sudo::" (ido-read-file-name "File (sudo): " "/"))))


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


(defun recursively-add-to-load-path (dir)
  "Adds DIR and all its subdirs (except hidden) to `load-path'
recursively, if they contain elisp code"
  (mapc
   (lambda (file)
     (if (file-directory-p file)
         ;; process subdirectories
         (recursively-add-to-load-path file)
         ;; check if directory contains elisp files
         (when (equal (file-name-extension file) "el")
           (add-to-list 'load-path dir))))
   (directory-files dir t "^[^\\.]")))


(defun get-buffers-with-major-mode (mode)
  "Returns list of buffers with major-mode MODE."
  (loop
     for buf in (buffer-list)
     if (and (buffer-live-p buf)
             (with-current-buffer buf
               (eq major-mode mode)))
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


(defun my-change-split-type ()
  "Changes splitting from vertical to horizontal and vice-versa
for 2- or 3-windowed frames"
  (interactive)
  (let ((number-of-windows (length (window-list))))
    (cond
      ((= 2 number-of-windows)
       (let ((thisBuf (window-buffer))
             (nextBuf (progn (other-window 1) (buffer-name)))
             (split-type (if (= (window-width) (frame-width))
                             'split-window-horizontally
                             'split-window-vertically)))
         (progn
           (delete-other-windows)
           (funcall split-type)
           (set-window-buffer nil thisBuf)
           (set-window-buffer (next-window) nextBuf))))
      ((= 3 number-of-windows)
       (select-window (get-largest-window))
       (let* ((winList (window-list))
              (1stBuf (window-buffer (car winList)))
              (2ndBuf (window-buffer (cadr winList)))
              (3rdBuf (window-buffer (car (cddr winList))))
              (split-3
               (lambda (1stBuf 2ndBuf 3rdBuf split-1 split-2)
                 (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)
                 (delete-other-windows)
                 (funcall split-1)
                 (set-window-buffer nil 1stBuf)
                 (other-window 1)
                 (set-window-buffer nil 2ndBuf)
                 (funcall split-2)
                 (set-window-buffer (next-window) 3rdBuf)
                 (select-window (get-largest-window))))
              (split-type-1 nil)
              (split-type-2 nil))
         (if (= (window-width) (frame-width))
             (setq split-type-1 'split-window-horizontally
                   split-type-2 'split-window-vertically)
             (setq split-type-1 'split-window-vertically
                   split-type-2 'split-window-horizontally))
         (funcall split-3 1stBuf 2ndBuf 3rdBuf split-type-1 split-type-2))))))


(defun strip (string)
  "Strip leading and trailing whitespaces from STRING.
STRING can be string or symbol, in latter case symbol's name is used."
  (let ((string (if (symbolp string)
                    (symbol-name string)
                    string)))
    (replace-regexp-in-string "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" string)))

(ert-deftest strip ()
  (should (equal (strip "foo")            "foo"))
  (should (equal (strip "  foo  ")        "foo"))
  (should (equal (strip "\tfoo\t")        "foo"))
  (should (equal (strip "\nfoo\n")        "foo"))
  (should (equal (strip "\n \tfoo\n  \t") "foo")))

(defun chomp (string)
  "Return copy of STRING without trailing newlines."
  (replace-regexp-in-string "\n$" "" string))

(ert-deftest chomp ()
  (should (equal (chomp "foo") "foo"))
  (should (equal (chomp "foo\n") "foo"))
  (should (equal (chomp "foo\n\n") "foo")))

(defun generate-password (&optional arg)
  "Generates random password and adds it to kill-ring.
If ARG is non-nil also inserts result at point. Requires pwgen(1)"
  (interactive "P")
  (let ((pw (strip (shell-command-to-string "pwgen --secure --numerals --capitalize -1 16"))))
    (kill-new pw)
    (when arg
      (save-excursion (insert pw))
      ;; for convenient use with org tables:
      (when (org-at-table-p)
        (org-ctrl-c-ctrl-c)))))


(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (when (and (buffer-file-name buffer)
                 (not (buffer-modified-p buffer)))
        (set-buffer buffer)
        (revert-buffer t t t))
      (setq list (cdr list)
            buffer (car list))))
  (message "Refreshed open files"))


(defun toggle-current-window-dedication ()
  (interactive)
  (let* ((window (selected-window))
         (dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not dedicated))
    (message "Window %s dedicated to %s"
             (if dedicated "is no longer" "currently")
             (buffer-name))))


(defun lorem (&optional arg)
  "Insert a lorem ipsum text. With ARG olny puts it to kill ring."
  (interactive "P")
  (let ((text (concat "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
                      "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
                      "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
                      "aliquip ex ea commodo consequat. Duis aute irure dolor in "
                      "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
                      "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
                      "culpa qui officia deserunt mollit anim id est laborum.")))
    (if arg
        (kill-new text)
        (insert text))))


(defun recenter-top ()
  (interactive)
  (goto-char (point-max))
  (recenter-top-bottom 0))


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


(defun truncate-lines ()
  (setq truncate-lines t))

(defun truncate-lines-off ()
  (setq truncate-lines nil))

(defun find-tag-in-project ()
  (interactive)
  (let ((current-dir (expand-file-name default-directory))
        tags)
    (setq tags
          (catch :terminate-search
            (while t
              (when (equal current-dir "/")
                (throw :terminate-search nil))
              (setq tags (expand-file-name "TAGS" current-dir))
              (if (file-exists-p tags)
                  (throw :terminate-search tags)
                  (setq current-dir (expand-file-name ".." current-dir))))))
    (if tags
        (progn
          (setq tags-file-name tags
                tags-table-list nil)
          (call-interactively 'find-tag))
        (message "no tags file found"))))

(defun indent-region-or-buffer ()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (call-interactively 'indent-region)
        (indent-region (region-beginning) (region-end)))))

(defun turn-on-flymake-mode ()
  (flymake-mode t))

(defun snake-case (text)
  "Return snake_case version of TEXT.
Works with 'names with spaces', names-with-dashes, camelCase,
UpperCamelCase and combinations of those."
  (let ((case-fold-search nil))
    (flet ((downcase-first-character (text)
             (when (string-match-p "^[[:upper:]]" text)
               (let ((first-char (substring text 0 1)))
                 (setq text (replace-regexp-in-string "^." "" text)
                       text (format "%s%s" (downcase first-char) text))))
             text)
           (insert-underscores-before-upcase-letters (text)
             (replace-regexp-in-string "[[:upper:]]" "_\\&" text))
           (replace-dashes-and-spaces-with-underscores (text)
             (replace-regexp-in-string  "-\\| " "_" text))
           (get-rid-of-multiple-underscores-in-row (text)
             (replace-regexp-in-string "_+" "_" text)))

      (setq text (downcase-first-character text)
            text (replace-dashes-and-spaces-with-underscores text)
            text (insert-underscores-before-upcase-letters text)
            text (get-rid-of-multiple-underscores-in-row text))
      (downcase text))))

(ert-deftest snake-case-test-spaces ()
  (should (equal (snake-case " foo bar baz ")
                 "_foo_bar_baz_")))

(ert-deftest snake-case-test-dashes ()
  (should (equal (snake-case "-foo-bar-baz-")
                 "_foo_bar_baz_")))

(ert-deftest snake-case-test-lowerCamelCase ()
  (should (equal (snake-case "fooBarBaz")
                 "foo_bar_baz")))

(ert-deftest snake-case-test-UpperCamelCase ()
  (should (equal (snake-case "FooBarBaz")
                 "foo_bar_baz")))

(ert-deftest snake-case-test-combination-of-stuff ()
  (should (equal (snake-case "Foo-barBaz quux_Corge--GraultABC")
                 "foo_bar_baz_quux_corge_grault_a_b_c")))
(defun foo (count)
  "Inserts at point position COUNT metasyntactic variable names separated by spaces.
Compatible with RFC-3092."
  (interactive "p")
  (insert
   (mapconcat
    'identity
    (loop
       repeat count
       with foos = '("bar" "baz" "qux" "quux" "corge"
                     "grault" "garply" "waldo" "fred"
                     "plugh" "xyzzy" "thud")
       for foo = (nth (random (length foos)) foos)
       collect foo)
    " ")))
