(setq ido-case-fold t
      ido-save-directory-list-file (expand-file-name "~/.emacs.d/ido-history")
      ido-completion-buffer nil
      ido-confirm-unique-completion t
      ido-create-new-buffer 'prompt
      ido-default-buffer-method 'selected-window
      ido-enable-flex-matching nil
      ido-enable-last-directory-history t
      ido-use-filename-at-point nil
      ido-use-url-at-point nil)

(setq ido-ubiquitous-command-exceptions
      '(gnus-topic-move-group
        execute-extended-command
        bookmark-set))

(setq ido-decorations
      '("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]"
        " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))

(setq ido-ignore-buffers
      '("-preprocessed\\*"
        "\\*Async Shell Command"
        "\\*BBDB\\*"
        "\\*Backtrace"
        "\\*Buffer"
        "\\*CEDET"
        "\\*Calc"
        "\\*Completions"
        "\\*ECB"
        "\\*ESS\\*"
        "\\*Git "
        "\\*Gnuplot "
        "\\*Occur\\*"
        "\\*aHG "
        "\\*cvs-commit"
        "\\*git-"
        "\\*hg "
        "\\*magit"
        "\\*reg group-leader\\*"
        "\\*semantic"
        "\\*svn"
        "\\.cvsignore"
        "^ "
        "^[gG]?[tT][aA][gG][sS]$"
        "^\\*About GNU Emacs\\*$"
        "^\\*Apropos\\*$"
        "^\\*Article "
        "^\\*Bookmark List\\*$"
        "^\\*Calendar\\*$"
        "^\\*Colors\\*$"
        "^\\*Compile-log\\*$"
        "^\\*Custom Themes\\*$"
        "^\\*Customize"
        "^\\*Dired log\\*$"
        "^\\*EBROWSE"
        "^\\*Ediff Registry\\*$"
        "^\\*Faces\\*$"
        "^\\*Finder"
        "^\\*Grep\\*$"
        "^\\*Help"
        "^\\*IPython "
        "^\\*Ibuffer\\*$"
        "^\\*Image\\*$"
        "^\\*Key\\*"
        "^\\*Keys\\*$"
        "^\\*Kill Ring\\*$"
        "^\\*Locate\\*$"
        "^\\*MIME"
        "^\\*Marked Files\\*$"
        "^\\*Minibuf"
        "^\\*Org .*\\*$"
        "^\\*Packages\\*$"
        "^\\*Phases of Moon\\*$"
        "^\\*Process List\\*$"
        "^\\*Pylookup"
        "^\\*Pymacs\\*$"
        "^\\*Python\\*$"
        "^\\*Quail Completions\\*$"
        "^\\*SEMANTICDB"
        "^\\*SPEEDBAR\\*$"
        "^\\*SQL\\*$"
        "^\\*Shell Command Output\\*$"
        "^\\*Smex: "
        "^\\*Snake\\*$"
        "^\\*Solitaire\\*$"
        "^\\*Style Warnings\\*$"
        "^\\*Summary "
        "^\\*Tetris\\*$"
        "^\\*Thumbs: .+$"
        "^\\*Warnings\\*$"
        "^\\*WoMan-Log\\*$"
        "^\\*[Hh]elm"
        "^\\*ack\\*$"
        "^\\*cheezburger\\*$"
        "^\\*compilation\\*$"
        "^\\*etags "
        "^\\*fsm-debug\\*$"
        "^\\*gists\\*$"
        "^\\*gnus trace\\*$"
        "^\\*image-dired"
        "^\\*imap log\\*$"
        "^\\*inferior-lisp\\*$"
        "^\\*interpretation\\*$"
        "^\\*nnimap "
        "^\\*rake\\*$"
        "^\\*rspec\\*$"
        "^\\*semanticdb"
        "^\\*sent "
        "^\\*slime-events\\*$"
        "^\\*tramp/"
        "^\\*twmode"
        "^\\*vc-dir\\*$"
        "^\\*wget\\*$"
        "^\\*yari "
        "^newsrc-dribble$"
        "^snake-scores$"
        "^tetris-scores$"

        (lambda (name)
          "Ignore all dired buffers."
          (with-current-buffer name
            (derived-mode-p 'dired-mode)))

        (lambda (name)
          "Ignore all org buffers that are in `org-directory'."
          (with-current-buffer name
            (and
             buffer-file-name
             (eq major-mode 'org-mode)
             (string-prefix-p (expand-file-name org-directory)
                              buffer-file-name))))))


(require 'ido)

(ido-mode t)
(ido-ubiquitous t)

(define-key global-map (kbd "C-x C-d") 'ido-dired)


(add-hook 'ido-minibuffer-setup-hook
          (defun vderyagin/ido-minibuffer-setup-hook ()
            "allow line wrapping in the minibuffer"
            (set (make-local-variable 'truncate-lines) nil)))

(add-hook 'ido-setup-hook
          (defun vderyagin/ido-setup-hook ()
            "Set up key bindings for use for `ido-mode' completion"
            (mapc
             (lambda (key)
               (define-key ido-completion-map key nil))
             '([right] [left] [up] [down]))

            (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
            (define-key ido-completion-map (kbd "C-n") 'ido-next-match)))


(setq smex-auto-update t
      smex-save-file "~/.emacs.d/smex.save"
      smex-history-length 500)

(require 'smex)
(smex-initialize)

(define-key global-map (kbd "M-x") 'smex)
(define-key global-map (kbd "M-X") 'smex-major-mode-commands)
(define-key global-map (kbd "C-c C-m") 'execute-extended-command)
