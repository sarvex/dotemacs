(fset 'yes-or-no-p 'y-or-n-p)

(custom-set-variables
 '(inhibit-startup-screen t)
 '(initial-scratch-message ";; *scratch*\n\n")
 '(browse-url-browser-function 'browse-url-firefox)
 '(delete-active-region t)
 '(large-file-warning-threshold nil)
 '(auto-mode-case-fold t)
 '(vc-follow-symlinks t)
 '(next-line-add-newlines nil)
 '(require-final-newline t)
 '(mouse-highlight nil)
 '(mouse-drag-copy-region nil)
 '(x-select-enable-primary t)
 '(x-select-enable-clipboard t)
 '(select-active-regions nil)
 '(font-lock-maximum-decoration t)
 '(font-lock-mode t)
 '(search-highlight t)
 '(query-replace-highlight t)
 '(nobreak-char-display nil)
 '(comment-column 42)
 '(fill-column 78)
 '(show-trailing-whitespace nil)
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries 'left)
 '(indicate-empty-lines t)
 '(tab-width 4)
 '(word-wrap t)
 '(calc-window-height 18)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(ediff-make-buffers-readonly-at-startup t)
 '(grep-scroll-output t)
 '(grep-command "grep --recursive --with-filename --line-number --regexp="))

(custom-set-variables
 '(safe-local-variable-values
   '((dired-omit-mode . t)
     (eval progn (rainbow-mode 1) (hl-line-mode -1))))
 '(frame-title-format
   '("" (:eval (mapconcat
                (lambda (w) (buffer-name (window-buffer w)))
                (window-list) " | "))))
 '(tooltip-frame-parameters
   '((name . "tooltip")
     (internal-border-width . 1)
     (border-width . 1))))

(custom-set-variables
 '(gnus-init-file "~/.emacs.d/dotemacs/conf/gnus-configuration.el")
 '(custom-file "~/.emacs.d/custom.el")
 '(snake-score-file "~/.emacs.d/games/snake-scores")
 '(tetris-score-file "~/.emacs.d/games/tetris-scores")
 '(type-break-file-name "~/.emacs.d/type-break")
 '(mpc-mpd-music-directory "/mnt/storage/music/"))

(custom-set-variables
 '(scroll-step 0)
 '(redisplay-dont-pause t)
 '(scroll-conservatively most-positive-fixnum)
 '(scroll-margin 0)
 '(scroll-down-aggressively nil)
 '(scroll-up-aggressively nil)
 '(scroll-preserve-screen-position 'always))

(custom-set-variables
 '(backup-directory-alist '(("." . "~/.emacs.d/backup/")))
 '(backup-inhibited nil)
 '(backup-by-copying t)
 '(auto-save-default nil)
 '(version-control t)
 '(delete-old-versions t))

(custom-set-variables
 '(debug-on-error nil)
 '(echo-keystrokes 0.4)
 '(eval-expression-print-level nil)
 '(isearch-allow-scroll t)
 '(standard-indent 4)
 '(tab-always-indent 'complete)
 '(temporary-file-directory "/tmp/")
 '(tramp-default-method "sudo")
 '(global-mark-ring-max 50)
 '(x-stretch-cursor t))

(custom-set-variables
 '(default-frame-alist '((font . "Consolas-12")))
 '(initial-frame-alist default-frame-alist)
 '(special-display-frame-alist default-frame-alist))

(custom-set-variables
 '(user-mail-address my-email-address)
 '(user-full-name my-full-name))


(mapc
 (lambda (symbol)
   (put symbol 'disabled nil))
 '(upcase-region downcase-region narrow-to-region narrow-to-page set-goal-column))

(mapc
 (lambda (buf-name)
   (add-to-list 'same-window-buffer-names buf-name))
 '("*Bookmark List*" "*SQL*" "*Packages*"))

(mapc
 (lambda (extension)
   (add-to-list 'completion-ignored-extensions extension))
 '(".rbc" ".sassc" ".scssc" ".sqlite3" ".hi"))

(defadvice save-buffers-kill-emacs (before do-not-ask-when-has-live-clients activate)
  "Do not ask before exiting Emacs if it has live clients."
  (remove-hook 'kill-emacs-query-functions 'server-kill-emacs-query-function))
