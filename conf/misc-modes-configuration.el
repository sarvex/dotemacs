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


(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


(eval-after-load 'eldoc
  '(eldoc-add-command
    'paredit-backward-delete
    'paredit-close-round))


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
      epa-file-encrypt-to `(,my-email-address)
      epa-file-inhibit-auto-save t
      epa-file-select-keys nil
      epg-passphrase-coding-system 'utf-8
      epa-popup-info-window nil)
(unless (memq epa-file-handler file-name-handler-alist)
  (epa-file-enable))


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
(eval-after-load 'time
  '(define-key display-time-world-mode-map (kbd "<f1>") 'kill-this-buffer))


;; IMPORTANT: app-arch/unrar-gpl in needed for rar support
;; executable must be named unrar-free (hardcoded in archive-mode)
(dolist (ext '("\\.xpi\\'" "\\.crx\\'" "\\.oex\\'" "\\.rar\\'"))
  (add-to-list 'auto-mode-alist `(,ext . archive-mode)))
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


(dolist (ext '("\\.cue\\'" "\\.cnf\\'" "^hgrc\\'"))
  (add-to-list 'auto-mode-alist `(,ext . conf-mode)))


(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))


(eval-after-load 'image-mode
  '(define-key image-mode-map (kbd "q")
    (lambda () (interactive) (kill-buffer-ask (current-buffer)))))


(eval-after-load 'conf-mode
  ;; conflicts with project-root
  '(define-key conf-mode-map (kbd "C-c SPC") nil))


(eval-after-load 'sh-script
  '(progn
    (define-key sh-mode-map (kbd "<f9>") 'executable-interpret)
    (define-key sh-mode-map (kbd "M-l") 'downcase-word)))



(eval-after-load 'make-mode
  '(dolist (mode-map '(makefile-automake-mode-map
                       makefile-bsdmake-mode-map
                       makefile-gmake-mode-map
                       makefile-imake-mode-map
                       makefile-makepp-mode-map))
    define-key mode-map (kbd "<f9>") 'recompile))


(setq shell-file-name "/bin/zsh"
      explicit-shell-file-name "/bin/zsh"
      term-scroll-to-bottom-on-output nil
      term-scroll-show-maximum-output nil)
