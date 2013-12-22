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
    (rx (or "Thumbs.db" "~") string-end))))

(recentf-mode t)
(add-hook 'kill-emacs-hook 'recentf-cleanup)


(custom-set-variables
 '(desktop-path '("~/.emacs.d/"))
 '(desktop-load-locked-desktop t)
 '(desktop-save t)
 '(desktop-restore-frames nil)
 '(desktop-files-not-to-save
   (rx (or
        (and line-start "/" (* (not (any "/:"))) ":")
        (and "(ftp)" line-end)
        (and ".gpg" string-end)
        "/.emacs.d/recentf"
        (and "loaddefs.el" string-end)
        (and "/" (or "org-clock-save.el" "bmk-bmenu-state.el" "ido-history" "newsrc-dribble") string-end)
        (eval (expand-file-name "~/repos/"))
        (eval (expand-file-name "~/org/"))))))

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

(add-hook 'desktop-save-hook
          (lambda ()
            "Remove duplicates in saved variables."
            (mapc
             (lambda (var)
               (when (boundp var)
                 (setq var (delete-dups (symbol-value var)))))
             desktop-globals-to-save)))
