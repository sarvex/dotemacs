;; on
(global-subword-mode t)
(auto-image-file-mode t)
(column-number-mode t)
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


(autoload 'notifications-notify "notifications" nil nil) ; emacs-24+


(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


(eval-after-load 'eldoc
  '(eldoc-add-command
    'paredit-backward-delete
    'paredit-close-round))


(setq calendar-date-style 'european
      calendar-week-start-day 1
      calendar-latitude 49.55
      calendar-longitude 25.58)


(setq Man-fontify-manpage-flag t
      Man-overstrike-face 'bold
      Man-width 67)


(setq thumbs-conversion-program "convert"
      thumbs-geometry "196x196"
      thumbs-margin 3
      thumbs-relief 0)


(setq comint-input-ignoredups t
      comint-move-point-for-output 'this
      comint-prompt-read-only nil
      comint-scroll-show-maximum-output nil
      comint-scroll-to-bottom-on-input 'this)
(eval-after-load 'comint
  '(define-key comint-mode-map (kbd "C-l") 'recenter-top))

(setq whitespace-style
      '(face
        tabs
        trailing
        space-before-tab
        space-after-tab
        tab-mark))
(define-key global-map (kbd "C-c w") 'whitespace-mode)


(setq epa-armor t
      epa-file-cache-passphrase-for-symmetric-encryption nil
      epa-file-encrypt-to my-email-address
      epa-file-inhibit-auto-save t
      epa-file-select-keys nil
      epg-passphrase-coding-system 'utf-8
      epa-popup-info-window nil)
(unless (memq epa-file-handler file-name-handler-alist)
  (epa-file-enable))


(setq cua-enable-cua-keys nil)
(eval-after-load 'cua-base
  '(mapc
    (lambda (key)
      (define-key cua--rectangle-keymap key 'cua-rotate-rectangle))
    '([right] [left] [up] [down])))


(setq display-time-world-list
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


;; IMPORTANT: app-arch/unrar-gpl in needed for rar support
;; executable must be named unrar-free (hardcoded in archive-mode)
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist (cons extension 'archive-mode)))
 '("\\.xpi\\'" "\\.crx\\'" "\\.oex\\'" "\\.rar\\'"))
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
 (lambda (extension)
   (add-to-list 'auto-mode-alist `(,extension . conf-mode)))
 '("\\.cue\\'" "\\.cnf\\'" "^hgrc\\'" "\\.gitignore\\'"))


(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))


(setq image-animate-loop t)
(eval-after-load 'image-mode
  '(progn
    (define-key image-mode-map (kbd "a") 'image-toggle-animation)
    (define-key image-mode-map (kbd "q")
     (lambda ()
       (interactive)
       (kill-buffer-ask (current-buffer))))))


(add-to-list 'auto-mode-alist '("\\.zsh" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh-theme" . sh-mode))
(eval-after-load 'sh-script
  '(define-key sh-mode-map (kbd "M-l") nil))


(setq compilation-ask-about-save nil
      compilation-auto-jump-to-first-error nil
      compilation-disable-input t
      compilation-window-height 20
      compilation-scroll-output 'first-error)

(add-hook 'compilation-mode-hook (lambda () (setq truncate-lines t)))
(require 'ansi-color)
(add-hook 'compilation-filter-hook
          (defun colorize-compilation-buffer ()
            (let ((inhibit-read-only t))
              (ansi-color-apply-on-region (point-min) (point-max)))))
(eval-after-load 'compile
  '(define-key compilation-mode-map (kbd "f") 'ffap))

(setq shell-file-name "/bin/zsh"
      explicit-shell-file-name "/bin/zsh"
      term-scroll-to-bottom-on-output nil
      term-scroll-show-maximum-output nil)

(setq apropos-do-all t
      apropos-label-face '(default)
      apropos-property-face 'bold)

(setq minibuffer-prompt-properties
      '(read-only t
        point-entered minibuffer-avoid-prompt
        face minibuffer-prompt))

(eval-after-load 'debug
  '(add-hook 'debugger-mode-hook (lambda () (setq truncate-lines nil))))

(eval-after-load 'help-mode
  '(progn
    (define-key help-mode-map (kbd "r")
     (lambda ()
       "Rename buffer so that another *Help* buffer does not replace it."
       (interactive)
       (let ((symbol (save-excursion
                       (goto-char (point-min))
                       (thing-at-point 'symbol))))
         (rename-buffer (format "*Help for `%s'*" symbol)))))
    (define-key help-mode-map (kbd "M-p") 'help-go-back)
    (define-key help-mode-map (kbd "M-n") 'help-go-forward)))
