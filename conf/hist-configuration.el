;; Savehist

(custom-set-variables
 '(savehist-file "~/.emacs.d/savehist")
 '(savehist-save-minibuffer-history t)
 '(savehist-additional-variables '(search-ring
                                   global-mark-ring
                                   ido-work-directory-list
                                   regexp-search-ring
                                   projectur-history))
 '(savehist-ignored-variables '(bmkp-tag-history
                                grep-history
                                bookmark-history
                                buffer-name-history
                                minibuffer-history
                                ido-buffer-history
                                ido-file-history
                                file-name-history)))

(defun get-rid-of-duplicates-in-savehist-variables ()
  (mapc
   (lambda (var)
     (when (boundp var)
       (setq var (delete-dups (symbol-value var)))))
   (append savehist-additional-variables
           savehist-minibuffer-history-variables)))

(savehist-mode t)
(add-hook 'savehist-save-hook 'get-rid-of-duplicates-in-savehist-variables)
(savehist-save)


;; Recentf
(custom-set-variables
 '(recentf-save-file "~/.emacs.d/recentf")
 '(recentf-max-saved-items 3000)
 '(recentf-exclude
   '("\\.\\(jp\\(e\\|g\\|eg\\)\\|gif\\|png\\|ico\\|x[pb]m\\|bmp\\|tiff?\\)\\'" ; images
     "\\.\\(zip\\|tar\\|rar\\|xpi\\|crx\\|oex\\)\\'" ; archives
     "\\.nfo\\'"
     "\\.cue\\'"
     "\\.sfv\\'"
     "\\.m3u\\'"
     "\\.url\\'"
     "\\.srt\\'"
     "^Thumbs\\.db\\'")))

(recentf-mode t)


;; desktop
(custom-set-variables
 '(desktop-path '("~/.emacs.d/"))
 '(desktop-load-locked-desktop t)
 '(desktop-save t)
 '(desktop-save-mode t)
 '(desktop-globals-to-save nil)      ; not needed, `savehist' does the thing
 '(desktop-files-not-to-save
   (concat
    "\\("
    "^/[^/:]*:"
    "\\|"
    "(ftp)$"
    "\\|"
    "\\.gpg\\'"
    "\\|"
    "/\\.emacs\\.d/recentf"
    "\\|"
    "/org-clock-save.el\\'"
    "\\|"
    "/bmk-bmenu-state.el\\'"
    "\\|"
    "/ido-history\\'"
    "\\|"
    "/newsrc-dribble\\'"
    "\\|"
    (expand-file-name "~/repos/")
    "\\|"
    (expand-file-name "~/org/")
    "\\)"))
 '(desktop-locals-to-save
   '(desktop-locals-to-save
     truncate-lines
     case-fold-search
     case-replace
     fill-column
     overwrite-mode
     change-log-default-name
     size-indication-mode
     buffer-file-coding-system
     indent-tabs-mode
     show-trailing-whitespace)))

(desktop-save-mode t)
(add-hook 'kill-emacs-hook 'desktop-save-in-desktop-dir)
