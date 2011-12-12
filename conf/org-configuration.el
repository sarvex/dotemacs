(require 'org-install)

(setq org-modules
      '(org-crypt org-docview org-gnus
        org-info org-jsinfo org-irc org-w3m))

(when (fboundp 'notifications-notify)
  (setq org-show-notification-handler
        (lambda (notification)
          (notifications-notify
           :title "Org-mode"
           :body notification
           :app-icon "~/.emacs.d/icons/org-mode-big.png"))))

(setq org-completion-use-ido t
      org-outline-path-complete-in-steps nil
      org-return-follows-link t
      org-special-ctrl-a/e t
      org-special-ctrl-k t
      org-cycle-separator-lines -1
      org-startup-truncated nil
      org-src-fontify-natively t
      org-tags-column -85
      org-log-done 'time
      org-log-into-drawer t
      org-use-fast-todo-selection t
      org-treat-S-cursor-todo-selection-as-state-change nil
      org-yank-adjusted-subtrees t
      org-drawers '("PROPERTIES" "CLOCK" "LOGBOOK" "HIDDEN"))

;;
;; TODO keywords
;;
(setq
 org-todo-keywords
 '((sequence "TODO(t)" "WAITING(w)" "STARTED(s)" "PAUSED(p)" "|" "DONE(d)" "CANCELLED(c)"))
 org-todo-keyword-faces
 '(("TODO" .      (:foreground "#df3800" :weight bold))
   ("WAITING" .   (:foreground "#566ea2" :weight bold))
   ("STARTED" .   (:foreground "#4d9694" :weight bold))
   ("PAUSED" .    (:foreground "#888888" :weight bold))
   ("CANCELLED" . (:foreground "#e00051" :weight bold))
   ("DONE" .      (:foreground "#448c27" :weight bold))))

;;
;; paths
;;
(setq
 org-directory "~/org"
 my-org-agenda-directory (expand-file-name "agenda" org-directory)
 my-org-capture-templates-directory "~/.emacs.d/dotemacs/misc/org-capture-templates"
 org-default-notes-file (expand-file-name "refile.org" my-org-agenda-directory)
 my-org-contacts-file (expand-file-name "contacts.org" my-org-agenda-directory)
 org-archive-location (concat org-directory "/archive/archive_%s::")
 org-agenda-files `(,(file-name-as-directory my-org-agenda-directory))
 org-contacts-files `(,my-org-contacts-file))

(setq org-agenda-window-setup 'reorganize-frame
      org-agenda-restore-windows-after-quit t)

(setq org-agenda-tags-column -90)

;; agenda category icons
(setq
 my-org-agenda-icons-directory "~/.emacs.d/icons"
 org-agenda-category-icon-alist
 ;; 18px high icons
 `(("Emacs" ,(expand-file-name "emacs.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("Org" ,(expand-file-name "org-mode.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("Ruby" ,(expand-file-name "ruby3.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("Perl" ,(expand-file-name "perl.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("Python" ,(expand-file-name "python.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("Lua" ,(expand-file-name "lua.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("Haskell" ,(expand-file-name "haskell.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("Gnus" ,(expand-file-name "gnus.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("Home" ,(expand-file-name "home.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("\\(Read\\|Book\\)" ,(expand-file-name "book.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("\\(Movie\\|Video\\)" ,(expand-file-name "video.png" my-org-agenda-icons-directory) nil nil :ascent center)
   ("" ,(expand-file-name "blank.png" my-org-agenda-icons-directory) nil nil :ascent center)))

;;
;; org-clock
;;
(setq org-clock-auto-clock-resolution 'when-no-clock-is-running
      org-clock-clocktable-default-properties '(:maxlevel 3 :scope file)
      org-clock-history-length 28
      org-clock-in-resume t
      org-clock-in-switch-to-state "STARTED"
      org-clock-out-remove-zero-time-clocks t
      org-clock-out-switch-to-state "PAUSED"
      org-clock-out-when-done t
      org-clock-persist 'history
      org-clock-report-include-clocking-task t)

(org-clock-persistence-insinuate)

;;================================================================
;; org-capture
;;
(setq
 org-capture-templates
 `(("n" "note" entry
        (file ,org-default-notes-file)
        (file ,(expand-file-name "note" my-org-capture-templates-directory)))
   ("l" "link" entry
        (file ,org-default-notes-file)
        (file ,(expand-file-name "link" my-org-capture-templates-directory)))
   ("t" "todo" entry
        (file ,org-default-notes-file)
        (file ,(expand-file-name "todo" my-org-capture-templates-directory)))
   ("C" "contacts" entry
        (file ,my-org-contacts-file)
        (file ,(expand-file-name "contacts" my-org-capture-templates-directory)))
   ("c" "current" entry
        (file ,(expand-file-name "current.org" my-org-agenda-directory))
        (file ,(expand-file-name "current" my-org-capture-templates-directory)))))

(defun my-org-capture-before-finalize-hook ()
  (org-align-all-tags))

(eval-after-load 'org-capture
  '(progn
    ;; C-c C-c is overriden
    (define-key org-capture-mode-map (kbd "C-c t") 'org-set-tags)
    (add-hook 'org-capture-before-finalize-hook 'my-org-capture-before-finalize-hook)))

;;================================================================
;; refile setup
;;
(setq org-refile-targets
      '((org-agenda-files :maxlevel . 5)
        (nil :maxlevel . 5)))

