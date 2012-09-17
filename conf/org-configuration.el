;; -*- eval: (rainbow-mode 1) -*-

(define-key global-map (kbd "C-x o") 'org-iswitchb)
(define-key global-map (kbd "<f11>") 'org-capture)
(define-key global-map (kbd "<f12>") 'org-agenda)

(setq org-show-notification-handler
      (lambda (notification)
        (notifications-notify
         :title "Org-mode"
         :body notification
         :app-icon "~/.icons/org-mode.png")))

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

(eval-after-load 'ob
  '(add-to-list 'org-babel-load-languages '(ruby . t)))

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
;; Paths:
(setq org-directory "~/org"
      my-org-agenda-directory (expand-file-name "agenda" org-directory)
      my-org-capture-templates-directory "~/.emacs.d/dotemacs/misc/org-capture-templates"
      org-default-notes-file (expand-file-name "refile.org" my-org-agenda-directory)
      my-org-contacts-file (expand-file-name "contacts.org" my-org-agenda-directory)
      org-archive-location (concat org-directory "/archive/archive_%s::")
      org-agenda-files `(,(file-name-as-directory my-org-agenda-directory))
      org-contacts-files `(,my-org-contacts-file))

(setq org-agenda-window-setup 'current-window
      org-agenda-restore-windows-after-quit t)

(setq org-agenda-tags-column -90)


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
   ("c" "contacts" entry
        (file ,my-org-contacts-file)
        (file ,(expand-file-name "contacts" my-org-capture-templates-directory)))
   ("u" "current" entry
        (file ,(expand-file-name "current.org" my-org-agenda-directory))
        (file ,(expand-file-name "current" my-org-capture-templates-directory)))))

(eval-after-load 'org-capture
  '(progn
    (require 'org-contacts)
    ;; C-c C-c is overriden
    (define-key org-capture-mode-map (kbd "C-c t") 'org-set-tags)
    (add-hook 'org-capture-before-finalize-hook 'org-align-all-tags)))

;; Refile setup:
(setq org-refile-targets
      '((org-agenda-files :maxlevel . 5)
        (nil :maxlevel . 5)))

(setq org-refile-use-outline-path 'file
      org-refile-allow-creating-parent-nodes 'confirm)


(defun vderyagin/org-update-agenda-view ()
  "Update all org agenda buffers (if any)."
  (save-window-excursion
    (mapc
     (lambda (buf)
       (with-current-buffer buf
         (org-agenda-redo t)))
     (get-buffers-with-major-mode 'org-agenda-mode))))

(defun my-org-hook ()
  (org-indent-mode t)
  (turn-on-auto-fill)
  (turn-on-visual-line-mode)
  (set (make-local-variable 'backup-inhibited) t)
  (add-hook 'before-save-hook 'org-align-all-tags nil 'make-it-local)
  (add-hook 'after-save-hook 'vderyagin/org-update-agenda-view nil 'make-it-local))

(eval-after-load 'org
  '(progn
    (require 'org-install)

    (add-hook 'org-mode-hook 'my-org-hook)

    (org-clock-persistence-insinuate)

    (define-key org-mode-map (kbd "M-n") 'org-next-link)
    (define-key org-mode-map (kbd "M-p") 'org-previous-link)

    ;; disable keys for adding/removing files from agenda:
    (define-key org-mode-map (kbd "C-c [") nil)
    (define-key org-mode-map (kbd "C-c ]") nil)

    ;; resolving conflicts with global bindings
    (define-key org-mode-map (kbd "S-C-<left>") nil)
    (define-key org-mode-map (kbd "S-C-<right>") nil)
    (define-key org-mode-map (kbd "C-<tab>") nil)))

(defun vderyagin/remove-empty-drawer-on-clock-out ()
  "Delete clocking drawer if it is empty."
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(eval-after-load 'org-clock
  '(add-hook 'org-clock-out-hook 'vderyagin/remove-empty-drawer-on-clock-out 'append))

(defun vderyagin/org-agenda-activate-appt ()
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
           :app-icon "~/.icons/org-mode.png")))

  (org-agenda-to-appt t '((headline "IMPORTANT") (category "Appt")))
  (appt-activate t))

(eval-after-load 'org-agenda
  '(progn
    (require 'org-contacts)

    (add-hook 'org-agenda-mode-hook 'vderyagin/org-agenda-activate-appt)

    (define-key org-agenda-mode-map (kbd "C-S-<left>") nil)
    (define-key org-agenda-mode-map (kbd "C-S-<right>") nil)

    (define-key org-agenda-mode-map (kbd "M-n") 'org-next-link)
    (define-key org-agenda-mode-map (kbd "M-p") 'org-previous-link)))
