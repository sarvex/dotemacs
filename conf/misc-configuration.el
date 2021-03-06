;;; -*- lexical-binding: t -*-

(add-to-list 'custom-theme-load-path "~/.emacs.d/color-theme-quiet-light")
(load-theme 'quiet-light)

(require 'ansi-color)

(defadvice display-message-or-buffer (before ansi-color activate)
  "Process ANSI color codes in shell output."
  (let ((buf (ad-get-arg 0)))
    (and (bufferp buf)
         (string= (buffer-name buf) "*Shell Command Output*")
         (with-current-buffer buf
           (ansi-color-apply-on-region (point-min) (point-max))))))

(fset 'yes-or-no-p 'y-or-n-p)

(random t)

;; on
(auto-image-file-mode)
(column-number-mode)
(electric-indent-mode)
(epa-file-enable)
(global-auto-revert-mode)
(global-prettify-symbols-mode)
(global-subword-mode)
(icomplete-mode)
(minibuffer-electric-default-mode)
(winner-mode)

;; off
(menu-bar-mode -1)
(tool-bar-mode -1)
(mouse-wheel-mode -1)

;; app-arch/unrar-gpl in needed for rar support, executable must be named
;; "unrar-free" (hardcoded in archive-mode)
(add-to-list 'auto-mode-alist (cons (rx not-newline "." (or "xpi" "crx" "oex" "rar") string-end) 'archive-mode))
(add-to-list 'auto-mode-alist '("\\.gem\\'" . tar-mode))
(with-eval-after-load 'arc-mode
  (define-key archive-mode-map (kbd "q")
    (lambda () (interactive) (kill-buffer-ask (current-buffer))))
  (add-hook 'archive-mode-hook (lambda () (setq truncate-lines t))))
(with-eval-after-load 'tar-mode
  (define-key tar-mode-map (kbd "q")
    (lambda () (interactive) (kill-buffer-ask (current-buffer))))
  (add-hook 'tar-mode-hook (lambda () (setq truncate-lines t))))

(with-eval-after-load 'sql
  (add-hook 'sql-interactive-mode-hook (lambda () (setq truncate-lines t))))

(mapc
 (lambda (interpreter)
   (add-to-list 'interpreter-mode-alist (cons interpreter 'python-mode)))
 '("python" "python2" "python3" "jython"))

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

(with-eval-after-load 'image-mode
  (define-key image-mode-map (kbd "a") 'image-toggle-animation)
  (define-key image-mode-map (kbd "q")
    (lambda ()
      (interactive)
      (kill-buffer-ask (current-buffer)))))

(with-eval-after-load 'help-mode
  (define-key help-mode-map (kbd "M-p") 'help-go-back)
  (define-key help-mode-map (kbd "M-n") 'help-go-forward))

(with-eval-after-load 'cus-edit
  (define-key custom-mode-map (kbd ";") 'Custom-goto-parent))

(with-eval-after-load 'info
  (define-key Info-mode-map (kbd ";") 'Info-up))
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist (cons extension 'conf-mode)))
 '("\\.cue\\'" "\\.cnf\\'" "^hgrc\\'" "\\.gitignore\\'"))

(mapc
 (lambda (symbol) (put symbol 'disabled nil))
 '(
   dired-find-alternate-file
   downcase-region
   erase-buffer
   narrow-to-page
   narrow-to-region
   set-goal-column
   upcase-region
   ))

(mapc
 (lambda (buf-name)
   (add-to-list 'same-window-buffer-names buf-name))
 '("*Bookmark List*" "*SQL*" "*Packages*"))

(mapc
 (lambda (extension)
   (add-to-list 'completion-ignored-extensions extension))
 '(".rbc" ".sassc" ".scssc" ".sqlite3" ".hi"))

(custom-set-variables
 '(shell-file-name "/bin/zsh")
 '(explicit-shell-file-name "/bin/zsh")
 '(term-scroll-to-bottom-on-output nil)
 '(term-scroll-show-maximum-output nil)

 '(global-auto-revert-non-file-buffers t)
 '(auto-revert-verbose nil)

 '(apropos-do-all t)
 '(apropos-sort-by-scores t)
 '(apropos-documentation-sort-by-scores t)

 '(sentence-end-double-space nil)

 '(calendar-date-style 'european)
 '(calendar-week-start-day 1)
 '(calendar-latitude [49 32 north])
 '(calendar-longitude [25 37 east])

 '(Man-fontify-manpage-flag t)
 '(Man-notify-method 'pushy)

 '(kill-ring-max 200)
 '(kill-do-not-save-duplicates t)

 '(comint-input-ignoredups t)
 '(comint-move-point-for-output 'this)
 '(comint-scroll-show-maximum-output nil)
 '(comint-scroll-to-bottom-on-input 'this)

 '(whitespace-style '(face tabs trailing space-before-tab space-after-tab tab-mark))

 '(cua-enable-cua-keys nil)

 '(image-animate-loop t)

 '(epa-file-cache-passphrase-for-symmetric-encryption nil)
 '(epa-file-inhibit-auto-save t)
 '(epa-file-select-keys nil)
 '(epg-passphrase-coding-system 'utf-8)

 '(display-time-world-list
   '(("America/Los_Angeles" "Los Angeles")
     ("America/Denver" "Denver")
     ("America/Chicago" "Chicago")
     ("America/New_York" "New York")
     ("America/Sao_Paulo" "San Paulo")
     ("Europe/London" "London")
     ("Europe/Paris" "Paris")
     ("Europe/Kiev" "Kyiv")
     ("Europe/Moscow" "Moscow")
     ("Asia/Shanghai" "Shanghai")
     ("Asia/Tokyo" "Tokyo")))

 '(async-shell-command-buffer 'new-buffer)
 '(auto-mode-case-fold t)
 '(browse-url-browser-function 'browse-url-chromium)
 '(comment-column 42)
 '(create-lockfiles nil)
 '(custom-unlispify-remove-prefixes t)
 '(debug-on-error nil)
 '(delete-active-region t)
 '(echo-keystrokes 0.4)
 '(ediff-make-buffers-readonly-at-startup t)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(eval-expression-print-level nil)
 '(fill-column 78)
 '(font-lock-maximum-decoration t)
 '(font-lock-mode t)
 '(fortune-file "/usr/share/fortune/")
 '(fortune-program-options '("-a"))
 '(global-mark-ring-max 50)
 '(grep-command "grep --recursive --with-filename --line-number --regexp=")
 '(grep-scroll-output t)
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries 'left)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice (lambda () (list-bookmarks) (get-buffer "*Bookmark List*")))
 '(initial-scratch-message "")
 '(isearch-allow-scroll t)
 '(large-file-warning-threshold nil)
 '(load-prefer-newer t)
 '(mouse-drag-copy-region nil)
 '(mouse-highlight nil)
 '(next-line-add-newlines nil)
 '(nobreak-char-display nil)
 '(out-of-memory-warning-percentage nil)
 '(query-replace-highlight t)
 '(reb-re-syntax 'rx)
 '(require-final-newline t)
 '(search-highlight t)
 '(select-active-regions nil)
 '(show-trailing-whitespace nil)
 '(standard-indent 4)
 '(tab-always-indent 'complete)
 '(tab-width 4)
 '(temporary-file-directory "/tmp/")
 '(tramp-default-method "sudo")
 '(vc-follow-symlinks t)
 '(word-wrap t)
 '(x-select-enable-clipboard t)
 '(x-select-enable-primary t)
 '(x-stretch-cursor t)

 '(frame-title-format
   '("" (:eval (mapconcat
                (lambda (w)
                  (with-current-buffer (window-buffer w)
                    (if (buffer-file-name)
                        (abbreviate-file-name (buffer-file-name))
                      (buffer-name))))
                (window-list) " | "))))

 '(gnus-init-file "~/.emacs.d/dotemacs/conf/gnus-configuration")
 '(snake-score-file "~/.emacs.d/games/snake-scores")
 '(tetris-score-file "~/.emacs.d/games/tetris-scores")
 '(type-break-file-name "~/.emacs.d/type-break")
 '(mpc-mpd-music-directory "/mnt/storage/music/")

 '(scroll-step 0)
 '(redisplay-dont-pause t)
 '(scroll-conservatively most-positive-fixnum)
 '(scroll-margin 0)
 '(scroll-down-aggressively nil)
 '(scroll-up-aggressively nil)
 '(scroll-preserve-screen-position 'always)

 '(auto-save-default nil)
 '(backup-by-copying t)
 '(backup-directory-alist (list (cons ".*" temporary-file-directory)))
 '(auto-save-file-name-transforms (list (list ".*" temporary-file-directory t)))
 '(backup-inhibited nil)
 '(delete-old-versions t)
 '(kept-new-versions 100)
 '(kept-old-versions 5)
 '(version-control t)


 '(default-frame-alist '((font . "Consolas-12")))
 '(initial-frame-alist default-frame-alist)
 '(special-display-frame-alist default-frame-alist)

 '(face-font-selection-order '(:height :width :weight :slant))
 '(face-font-family-alternatives
   '(("Consolas" "Inconsolata" "Monaco" "Terminus" "Monospace" "courier" "fixed")
     ("courier" "CMU Typewriter Text" "fixed")
     ("Sans Serif" "helv" "helvetica" "arial" "fixed")
     ("helv" "helvetica" "arial" "fixed"))))
