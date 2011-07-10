(require 'ansi-color)

(autoload 'notifications-notify "notifications" nil nil) ; emacs-24+

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
