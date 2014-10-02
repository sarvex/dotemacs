;;; -*- lexical-binding: t -*-

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

(recentf-mode)
(add-hook 'kill-emacs-hook 'recentf-cleanup)


(savehist-mode)

(custom-set-variables
 '(savehist-additional-variables '(
                                   dired-shell-command-history
                                   extended-command-history
                                   kmacro-ring
                                   projectur-history
                                   read-expression-history
                                   register-alist
                                   shell-command-history
                                   ))
 '(savehist-autosave-interval 300)
 '(savehist-save-minibuffer-history nil))

(add-hook 'savehist-save-hook
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
             savehist-additional-variables)))
