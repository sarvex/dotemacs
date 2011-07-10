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
(mouse-sel-mode -1)

;; disabled by default by now, but may be uncommented someday:
;; (column-number-mode -1)
;; (blink-cursor-mode -1)
;; (delete-selection-mode -1)
;; (show-paren-mode -1)
;; (size-indication-mode -1)


(autoload 'notifications-notify "notifications" nil nil) ; emacs-24+

(require 'ansi-color)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


(require 'eldoc)
(eldoc-add-command 'paredit-backward-delete
                   'paredit-close-round)


(setq calendar-date-style 'european
      calendar-week-start-day 1)


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
      epa-file-encrypt-to `(,my-email-address)
      epa-file-inhibit-auto-save t
      epa-file-select-keys nil
      epa-popup-info-window nil)
(epa-file-enable)


(setq cua-enable-cua-keys nil)
(eval-after-load 'cua-base
  '(dolist (k '([right] [left] [up] [down]))
    (define-key cua--rectangle-keymap k 'cua-rotate-rectangle)))


(setq display-time-world-list
      '(("America/Los_Angeles" "Los Angeles")
        ("America/Chicago" "Chicago")
        ("America/New_York" "New York")
        ("America/Sao_Paulo" "San Paulo")
        ("Europe/London" "London")
        ("Europe/Paris" "Paris")
        ("Europe/Kiev" "Kyiv")
        ("Europe/Moscow" "Moscow")
        ("Asia/Shanghai" "Shanghai")
        ("Asia/Tokyo" "Tokyo")))
(define-key global-map (kbd "<f1>") 'display-time-world)
