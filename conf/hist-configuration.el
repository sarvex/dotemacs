;;; -*- lexical-binding: t -*-

(require 'desktop)

(custom-set-variables
 '(recentf-save-file "~/.emacs.d/recentf")
 '(recentf-max-saved-items 3000)
 '(recentf-exclude
   (list
    (rx not-newline "." (or (and "jp" (optional "e") "g")
                            (and "tif" (optional "f"))
                            (and "x" (char "bp") "m")
                            "gif" "bmp" "ico" "png"
                            "zip" "tar" "rar" "xpi" "crx" "oex" "elc" "rbc" "pyc" "class")
        string-end)
    (rx (eval (expand-file-name "~/code/")))
    (rx (or "Thumbs.db" "~") string-end))))

(recentf-mode t)
(add-hook 'kill-emacs-hook 'recentf-cleanup)


(custom-set-variables
 '(desktop-path '("~/.emacs.d/"))
 '(desktop-load-locked-desktop t)
 '(desktop-save t)
 '(desktop-restore-frames nil)
 '(desktop-files-not-to-save ""))

(desktop-save-mode t)

(mapc
 (lambda (sym)
   (add-to-list 'desktop-globals-to-save sym))
 '(
   dired-shell-command-history
   extended-command-history
   kmacro-ring
   projectur-history
   read-expression-history
   shell-command-history
   ))

(mapc
 (lambda (sym)
   (setq desktop-globals-to-save (delq sym desktop-globals-to-save)))
 '(
   file-name-history
   regexp-search-ring
   search-ring
   ))

(add-hook 'desktop-save-hook
          (lambda ()
            "Remove duplicates and items starting with space in saved variables."
            (mapc
             (lambda (var)
               (when (and (boundp var) (listp (symbol-value var)))
                 (set var (delete-dups
                           (cl-remove-if
                            (lambda (elem)
                              (and (stringp elem) (string-prefix-p " " elem)))
                            (symbol-value var))))))
             desktop-globals-to-save)))
