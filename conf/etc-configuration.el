(fset 'yes-or-no-p 'y-or-n-p)


(setq browse-url-browser-function
      (lambda (url &rest args)
        (interactive "sURL: ")
        (let ((browser (ido-completing-read
                        (format "Browse %s with: " url)
                        '("chromium" "firefox" "emacs-w3m"))))
          (cond
            ((equal browser "chromium")
             (require 'anything)
             (browse-url-chromium url))
            ((equal browser "firefox")
             (browse-url-firefox url))
            ((equal browser "emacs-w3m")
             (w3m-browse-url url))))))


(dolist (symb '(upcase-region
                downcase-region
                narrow-to-region
                narrow-to-page))
  (put symb 'disabled nil))


(dolist (buf-name '("*Bookmark List*"
                    "*SQL*"
                    "*Packages*"))
  (add-to-list 'same-window-buffer-names buf-name))


(dolist (ext '(".rbc"))
  (add-to-list 'completion-ignored-extensions ext))


(setq gnus-init-file "~/.emacs.d/dotemacs/conf/gnus-configuration.el"
      custom-file "~/.emacs.d/custom.el"
      snake-score-file "~/.emacs.d/games/snake-scores"
      tetris-score-file "~/.emacs.d/games/tetris-scores"
      type-break-file-name "~/.emacs.d/type-break"
      ;; mpc-mpd-music-directory "/mnt/storage/music/"
      wget-download-directory "~/temp/")


(setq large-file-warning-threshold nil
      auto-mode-case-fold t
      safe-local-variable-values '((dired-omit-mode . t)
                                   (dired-listing-switches . "-LhAFl --group-directories-first")
                                   (encoding . utf-8)))


;; startup
(setq inhibit-startup-screen t
      initial-scratch-message ";; *scratch*\n\n")


(setq next-line-add-newlines nil
      require-final-newline t)


(setq mouse-highlight nil
      mouse-drag-copy-region nil
      x-select-enable-primary t
      x-select-enable-clipboard t
      select-active-regions nil)


(setq frame-title-format
      '("" (:eval (mapconcat
                   (lambda (w) (buffer-name (window-buffer w)))
                   (window-list) " | "))))


(setq tooltip-frame-parameters '((name . "tooltip")
                                 (internal-border-width . 1)
                                 (border-width . 1)))

;; scroll one line at a time (less "jumpy" than defaults)
(setq scroll-step 0
      redisplay-dont-pause t
      scroll-conservatively most-positive-fixnum
      scroll-margin 0
      scroll-down-aggressively nil
      scroll-up-aggressively nil
      scroll-preserve-screen-position 'always)


(setq backup-directory-alist '(("." . "~/.emacs.d/backup/"))
      tramp-backup-directory-alist '(("." . "/home/vderyagin/.emacs.d/backup/tramp/"))
      backup-inhibited nil
      backup-by-copying t
      auto-save-list-file-name "~/.emacs.d/saves"
      auto-save-default nil
      version-control t
      delete-old-versions t)


(setq font-lock-maximum-decoration t
      search-highlight t
      query-replace-highlight t
      nobreak-char-display nil)


;; misc stuff
(setq debug-on-error nil
      diff-switches "-uc"
      echo-keystrokes 0.4
      grep-scroll-output t
      isearch-allow-scroll t
      stack-trace-on-error nil
      standard-indent 4
      tab-always-indent 'complete
      tramp-default-method "su"
      x-stretch-cursor t)

(setq-default comment-column 42
              fill-column 78
              indent-tabs-mode nil
              indicate-buffer-boundaries 'left
              indicate-empty-lines t
              tab-width 4
              word-wrap t)

(add-to-list 'default-frame-alist '(font . "Consolas-12"))
(setq initial-frame-alist default-frame-alist
      special-display-frame-alist default-frame-alist)


(setq user-mail-address my-email-address
      user-full-name my-full-name)
