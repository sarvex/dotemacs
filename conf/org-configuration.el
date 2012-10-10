;; -*- eval: (progn (rainbow-mode 1) (hl-line-mode -1)) -*-

(defvar vderyagin/org-agenda-directory)
(defvar vderyagin/org-contacts-file)

(custom-set-variables
 '(org-show-notification-handler
   (lambda (notification)
     (notifications-notify
      :title "Org-mode"
      :body notification
      :app-icon (expand-file-name "~/.icons/org-mode.png"))))

 '(org-crypt-key "279C2900")
 '(org-crypt-disable-auto-save t)

 '(org-catch-invisible-edits 'error)
 '(org-completion-use-ido t)
 '(org-cycle-level-faces nil)
 '(org-cycle-separator-lines -2)
 '(org-habit-graph-column 62)
 '(org-drawers '("PROPERTIES" "CLOCK" "LOGBOOK" "HIDDEN"))
 '(org-enforce-todo-dependencies t)
 '(org-log-done 'time)
 '(org-log-into-drawer t)
 '(org-outline-path-complete-in-steps nil)
 '(org-return-follows-link t)
 '(org-special-ctrl-a/e 'reversed)
 '(org-special-ctrl-k t)
 '(org-src-fontify-natively t)
 '(org-startup-indented t)
 '(org-startup-truncated nil)
 '(org-tags-column -77)
 '(org-tags-exclude-from-inheritance '("crypt"))
 '(org-treat-S-cursor-todo-selection-as-state-change nil)
 '(org-use-fast-todo-selection t)
 '(org-yank-adjusted-subtrees t)

 ;; paths:
 '(org-directory (expand-file-name "~/org") 'now)
 '(vderyagin/org-agenda-directory (expand-file-name "agenda" org-directory) 'now)
 '(vderyagin/org-contacts-file (expand-file-name "contacts.org" vderyagin/org-agenda-directory) 'now)
 '(org-default-notes-file (expand-file-name "refile.org" vderyagin/org-agenda-directory))
 '(org-archive-location (expand-file-name  "archive/archive_%s::" org-directory))
 '(org-contacts-files (list vderyagin/org-contacts-file))
 '(org-agenda-files (list vderyagin/org-agenda-directory
                     (expand-file-name "projects" vderyagin/org-agenda-directory)))

 '(org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
 '(org-todo-keyword-faces
   '(("TODO" .      (:foreground "#df3800" :weight bold))
     ("NEXT" .      (:foreground "#566ea2" :weight bold))
     ("HOLD" .      (:foreground "#b68800" :weight bold))
     ("WAITING" .   (:foreground "#4d9694" :weight bold))
     ("CANCELLED" . (:foreground "#e00051" :weight bold))
     ("DONE" .      (:foreground "#448c27" :weight bold))))

 '(org-capture-templates
   `(("n" "note" entry
      (file "")
      "* %? :NOTE:\n:PROPERTIES:\n:Captured_at: %U\n:END:"
      :clock-resume t)
     ("l" "link" entry
      (file "")
      "* %^L\n:PROPERTIES:\n:Captured_at: %U\n:END:"
      :clock-resume t)
     ("t" "todo" entry
      (file "")
      "* TODO %?\nSCHEDULED: %t\n:PROPERTIES:\n:Captured_at: %U\n:END:"
      :clock-resume t)
     ("r" "read" entry
      (file ,(expand-file-name "reading.org" vderyagin/org-agenda-directory))
      "* %?\n:PROPERTIES:\n:Captured_at: %U\n:END:"
      :clock-resume t)
     ("c" "contact" entry
      (file ,vderyagin/org-contacts-file)
      "* %?%(org-contacts-template-name)\n:PROPERTIES:\n:EMAIL: %(org-contacts-template-email)\n:END:"
      :clock-resume t)
     ("h" "habit" entry
      (file ,(expand-file-name "habits.org" vderyagin/org-agenda-directory))
      "* TODO %?\nSCHEDULED: %t\n:PROPERTIES:\n:Captured_at: %U\n:END:"
      :clock-resume t)
     ("p" "project" entry
      (file ,(expand-file-name "projects.org" vderyagin/org-agenda-directory))
      "* %?\n:PROPERTIES:\n:Captured_at: %U\n:END:"
      :clock-resume t)))

 '(org-refile-use-outline-path 'file)
 '(org-refile-allow-creating-parent-nodes 'confirm)
 '(org-refile-targets '((org-agenda-files :maxlevel . 1)
                        (nil :maxlevel . 2)))
 '(org-refile-target-verify-function (lambda ()
                                       "Exclude todo keywords with a done state from refile targets."
                                       (not (member (nth 2 (org-heading-components)) org-done-keywords))))

 '(org-clock-auto-clock-resolution 'when-no-clock-is-running)
 '(org-clock-clocktable-default-properties '(:maxlevel 3 :scope file))
 '(org-clock-history-length 20)
 '(org-clock-in-resume t)
 '(org-clock-in-switch-to-state nil)
 '(org-clock-out-remove-zero-time-clocks t)
 '(org-clock-out-switch-to-state nil)
 '(org-clock-out-when-done '("HOLD" "WAITING" "CANCELLED" "DONE"))
 '(org-clock-persist 'history)
 '(org-clock-report-include-clocking-task t)

 '(appt-audible nil)
 '(appt-message-warning-time 15)
 '(appt-display-format 'window)
 '(appt-display-diary nil)
 '(appt-display-interval 3)
 '(appt-disp-window-function
   (lambda (left time message)
     (notifications-notify
      :title (format "%s minute(s) left" left)
      :body message
      :app-icon (expand-file-name "~/.icons/org-mode.png"))))

 '(org-agenda-block-separator (make-string 90 61))
 '(org-agenda-compact-blocks nil)
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-show-inherited-tags nil)
 '(org-agenda-span 'day)
 '(org-agenda-tags-column -90)
 '(org-agenda-todo-list-sublevels nil)
 '(org-agenda-window-setup 'current-window)
 '(org-agenda-start-with-clockreport-mode nil)
 '(org-agenda-start-with-entry-text-mode nil)
 '(org-agenda-start-with-follow-mode nil)
 '(org-agenda-start-with-log-mode nil)
 '(org-agenda-custom-commands
   '((" " "Block agenda"
      ((agenda)
       (tags "ONGOING"
             ((org-agenda-overriding-header "Ongoing tasks:")
              (org-agenda-skip-function
               '(or
                 (org-agenda-skip-entry-if 'todo 'done)
                 (org-agenda-skip-entry-if 'timestamp)))))
       (tags "REFILE"
             ((org-agenda-overriding-header "List of tasks to refile:")
              (org-tags-match-list-sublevels nil)))))
     ("A" "List of tasks to archive" todo "DONE|CANCELLED"
      ((org-agenda-overriding-header "List of tasks to archive:")
       (org-tags-match-list-sublevels nil))))))

(eval-after-load 'org-clock
  '(add-hook 'org-clock-out-hook 'vderyagin/remove-empty-drawer-on-clock-out 'append))

(eval-after-load 'ob
  '(mapc
    (lambda (language) (add-to-list 'org-babel-load-languages (cons language t)))
    '(awk dot haskell js lisp perl python ruby scheme sh)))

(eval-after-load 'org-capture
  '(progn
    (define-key org-capture-mode-map (kbd "C-c t") 'org-set-tags)
    (add-hook 'org-capture-after-finalize-hook 'vderyagin/org-update-agenda-views)
    (add-hook 'org-capture-before-finalize-hook 'org-align-all-tags)))

(eval-after-load 'org-agenda
  (quote
   (progn
     (add-hook 'org-agenda-mode-hook 'vderyagin/org-agenda-activate-appt)

     (define-key org-agenda-mode-map (kbd "C-S-<left>") nil)
     (define-key org-agenda-mode-map (kbd "C-S-<right>") nil)

     (define-key org-agenda-mode-map (kbd "M-p") 'org-previous-link)
     (define-key org-agenda-mode-map (kbd "M-n") 'org-next-link))))

(eval-after-load 'org
  (quote
   (progn
     (require 'org-checklist)
     (require 'org-crypt)
     (require 'org-contacts)
     (require 'org-habit)

     (org-clock-persistence-insinuate)
     (org-crypt-use-before-save-magic)

     ;; Get rid of strike-through emphasis:
     (cl-delete-if
      (lambda (item) (string= "+" (car item)))
      org-emphasis-alist)

     (add-hook 'org-mode-hook
               (defun vderyagin/org-mode-hook ()
                 (turn-on-auto-fill)
                 (turn-on-visual-line-mode)
                 (set (make-local-variable 'backup-inhibited) t)
                 (add-hook 'before-save-hook 'org-align-all-tags nil 'make-it-local)))

     (define-key org-mode-map (kbd "M-n") 'org-next-link)
     (define-key org-mode-map (kbd "M-p") 'org-previous-link)

     ;; disable keys for adding/removing files from agenda:
     (define-key org-mode-map (kbd "C-c [") nil)
     (define-key org-mode-map (kbd "C-c ]") nil)

     ;; resolving conflicts with global bindings
     (define-key org-mode-map (kbd "S-C-<left>") nil)
     (define-key org-mode-map (kbd "S-C-<right>") nil)
     (define-key org-mode-map (kbd "C-<tab>") nil)

     (define-key org-mode-map (kbd "C-x C-s")
       (lambda ()
         "Save current buffer and update all agenda views."
         (interactive)
         (call-interactively 'save-buffer)
         (vderyagin/org-update-agenda-views))))))


(defun vderyagin/org-agenda-activate-appt ()
  (org-agenda-to-appt t '((headline "IMPORTANT") (category "Appt")))
  (appt-activate t))

(defun vderyagin/remove-empty-drawer-on-clock-out ()
  "Delete clocking drawer if it is empty."
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(defun vderyagin/org-update-agenda-views ()
  "Update all org agenda buffers (if any)."
  (save-window-excursion
    (mapc
     (lambda (buf)
       (with-current-buffer buf
         (org-agenda-redo t)))
     (get-buffers-with-major-mode 'org-agenda-mode))))

(defun vderyagin/find-org-file ()
  "Select and open org file from `org-directory' or one if its subdirectories."
  (interactive)
  (flet ((get-relative-path (abs)
           (file-relative-name abs org-directory))
         (get-absolute-path (rel)
           (expand-file-name rel org-directory)))
    (let ((files
           (delete ""
                   (split-string
                    (shell-command-to-string
                     (let ((default-directory org-directory))
                       (find-cmd
                        '(type "f")
                        '(iname "*.org" "*.gpg")
                        '(print0))))
                    "\0")))
          relative-path
          absolute-path)
      (setq relative-path (ido-completing-read
                           "Open org file: "
                           (mapcar 'get-relative-path files))
            absolute-path (get-absolute-path relative-path))
      (find-file absolute-path))))