(setq org-refile-use-outline-path 'file
      org-refile-allow-creating-parent-nodes 'confirm)


(defun my-org-after-save-hook ()
  (when (eq major-mode 'org-mode) ; discard non-org files immediately
    (let* ((f (buffer-file-name))
           (d (file-name-directory f))
           (fn (file-name-nondirectory f))
           (r org-agenda-file-regexp)
           (c (expand-file-name "misc/clocktable.org"
                                org-directory)))
      (when (or (member f org-agenda-files)
                (and (member d org-agenda-files)
                     (string-match r fn)))
        (with-current-buffer (find-file-noselect c)
          (org-clock-report t)
          (save-buffer))))))

(add-hook 'after-save-hook 'my-org-after-save-hook)

;; aligning all tags on save
(defun my-org-before-save-hook ()
  (when (eq major-mode 'org-mode)
    (org-align-all-tags)))

(add-hook 'before-save-hook 'my-org-before-save-hook)

;; mode hook
(defun my-org-hook ()
  (org-indent-mode t)
  (turn-on-auto-fill)
  ;; (flyspell-mode t)
  (turn-on-visual-line-mode))

(add-hook 'org-mode-hook 'my-org-hook)

;; get rid of clocking drawer if empty
(defun my-remove-empty-drawer-on-clock-out ()
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'my-remove-empty-drawer-on-clock-out 'append)

;;================================================================
;; Keys
;;
(define-key global-map (kbd "C-x o") 'org-iswitchb)
(define-key global-map (kbd "<f11>") 'org-capture)
(define-key global-map (kbd "<f12>") 'org-agenda)

(define-key org-mode-map (kbd "M-n") 'org-next-link)
(define-key org-mode-map (kbd "M-p") 'org-previous-link)



;; resolving conflicts with global bindings
(define-key org-mode-map (kbd "S-C-<left>") nil)
(define-key org-mode-map (kbd "S-C-<right>") nil)
(define-key org-mode-map (kbd "C-<tab>") nil)


;;
;; appt
;;
(setq appt-audible nil
      appt-message-warning-time 15
      appt-display-format 'window
      appt-display-diary nil
      appt-display-interval 3)

(setq appt-disp-window-function
      (lambda (left time message)
        (notifications-notify
         :title (format "%s minute(s) left" left)
         :body message
         :app-icon "~/.emacs.d/icons/org-mode-big.png")))

(defun my-org-agenda-mode-hook ()
  (org-agenda-to-appt t '((headline "IMPORTANT") (category "Appt")))
  (appt-activate t))

(eval-after-load 'org-agenda
  '(progn
    (add-hook 'org-agenda-mode-hook 'my-org-agenda-mode-hook)

    (define-key org-agenda-mode-map (kbd "C-S-<left>") nil)
    (define-key org-agenda-mode-map (kbd "C-S-<right>") nil)

    (define-key org-agenda-mode-map (kbd "M-n") 'org-agenda-next-date-line)
    (define-key org-agenda-mode-map (kbd "M-p") 'org-agenda-previous-date-line)))

(require 'org-contacts nil 'noerror)
