(require 'ibuffer)

(define-key global-map (kbd "C-x C-b") 'ibuffer)

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
    (:name "Size" :inline t)
  (cond
    ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
    ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
    (t (format "%8d" (buffer-size)))))


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


(setq my-ibuffer-filter-groups ())

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
 '("dired" (or
            (mode . tree-mode)
            (mode . dired-mode))))

(add-to-list
 'my-ibuffer-filter-groups
 '("org" (or (mode . org-mode)
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
 '("slime" (or
            (mode . slime-repl-mode)
            (mode . sldb-mode)
            (name . "^\\*slime")
            (name . "^\\*inferior-lisp\\*$"))))

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
 '("shell" (or
            (name . "^\\*Python\\*$")
            (name . "^\\*interpretation\\*$")
            (mode . inf-ruby-mode)
            (mode . erlang-shell-mode)
            (mode . term-mode)
            (mode . inferior-emacs-lisp-mode)
            (mode . shell-mode)
            (mode . eshell-mode))))

(add-to-list
 'my-ibuffer-filter-groups
 '("elisp" (or
            (filename . ".emacs.d/conf/")
            (filename . ".emacs.d/misc/")
            (mode . lisp-interaction-mode))))


(add-to-list
 'my-ibuffer-filter-groups
 '("games" (or
            (mode . doctor-mode)
            (mode . solitaire-mode)
            (mode . snake-mode)
            (mode . tetris-mode)
            (name . "^snake-scores$")
            (name . "^tetris-scores$"))))

(add-to-list
 'my-ibuffer-filter-groups
 '("mail" (or
           (mode . gnus-group-mode)
           (mode . gnus-summary-mode)
           (mode . gnus-article-mode)
           (mode . gnus-sticky-article-mode)
           (mode . gnus-server-mode)
           (mode . gnus-edit-form-mode)
           (mode . gnus-browse-mode)
           (mode . message-mode)
           (mode . mail-mode))))

(add-to-list
 'my-ibuffer-filter-groups
 '("misc" (or
           (mode . twittering-mode)
           (mode . twittering-edit-mode)
           (mode . image-mode))))


(add-to-list
 'my-ibuffer-filter-groups
 '("emacs" (or
            (mode . gud-mode)
            (mode . gdb-frames-mode)
            (mode . gdb-inferior-io-mode)
            (mode . gdb-breakpoints-mode)
            (mode . gdb-locals-mode)
            (mode . gdb-registers-mode)
            (mode . completion-list-mode)
            (mode . tags-table-mode)
            (mode . package-menu-mode)
            (mode . vc-dir-mode)
            (mode . epa-key-list-mode)
            (mode . epa-key-mode)
            (mode . occur-mode)
            (mode . ioccur-mode)
            (mode . sql-interactive-mode)
            (mode . finder-mode)
            (mode . apropos-mode)
            (mode . bookmark-bmenu-mode)
            (mode . Custom-mode)
            (mode . custom-theme-choose-mode)
            (mode . gnus-custom-mode)
            (mode . special-mode)
            (mode . Buffer-menu-mode)
            (mode . grep-mode)
            (mode . ack-mode)
            (mode . browse-kill-ring-mode)
            (mode . wget-mode)
            (mode . diff-mode)
            (mode . locate-mode)
            (mode . calendar-mode)
            (mode . process-menu-mode)
            (mode . compilation-mode)
            (mode . magit-mode)
            (mode . speedbar-mode)
            (mode . display-time-world-mode)
            (mode . pylookup-mode)
            (mode . calc-mode)
            (mode . calc-trail-mode)
            (mode . calculator-mode)
            (mode . debugger-mode)
            (mode . image-dired-thumbnail-mode)
            (mode . image-dired-display-image-mode)
            (mode . thumbs-view-image-mode)
            (mode . thumbs-mode)

            (predicate . (equal mode-name "Anything"))

            (name . "^\\*hg ")
            (name . "^\\*aHG ")
            (name . "^\\*ahg-")
            (name . "^\\*magit-")
            (name . "^\\*Smex: ")
            (name . "^\\*semanticdb")
            (name . "^\\*SEMANTICDB")
            (name . "^\\*EBROWSE")
            (name . "^ido.last$")
            (name . "^TAGS$")
            (name . "^\\*MIME")
            (name . "^\\*etags ")
            (name . "^\\*WoMan-Log\\*$")
            (name . "^\\*Minibuf")
            (name . "^\\*IPython ")
            (name . "^\\*Dired log\\*$")
            (name . "^\\*Ediff Registry\\*$")
            (name . "^\\*Shell Command Output\\*$")
            (name . "^\\*Async Shell Command\\*$")
            (name . "^\\*Quail Completions\\*$")
            (name . "^\\*Compile-Log\\*$")
            (name . "^\\*Messages\\*$")
            (name . "^\\*Colors\\*$")
            (name . "^\\*Apropos\\*$")
            (name . "^\\*gists\\*$")
            (name . "^\\*twmode")
            (name . "^\\*About GNU Emacs\\*$")
            (name . "^\\*Warnings\\*$")
            (name . "^\\*Clock Task Select\\*$")
            (name . "^\\*/.*-preprocessed\\*$")
            (name . "^\\*Pymacs\\*$")
            (name . "^recentf$")
            (name . "^newsrc-dribble$")
            (name . "^\\*Phases of Moon")
            (name . "^\\*tramp/")
            (name . "^\\*imap log\\*$")
            (name . "^\\*gnus trace\\*$")
            (name . "^\\*nnimap "))))


(setq ibuffer-saved-filter-groups
      `(("default" ,@my-ibuffer-filter-groups)))



(defun my-ibuffer-mode-hook ()
  (ibuffer-switch-to-saved-filter-groups "default"))


(defadvice ibuffer-generate-filter-groups
    (after reverse-ibuffer-groups ()
           activate)
  (setq ad-return-value (nreverse ad-return-value)))

(define-key ibuffer-mode-map (kbd "<up>") nil)
(define-key ibuffer-mode-map (kbd "<down>") nil)
(define-key ibuffer-mode-map (kbd "<left>") nil)
(define-key ibuffer-mode-map (kbd "<right>") nil)
(define-key ibuffer-mode-map (kbd "C-x C-f") 'ido-find-file)
(define-key ibuffer-mode-map (kbd "[") 'ibuffer-toggle-filter-group)

(add-hook 'ibuffer-mode-hook 'my-ibuffer-mode-hook)
