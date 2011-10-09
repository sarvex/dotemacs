(define-key global-map (kbd "C-x C-b") 'ibuffer)

(setq ibuffer-deletion-face 'diredp-deletion-file-name
      ibuffer-marked-face 'diredp-flag-mark
      ibuffer-show-empty-filter-groups nil)

(setq ibuffer-formats
      '((mark modified read-only
         " " (name 40 40 :left :elide)
         " " (size-h 9 -1 :right)
         " " (mode 14 14 :left :elide)
         " " filename-and-process)
        (mark " " (name 23 -1) " " filename)))

(defun my-ibuffer-mode-hook ()
  (ibuffer-switch-to-saved-filter-groups "default"))

(eval-after-load 'ibuffer
  '(progn

    ;; Use human readable Size column instead of original one
    (define-ibuffer-column size-h
        (:name "Size" :inline t)
      (cond
        ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
        ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
        (t (format "%8d" (buffer-size)))))

    (add-hook 'ibuffer-mode-hook 'my-ibuffer-mode-hook)

    (define-key ibuffer-mode-map (kbd "C-w") 'ibuffer-unmark-backward)
    (define-key ibuffer-mode-map (kbd "C-x C-f") 'ido-find-file)
    (define-key ibuffer-mode-map (kbd "[") 'ibuffer-toggle-filter-group)
    (dolist (k '([right] [left] [up] [down]))
      (define-key ibuffer-mode-map k nil))))


(defadvice ibuffer-generate-filter-groups
    (after reverse-ibuffer-groups ()
           activate)
  (setq ad-return-value (nreverse ad-return-value)))

(setq my-ibuffer-filter-groups ())

(add-to-list
 'my-ibuffer-filter-groups
 '("dired" (or
            (mode . tree-mode)
            (mode . wdired-mode)
            (mode . dired-mode))))

(add-to-list
 'my-ibuffer-filter-groups
 '("docs" (or
           (mode . help-mode)
           (mode . Info-mode)
           (mode . irfc-mode)
           (mode . yari-mode)
           (name . "^\\*Help\\*$")
           (mode . Man-mode)
           (mode . woman-mode))))

(add-to-list
 'my-ibuffer-filter-groups
 '("org" (or
          (mode . org-mode)
          (mode . org-agenda-mode)
          (name . "^\\*Org .*\\*$"))))

(add-to-list
 'my-ibuffer-filter-groups
 '("w3m" (mode . w3m-mode)))

(add-to-list
 'my-ibuffer-filter-groups
 '("jabber" (or
             (name . "^\\*fsm-debug\\*$")
             (mode . jabber-chat-mode)
             (mode . jabber-roster-mode))))

(add-to-list
 'my-ibuffer-filter-groups
 '("erc" (mode . erc-mode)))

(add-to-list
 'my-ibuffer-filter-groups
 '("shell" (or
            (name . "^\\*Python\\*$")
            (name . "^\\*interpretation\\*$")
            (mode . inf-ruby-mode)
            (mode . erlang-shell-mode)
            (mode . term-mode)
            (mode . inferior-emacs-lisp-mode)
            (mode . inferior-scheme-mode)
            (mode . sql-interactive-mode)
            (mode . shell-mode)
            (mode . eshell-mode))))

(dolist (p (remove "." (remove ".." (directory-files (expand-file-name "~/dev")))))
  (add-to-list 'my-ibuffer-filter-groups `(,(format "Project: %s" p) (filename . ,(expand-file-name p "~/dev")))))

(add-to-list
 'my-ibuffer-filter-groups
 '("dotfiles" (filename . "/.dotfiles/")))

(add-to-list
 'my-ibuffer-filter-groups
 '("zsh" (filename . "/.zsh/")))

(add-to-list
 'my-ibuffer-filter-groups
 '("slime" (or
            (mode . slime-repl-mode)
            (mode . sldb-mode)
            (name . "^\\*slime")
            (name . "^\\*inferior-lisp\\*$"))))

(add-to-list
 'my-ibuffer-filter-groups
 '("elisp" (or
            (filename . ".emacs.d/dotemacs/conf/")
            (filename . ".emacs.d/dotemacs/misc/")
            (filename . ".emacs.d/dotemacs/scripts/")
            (mode . lisp-interaction-mode))))

(add-to-list
 'my-ibuffer-filter-groups
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
 'my-ibuffer-filter-groups
 '("mail" (or
           (filename . ".mail/archive/sent/")
           (mode . gnus-group-mode)
           (mode . gnus-summary-mode)
           (mode . gnus-article-mode)
           (mode . gnus-sticky-article-mode)
           (mode . gnus-server-mode)
           (mode . gnus-edit-form-mode)
           (mode . gnus-browse-mode)
           (mode . message-mode)
           (mode . rmail-mode)
           (mode . mail-mode))))

(add-to-list
 'my-ibuffer-filter-groups
 '("misc" (or
           (mode . twittering-mode)
           (mode . twittering-edit-mode)
           (mode . thumbs-mode)
           (mode . thumbs-view-image-mode)
           (mode . image-dired-display-image-mode)
           (mode . image-dired-thumbnail-mode)
           (mode . image-mode))))

(add-to-list
 'my-ibuffer-filter-groups
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
            (mode . browse-kill-ring-mode)
            (mode . calc-mode)
            (mode . calc-trail-mode)
            (mode . calculator-mode)
            (mode . calendar-mode)
            (mode . compilation-mode)
            (mode . completion-list-mode)
            (mode . custom-theme-choose-mode)
            (mode . debugger-mode)
            (mode . diff-mode)
            (mode . display-time-world-mode)
            (mode . epa-key-list-mode)
            (mode . epa-key-mode)
            (mode . finder-mode)
            (mode . gdb-breakpoints-mode)
            (mode . gdb-frames-mode)
            (mode . gdb-inferior-io-mode)
            (mode . gdb-locals-mode)
            (mode . gdb-registers-mode)
            (mode . gnus-custom-mode)
            (mode . grep-mode)
            (mode . gud-mode)
            (mode . ioccur-mode)
            (mode . locate-mode)
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
            (mode . pylookup-mode)
            (mode . rdebug-breakpoint-mode)
            (mode . rdebug-frames-mode)
            (mode . rdebug-info-mode)
            (mode . rdebug-output-mode)
            (mode . rdebug-secondary-window-help-mode)
            (mode . rdebug-variables-mode)
            (mode . rdebug-watch-mode)
            (mode . special-mode)
            (mode . speedbar-mode)
            (mode . tags-table-mode)
            (mode . vc-dir-mode)
            (predicate . (equal mode-name "Anything"))

            (name . "^\\*About GNU Emacs\\*$")
            (name . "^\\*Apropos\\*$")
            (name . "^\\*Async Shell Command\\*$")
            (name . "^\\*Clock Task Select\\*$")
            (name . "^\\*Colors\\*$")
            (name . "^\\*Dired log\\*$")
            (name . "^\\*Ediff Registry\\*$")
            (name . "^\\*Gnuplot ")
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
            (name . "^\\*nnimap ")
            (name . "^\\*tramp/")
            (name . "^\\*twmode")
            (name . "^newsrc-dribble$"))))

(setq ibuffer-saved-filter-groups
      `(("default" ,@my-ibuffer-filter-groups)))
