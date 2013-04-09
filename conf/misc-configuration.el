;;; -*- lexical-binding: t -*-

(require 'uniquify)
(require 'ansi-color)

(fset 'yes-or-no-p 'y-or-n-p)

(random t)

;; on
(auto-image-file-mode)
(column-number-mode)
(epa-file-enable)
(global-auto-revert-mode)
(global-subword-mode)
(icomplete-mode)
(minibuffer-electric-default-mode)
(winner-mode)

;; off
(menu-bar-mode -1)
(tool-bar-mode -1)
(mouse-wheel-mode -1)


(eval-after-load 'cua-base
  '(mapc
    (lambda (key)
      (define-key cua--rectangle-keymap key 'cua-rotate-rectangle))
    '([right] [left] [up] [down])))

;; app-arch/unrar-gpl in needed for rar support, executable must be named
;; "unrar-free" (hardcoded in archive-mode)
(add-to-list 'auto-mode-alist (cons (rx not-newline "." (or "xpi" "crx" "oex" "rar") string-end) 'archive-mode))
(add-to-list 'auto-mode-alist '("\\.gem\\'" . tar-mode))
(eval-after-load 'arc-mode
  '(progn
    (define-key archive-mode-map (kbd "q")
     (lambda () (interactive) (kill-buffer-ask (current-buffer))))
    (add-hook 'archive-mode-hook (lambda () (setq truncate-lines t)))))
(eval-after-load 'tar-mode
  '(progn
    (define-key tar-mode-map (kbd "q")
     (lambda () (interactive) (kill-buffer-ask (current-buffer))))
    (add-hook 'tar-mode-hook (lambda () (setq truncate-lines t)))))

(mapc
 (lambda (interpreter)
   (add-to-list 'interpreter-mode-alist (cons interpreter 'python-mode)))
 '("python" "python2" "python3" "jython"))

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

(eval-after-load 'image-mode
  '(progn
    (define-key image-mode-map (kbd "a") 'image-toggle-animation)
    (define-key image-mode-map (kbd "q")
     (lambda ()
       (interactive)
       (kill-buffer-ask (current-buffer))))))

(add-hook 'compilation-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'compilation-filter-hook
          (defun colorize-compilation-buffer ()
            (let ((inhibit-read-only t))
              (ansi-color-apply-on-region (point-min) (point-max)))))

(eval-after-load 'compile
  '(progn
    (define-key compilation-mode-map (kbd "f") 'ffap)
    (define-key compilation-mode-map (kbd "<f9>") 'recompile)))

(eval-after-load 'help-mode
  '(progn
    (define-key help-mode-map (kbd "M-p") 'help-go-back)
    (define-key help-mode-map (kbd "M-n") 'help-go-forward)))

(eval-after-load 'info
  '(define-key Info-mode-map (kbd ";") 'Info-up))
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist (cons extension 'conf-mode)))
 '("\\.cue\\'" "\\.cnf\\'" "^hgrc\\'" "\\.gitignore\\'"))

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
 '(uniquify-buffer-name-style 'forward)

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

 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error nil)
 '(compilation-disable-input t)
 '(compilation-read-command nil)
 '(compilation-window-height 20)
 '(compilation-scroll-output 'first-error)


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
 '(reb-re-syntax 'rx)
 '(async-shell-command-buffer 'new-buffer)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(ediff-make-buffers-readonly-at-startup t)
 '(grep-scroll-output t)
 '(grep-command "grep --recursive --with-filename --line-number --regexp=")

 '(safe-local-variable-values
   '((dired-omit-mode . t)
     (whitespace-line-column . 80)
     (whitespace-style face trailing lines-tail)
     (require-final-newline . t)))

 '(frame-title-format
   '("" (:eval (mapconcat
                (lambda (w)
                  (with-current-buffer (window-buffer w)
                    (if (buffer-file-name)
                        (abbreviate-file-name (buffer-file-name))
                        (buffer-name))))
                (window-list) " | "))))

 '(gnus-init-file "~/.emacs.d/dotemacs/conf/gnus-configuration")
 '(custom-file "~/.emacs.d/custom.el")
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

 '(backup-directory-alist '(("." . "~/.emacs.d/backup/")))
 '(backup-inhibited nil)
 '(backup-by-copying t)
 '(auto-save-default nil)
 '(version-control t)
 '(delete-old-versions t)

 '(debug-on-error nil)
 '(echo-keystrokes 0.4)
 '(eval-expression-print-level nil)
 '(isearch-allow-scroll t)
 '(standard-indent 4)
 '(tab-always-indent 'complete)
 '(temporary-file-directory "/tmp/")
 '(tramp-default-method "sudo")
 '(global-mark-ring-max 50)
 '(x-stretch-cursor t)

 '(default-frame-alist '((font . "Consolas-12")))
 '(initial-frame-alist default-frame-alist)
 '(special-display-frame-alist default-frame-alist)

 '(face-font-selection-order '(:height :width :weight :slant))
 '(face-font-family-alternatives
   '(("Consolas" "Inconsolata" "Monaco" "Terminus" "Monospace" "courier" "fixed")
     ("courier" "CMU Typewriter Text" "fixed")
     ("Sans Serif" "helv" "helvetica" "arial" "fixed")
     ("helv" "helvetica" "arial" "fixed"))))
