(setq ido-create-new-buffer 'always
      ido-completion-buffer "*Completions*"
      ido-default-buffer-method 'selected-window
      ido-case-fold t                     ; ignore case
      ido-enable-last-directory-history nil
      ido-use-filename-at-point nil       ; don't use filename at point (annoying)
      ido-use-url-at-point nil            ; don't use url at point (annoying)
      ido-enable-flex-matching t          ; be smart
      ido-max-prospects 15                ; don't spam my minibuffer
      ido-confirm-unique-completion t     ; don't be too smart
      ido-decorations '("\n-> " "" "\n   " "\n   ..." "[" "]"
                        " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")
      ido-ubiquitous-command-exceptions '(gnus-topic-move-group
                                          execute-extended-command
                                          bookmark-set))

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
        "\\*magit-"
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
        "^\\*Help\\*$"
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
        "^\\*Summary "
        "^\\*Tetris\\*$"
        "^\\*Thumbs: .+$"
        "^\\*Warnings\\*$"
        "^\\*WoMan-Log\\*$"
        "^\\*ack\\*$"
        "^\\*anything"
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
        "^\\*ioccur"
        "^\\*nnimap "
        "^\\*rake\\*$"
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


(defun my-ido-minibuffer-setup-hook ()
  "allow line wrapping in the minibuffer"
  (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'my-ido-minibuffer-setup-hook)


(defun ido-select-buffer-by-mode (mode choice-string &optional fallback-function)
  "Uses `ido-completing-read' for selecting buffers by MODE
FALLBACK-FUNCTION is called when there is no buffers with MODE"
  (let ((buf-list (mapcar (lambda (buf) (buffer-name buf))
                          (get-buffers-with-major-mode mode))))
    (if buf-list
        (switch-to-buffer
         (if (equal (length buf-list) 1)
             (car buf-list)
             (ido-completing-read choice-string buf-list)))
        (when (boundp 'fallback-function)
          (funcall fallback-function)))))


(defun my-ido-erc-buffers()
  "Switch to one of the ERC channel buffers or connect to IRC"
  (interactive)
  (ido-select-buffer-by-mode
   'erc-mode "Irc channel: "
   (lambda ()
     (if (y-or-n-p "Connect to IRC? ")
         (my-join-erc)
         (message "As you wish.")))))

(define-key global-map (kbd "C-x e") 'my-ido-erc-buffers)


(defun my-ido-dired-buffers()
  "Switch to one of the Dired buffers or open home directory"
  (interactive)
  (ido-select-buffer-by-mode
   'dired-mode "Dired buffer: "
   (lambda () (dired "~"))))

(define-key global-map (kbd "C-x C-d") 'ido-dired)
(define-key global-map (kbd "C-x d") 'my-ido-dired-buffers)


(defun my-ido-twittering-buffers ()
  "Switch to on of the twittering-mode buffers or open one"
  (interactive)
  (ido-select-buffer-by-mode
   'twittering-mode "Twittering buffer: "
   (lambda ()
     (if (y-or-n-p "Read Twitter? ")
         (twit)
         (message "As you wish.")))))

(define-key global-map (kbd "C-x t") 'my-ido-twittering-buffers)

(mapc
 (lambda (key)
   (define-key ido-common-completion-map key nil))
 '([right] [left] [up] [down]))

(define-key ido-common-completion-map (kbd "C-p") 'ido-prev-match)
(define-key ido-common-completion-map (kbd "C-n") 'ido-next-match)



(setq smex-auto-update t
      smex-save-file "~/.emacs.d/smex.save"
      smex-history-length 10)

(require 'smex)
(smex-initialize)

(define-key global-map (kbd "M-x") 'smex)
(define-key global-map (kbd "M-X") 'smex-major-mode-commands)
(define-key global-map (kbd "C-c C-m") 'execute-extended-command)
