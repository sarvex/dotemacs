;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ibuffer-deletion-face 'diredp-deletion-file-name)
  '(ibuffer-marked-face 'diredp-flag-mark)
  '(ibuffer-show-empty-filter-groups nil)

  '(ibuffer-formats
    '((mark modified read-only
       " " (name 40 40 :left :elide)
       " " (size-h 9 -1 :right)
       " " (mode 14 14 :left :elide)
       " " filename-and-process)
      (mark " " (name 23 -1) " " filename))))

(eval-after-load 'ibuffer
  (quote
   (progn

     ;; Use human readable Size column instead of original one
     (define-ibuffer-column size-h
         (:name "Size" :inline t)
       (cond
         ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
         ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
         (t (format "%8d" (buffer-size)))))

     (add-hook 'ibuffer-mode-hook
               (lambda ()
                 (ibuffer-switch-to-saved-filter-groups "default")))

     (define-key ibuffer-mode-map (kbd "C-w") 'ibuffer-unmark-backward)
     (define-key ibuffer-mode-map (kbd "[") 'ibuffer-toggle-filter-group)

     ;; Do not shadow global binding:
     (define-key ibuffer-mode-map (kbd "C-x C-f") nil)

     (mapc
      (lambda (key)
        (define-key ibuffer-mode-map key nil))
      '([right] [left] [up] [down])))))


(defadvice ibuffer-generate-filter-groups (after reverse-ibuffer-groups () activate)
  (setq ad-return-value (nreverse ad-return-value)))

(defvar vderyagin/ibuffer-filter-groups nil)
(setq vderyagin/ibuffer-filter-groups nil)

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("dired" (or
            (mode . tree-mode)
            (mode . wdired-mode)
            (mode . dired-mode))))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("docs" (or
           (mode . help-mode)
           (mode . Info-mode)
           (mode . irfc-mode)
           (mode . yari-mode)
           (mode . Man-mode)
           (mode . woman-mode)
           (name . "^\\*godoc "))))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 `("org" (or
          (mode . org-agenda-mode)
          (filename . ,(expand-file-name "~/org/")))))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("w3m" (mode . w3m-mode)))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("jabber" (or
             (name . "^\\*fsm-debug\\*$")
             (mode . jabber-chat-mode)
             (mode . jabber-roster-mode))))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("erc" (mode . erc-mode)))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("shell" (or
            (name . "^\\*Python\\*$")
            (name . "^\\*interpretation\\*$")
            (mode . inferior-ruby-mode)
            (mode . inferior-haskell-mode)
            (mode . erlang-shell-mode)
            (mode . term-mode)
            (mode . inferior-emacs-lisp-mode)
            (mode . inferior-scheme-mode)
            (mode . sql-interactive-mode)
            (mode . shell-mode)
            (mode . eshell-mode)
            (mode . slime-repl-mode)
            (mode . sldb-mode)
            (name . "^\\*slime")
            (name . "^\\*inferior-lisp\\*$")
            (mode . nrepl-mode))))

(let ((code-dir "~/code"))
  (cl-flet ((dirs-in (dir)
                     (when (file-directory-p dir)
                           (directory-files (expand-file-name dir)
                                            'full-paths
                                            (rx string-start (not (any ".")))))))
    (mapc
     (lambda (dir)
       (mapc
        (lambda (project)
          (add-to-list 'vderyagin/ibuffer-filter-groups
                       (list (abbreviate-file-name project)
                             (cons 'filename project))))
        (dirs-in dir)))
     (dirs-in code-dir))))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("games" (or
            (mode . 5x5-mode)
            (mode . blackbox-mode)
            (mode . bubbles-mode)
            (mode . doctor-mode)
            (mode . dun-mode)
            (mode . gomoku-mode)
            (mode . landmark-mode)
            (mode . life-mode)
            (mode . mpuz-mode)
            (mode . snake-mode)
            (mode . solitaire-mode)
            (mode . tetris-mode)
            (name . "^\\*butterfly\\*$")
            (name . "^\\*Hanoi\\*$")
            (name . "^\\*Pong\\*$")
            (name . "^\\*fortune\\*$")
            (name . "^\\*The Typing Of Emacs\\*$")
            (name . "^bubbles-default-2-10-10-scores$")
            (name . "^snake-scores$")
            (name . "^tetris-scores$"))))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("mail" (or
           (filename . ".mail/archive/sent/")
           (mode . gnus-article-mode)
           (mode . gnus-browse-mode)
           (mode . gnus-edit-form-mode)
           (mode . gnus-group-mode)
           (mode . gnus-server-mode)
           (mode . gnus-sticky-article-mode)
           (mode . gnus-summary-mode)
           (mode . gnus-tree-mode)
           (mode . message-mode)
           (mode . rmail-mode)
           (mode . mail-mode))))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("misc" (or
           (mode . twittering-mode)
           (mode . twittering-edit-mode)
           (mode . thumbs-mode)
           (mode . thumbs-view-image-mode)
           (mode . image-dired-display-image-mode)
           (mode . image-dired-thumbnail-mode)
           (mode . image-mode))))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("emacs" (or
            (mode . Buffer-menu-mode)
            (mode . Custom-mode)
            (mode . ack-mode)
            (mode . ahg-command-mode)
            (mode . ahg-diff-mode)
            (mode . ahg-glog-mode)
            (mode . ahg-log-mode)
            (mode . ahg-mq-patches-mode)
            (mode . ahg-mq-series-mode)
            (mode . ahg-short-log-mode)
            (mode . ahg-status-mode)
            (mode . apropos-mode)
            (mode . bookmark-bmenu-mode)
            (mode . calc-mode)
            (mode . calc-trail-mode)
            (mode . calculator-mode)
            (mode . calendar-mode)
            (mode . checkdoc-output-mode)
            (mode . compilation-mode)
            (mode . completion-list-mode)
            (mode . custom-theme-choose-mode)
            (mode . debugger-mode)
            (mode . diff-mode)
            (mode . display-time-world-mode)
            (mode . epa-key-list-mode)
            (mode . epa-key-mode)
            (mode . ert-results-mode)
            (mode . ert-simple-view-mode)
            (mode . finder-mode)
            (mode . gdb-breakpoints-mode)
            (mode . gdb-frames-mode)
            (mode . gdb-inferior-io-mode)
            (mode . gdb-locals-mode)
            (mode . gdb-registers-mode)
            (mode . gnus-custom-mode)
            (mode . grep-mode)
            (mode . gud-mode)
            (mode . locate-mode)
            (mode . magit-branch-manager-mode)
            (mode . magit-commit-mode)
            (mode . magit-diff-mode)
            (mode . magit-key-mode)
            (mode . magit-log-edit-mode)
            (mode . magit-log-mode)
            (mode . magit-mode)
            (mode . magit-reflog-mode)
            (mode . magit-show-branches-mode)
            (mode . magit-stash-mode)
            (mode . magit-status-mode)
            (mode . magit-wazzup-mode)
            (mode . occur-mode)
            (mode . package-menu-mode)
            (mode . process-menu-mode)
            (mode . profiler-report-mode)
            (mode . rake-mode)
            (mode . rdebug-breakpoint-mode)
            (mode . rdebug-frames-mode)
            (mode . rdebug-info-mode)
            (mode . rdebug-output-mode)
            (mode . rdebug-secondary-window-help-mode)
            (mode . rdebug-variables-mode)
            (mode . rdebug-watch-mode)
            (mode . reb-lisp-mode)
            (mode . rspec-mode)
            (mode . select-tags-table-mode)
            (mode . special-mode)
            (mode . speedbar-mode)
            (mode . tags-table-mode)
            (mode . vc-annotate-mode)
            (mode . vc-dir-mode)
            (mode . vc-git-log-view-mode)
            (predicate . (equal mode-name "Helm"))

            (name . "^\\*About GNU Emacs\\*$")
            (name . "^\\*Apropos\\*$")
            (name . "^\\*Async Shell Command")
            (name . "^\\*Backtrace\\*$")
            (name . "^\\*Choices\\*$")
            (name . "^\\*Clock Task Select\\*$")
            (name . "^\\*Colors\\*$")
            (name . "^\\*Dired log\\*$")
            (name . "^\\*ESS\\*$")
            (name . "^\\*Ediff Registry\\*$")
            (name . "^\\*Eval Expression Output\\*$")
            (name . "^\\*Flycheck error messages\\*$")
            (name . "^\\*Gnuplot ")
            (name . "^\\*Helm Log\\*$")
            (name . "^\\*Holidays\\*$")
            (name . "^\\*Image-Dired Edit Meta Data\\*$")
            (name . "^\\*Messages\\*$")
            (name . "^\\*Minibuf")
            (name . "^\\*Phases of Moon\\*$")
            (name . "^\\*Quail Completions\\*$")
            (name . "^\\*Shell Command Output\\*$")
            (name . "^\\*Smex: ")
            (name . "^\\*Warnings\\*$")
            (name . "^\\*WoMan-Log\\*$")
            (name . "^\\*gists\\*$")
            (name . "^\\*gnus trace\\*$")
            (name . "^\\*imap log\\*$")
            (name . "^\\*magit-process\\*$")
            (name . "^\\*nREPL error\\*$")
            (name . "^\\*nnimap ")
            (name . "^\\*nrepl-connection\\*$")
            (name . "^\\*swank\\*$")
            (name . "^\\*tramp/")
            (name . "^\\*twmode")
            (name . "^ido-history$")
            (name . "^newsrc-dribble$"))))

(setq ibuffer-saved-filter-groups
      `(("default" ,@vderyagin/ibuffer-filter-groups)))
