;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(bookmark-default-file "~/.emacs.d/bookmarks/default")
 '(bookmark-save-flag 1)
 '(bookmark-bmenu-file-column 52)
 '(bmkp-other-window-pop-to-flag nil)
 '(bmkp-bmenu-commands-file "~/.emacs.d/bmk-bmenu-commands.el")
 '(bmkp-bmenu-state-file "~/.emacs.d/bmk-bmenu-state.el")
 '(bmkp-bookmark-name-length-max 50))

(require 'bookmark+)

(defun bookmarks--choose-bookmark-file ()
  (let* ((bookmarks-dir (expand-file-name "~/.emacs.d/bookmarks"))
         (bookmark-files (cl-remove-if-not #'file-regular-p
                                           (directory-files bookmarks-dir 'full-path))))
    (unless bookmark-files
      (error "No bookmark files found"))

    (if (equal 1 (length bookmark-files))
        (car bookmark-files)
      (expand-file-name
       (ido-completing-read "Switch to bookmark file: "
                            (mapcar #'file-name-base bookmark-files))
       bookmarks-dir))))

(defun switch-to-bookmark-file ()
  (interactive)
  (let ((file (bookmarks--choose-bookmark-file)))
    (unless (get-buffer "*Bookmark List*")
      (list-bookmarks))

    (switch-to-buffer (get-buffer "*Bookmark List*"))

    (unless (string= (expand-file-name bmkp-current-bookmark-file)
                     file)
      (bmkp-switch-bookmark-file file))))

(with-eval-after-load 'bookmark+
  (require 'ffap)
  (define-key bookmark-bmenu-mode-map (kbd "<tab>") 'switch-to-bookmark-file))
