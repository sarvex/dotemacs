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

(with-eval-after-load 'ibuffer
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
   '([right] [left] [up] [down])))


(defadvice ibuffer-generate-filter-groups (after reverse-ibuffer-groups () activate)
  (setq ad-return-value (nreverse ad-return-value)))

(defvar vderyagin/ibuffer-filter-groups nil)
(setq vderyagin/ibuffer-filter-groups nil)

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("dired" (or
            (mode . dired-mode)
            (mode . tree-mode)
            (mode . wdired-mode)
            )))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("docs" (or
           (mode . Info-mode)
           (mode . Man-mode)
           (mode . help-mode)
           (mode . irfc-mode)
           (mode . woman-mode)
           (mode . yari-mode)
           (name . "^\\*godoc ")
           )))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 `("org" (or
          (filename . ,(expand-file-name "~/org/"))
          (mode . org-agenda-mode)
          )))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("erc" (mode . erc-mode)))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("repl" (or
           (mode . cider-repl-mode)
           (mode . erlang-shell-mode)
           (mode . eshell-mode)
           (mode . haskell-interactive-mode)
           (mode . inferior-emacs-lisp-mode)
           (mode . inferior-haskell-mode)
           (mode . inferior-ruby-mode)
           (mode . inferior-scheme-mode)
           (mode . shell-mode)
           (mode . sldb-mode)
           (mode . slime-repl-mode)
           (mode . sql-interactive-mode)
           (mode . term-mode)
           )))

(let ((code-dir "~/code"))
  (cl-flet ((dirs-in (dir)
                     (when (file-directory-p dir)
                       (cl-remove-if-not
                        #'file-directory-p
                        (directory-files (expand-file-name dir)
                                         'full-paths
                                         (rx string-start (not (any "."))))))))
    (mapc
     (lambda (dir)
       (mapc
        (lambda (project)
          (add-to-list 'vderyagin/ibuffer-filter-groups
                       `(,(abbreviate-file-name project)
                          (or
                           (predicate . (string-prefix-p ,(expand-file-name project) (expand-file-name default-directory)))
                           (filename . ,project)))))
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
            (name . "^\\*Hanoi\\*$")
            (name . "^\\*Pong\\*$")
            (name . "^\\*The Typing Of Emacs\\*$")
            (name . "^\\*butterfly\\*$")
            (name . "^\\*fortune\\*$")
            (name . "^bubbles-default-2-10-10-scores$")
            (name . "^snake-scores$")
            (name . "^tetris-scores$")
            )))

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
           (mode . mail-mode)
           (mode . message-mode)
           (mode . rmail-mode)
           )))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("misc" (or
           (mode . image-dired-display-image-mode)
           (mode . image-dired-thumbnail-mode)
           (mode . image-mode)
           (mode . thumbs-mode)
           (mode . thumbs-view-image-mode)
           (mode . twittering-edit-mode)
           (mode . twittering-mode)
           )))

(add-to-list
 'vderyagin/ibuffer-filter-groups
 '("emacs" (or
            (mode . Buffer-menu-mode)
            (mode . Custom-mode)
            (mode . ack-mode)
            (mode . apropos-mode)
            (mode . calc-mode)
            (mode . calc-trail-mode)
            (mode . calculator-mode)
            (mode . calendar-mode)
            (mode . checkdoc-output-mode)
            (mode . cider-stacktrace-mode)
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
            (mode . gnus-custom-mode)
            (mode . grep-mode)
            (mode . gud-mode)
            (mode . haskell-error-mode)
            (mode . haskell-menu-mode)
            (mode . locate-mode)
            (mode . magit-branch-manager-mode)
            (mode . magit-commit-mode)
            (mode . magit-log-mode)
            (mode . magit-reflog-mode)
            (mode . magit-status-mode)
            (mode . magit-wazzup-mode)
            (mode . occur-mode)
            (mode . package-menu-mode)
            (mode . process-menu-mode)
            (mode . profiler-report-mode)
            (mode . rake-mode)
            (mode . reb-lisp-mode)
            (mode . rspec-mode)
            (mode . select-tags-table-mode)
            (mode . special-mode)
            (mode . speedbar-mode)
            (mode . tags-table-mode)
            (mode . vc-annotate-mode)
            (mode . vc-dir-mode)
            (mode . vc-git-log-view-mode)
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
            (name . "^\\*Org Shell Output\\*")
            (name . "^\\*Phases of Moon\\*$")
            (name . "^\\*Python\\*$")
            (name . "^\\*Quail Completions\\*$")
            (name . "^\\*Shell Command Output\\*$")
            (name . "^\\*Smex: ")
            (name . "^\\*Warnings\\*$")
            (name . "^\\*WoMan-Log\\*$")
            (name . "^\\*emacs\\*$")
            (name . "^\\*ensime-events\\*$")
            (name . "^\\*gnus trace\\*$")
            (name . "^\\*haskell-process-log\\*$")
            (name . "^\\*imap log\\*$")
            (name . "^\\*inferior-ensime-server\\*$")
            (name . "^\\*inferior-lisp\\*$")
            (name . "^\\*interpretation\\*$")
            (name . "^\\*magit-process\\*$")
            (name . "^\\*nREPL error\\*$")
            (name . "^\\*nnimap ")
            (name . "^\\*nrepl-")
            (name . "^\\*slime-events\\*$")
            (name . "^\\*swank\\*$")
            (name . "^\\*tramp/")
            (name . "^\\*twmode")
            (name . "^ido-history$")
            (name . "^newsrc-dribble$")
            (predicate . (equal mode-name "Helm"))
            )))

(setq ibuffer-saved-filter-groups
      `(("default" ,@vderyagin/ibuffer-filter-groups)))
