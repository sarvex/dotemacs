(fset 'yes-or-no-p 'y-or-n-p)


;; on
(auto-image-file-mode t)
(minibuffer-electric-default-mode t)
(random t)
(winner-mode t)                       ; window configuration history

;; enabled by default by now:
;; (auto-compression-mode t)
;; (transient-mark-mode t)
;; (global-font-lock-mode t)

;; off
(menu-bar-mode -1)
(tool-bar-mode -1)
(mouse-wheel-mode -1)

;; disabled by default by now, but may be uncommented someday:
;; (column-number-mode -1)
;; (blink-cursor-mode -1)
;; (delete-selection-mode -1)
;; (show-paren-mode -1)
;; (size-indication-mode -1)



(dolist (symb '(upcase-region
                downcase-region
                narrow-to-region
                narrow-to-page))
  (put symb 'disabled nil))


;; IMPORTANT: app-arch/unrar-gpl in needed for rar support
;; executable must be named unrar-free (hardcoded in archive-mode)
(dolist (ext '("\\.xpi\\'" "\\.crx\\'" "\\.oex\\'" "\\.rar\\'"))
  (add-to-list 'auto-mode-alist `(,ext . archive-mode)))

(dolist (ext '("\\.cue\\'" "\\.cnf\\'" "^hgrc\\'"))
  (add-to-list 'auto-mode-alist `(,ext . conf-mode)))

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

(add-to-list 'auto-mode-alist '("\\.nfo\\'" .
                                (lambda ()
                                  (text-mode)
                                  (visual-line-mode t))))


(dolist (buf-name '("*Bookmark List*"
                    "*SQL*"
                    "*Packages*"))
  (add-to-list 'same-window-buffer-names buf-name))


(dolist (ext '(".rbc"))
  (add-to-list 'completion-ignored-extensions ext))


(setq gnus-init-file "~/.emacs.d/lisp/my-rc/my-gnus-rc.el"
      snake-score-file "~/.emacs.d/games/snake-scores"
      tetris-score-file "~/.emacs.d/games/tetris-scores"
      ;; mpc-mpd-music-directory "/mnt/storage/music/"
      wget-download-directory "~/temp/")


(setq large-file-warning-threshold nil
      auto-mode-case-fold t
      safe-local-variable-values '((dired-omit-mode . t)
                                   (dired-listing-switches . "-LhAFl --group-directories-first")
                                   (encoding . utf-8)))


;; startup
(setq initial-buffer-choice t
      inhibit-startup-screen t
      initial-scratch-message ";; *scratch*\n\n")


(setq ansi-term-color-vector [unspecified "#333333" "#7f1515" "#509f50" "#aeae00" "#2e5aa7" "#7a3e9d" "#5eadd1" "#999999"]
      ansi-color-names-vector ["#333333" "#7f1515" "#509f50" "#aeae00" "#2e5aa7" "#7a3e9d" "#5eadd1" "#999999"])

(setq next-line-add-newlines nil
      require-final-newline t)


(setq mouse-drag-copy-region t
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
(setq mouse-wheel-progressive-speed nil ;; don’t accelerate scrolling
      mouse-wheel-follow-mouse t        ;; scroll window under mouse
      scroll-step 0
      redisplay-dont-pause t
      scroll-conservatively most-positive-fixnum
      scroll-margin 0
      scroll-down-aggressively nil
      scroll-up-aggressively nil
      scroll-preserve-screen-position 'always)


(setq backup-directory-alist '(("." . "~/.emacs.d/backup/"))
      tramp-backup-directory-alist '(("." . "/home/vderyagin/.emacs.d/backup/tramp/"))
      backup-by-copying t
      auto-save-list-file-name "~/.emacs.d/saves"
      auto-save-default nil
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2)


(setq font-lock-maximum-decoration t
      frame-background-mode 'light
      search-highlight t
      query-replace-highlight t
      nobreak-char-display nil)


(setq shell-file-name "/bin/zsh"
      explicit-shell-file-name "/bin/zsh"
      term-scroll-to-bottom-on-output nil
      term-scroll-show-maximum-output nil
      term-default-bg-color "#e5e5e5"
      term-default-fg-color "#333333")


;; misc stuff
(setq debug-on-error nil
      diff-switches "-uc"
      echo-keystrokes 0.4
      history-length 15
      stack-trace-on-error nil
      standard-indent 4
      tab-always-indent 'complete
      grep-scroll-output t
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
