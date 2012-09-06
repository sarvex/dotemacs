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
                                          bookmark-set))

(setq ido-ignore-buffers
      '("^ "
        "^\\*anything"
        "^\\*Bookmark List\\*$"
        "^\\*Org .*\\*$"
        "^\\*Apropos\\*$"
        "^\\*Warnings\\*$"
        "^\\*Calendar\\*$"
        "^\\*Phases of Moon\\*$"
        "^\\*Marked Files\\*$"
        "^\\*Locate\\*$"
        "^\\*Colors\\*$"
        "^\\*IPython "
        "^\\*Pylookup"
        "^\\*interpretation\\*$"
        "^\\*ioccur"
        "^\\*twmode"
        "^\\*tramp/"
        "^\\*Customize"
        "^\\*Custom Themes\\*$"
        "^\\*Finder"
        "^\\*Keys\\*$"
        "^\\*Grep\\*$"
        "^\\*wget\\*$"
        "^\\*ack\\*$"
        "^\\*gists\\*$"
        "^\\*Pymacs\\*$"
        "^\\*semanticdb"
        "^\\*SEMANTICDB"
        "^\\*EBROWSE"
        "^\\*SQL\\*$"
        "^\\*Compile-log\\*$"
        "^\\*Process List\\*$"
        "^\\*Shell Command Output\\*$"
        "^\\*WoMan-Log\\*$"
        "^\\*Ediff Registry\\*$"
        "^\\*Quail Completions\\*$"
        "^\\*Kill Ring\\*$"
        "^snake-scores$"
        "^tetris-scores$"
        "^\\*fsm-debug\\*$"
        "^\\*etags "
        "^\\*MIME"
        "^\\*sent "
        "^\\*Dired log\\*$"
        "^\\*Ibuffer\\*$"
        "^\\*SPEEDBAR\\*$"
        "^\\*Tetris\\*$"
        "^\\*Image\\*$"
        "^\\*vc-dir\\*$"
        "^\\*Thumbs: .+$"
        "^\\*Snake\\*$"
        "^\\*slime-events\\*$"
        "^\\*image-dired"
        "^\\*inferior-lisp\\*$"
        "^\\*Python\\*$"
        "^\\*cheezburger\\*$"
        "^\\*compilation\\*$"
        "^\\*Minibuf"
        "^\\*Faces\\*$"
        "^\\*Help\\*$"
        "^\\*Packages\\*$"
        "^\\*Solitaire\\*$"
        "\\*ECB"
        "\\*ESS\\*"
        "\\*Backtrace"
        "\\*Buffer"
        "\\*Completions"
        "\\.cvsignore"
        "\\*cvs-commit"
        "\\*reg group-leader\\*"
        "\\*Async Shell Command"
        "^[gG]?[tT][aA][gG][sS]$"
        "\\*semantic"
        "\\*Calc"
        "\\*svn"
        "\\*git-"
        "\\*Git "
        "\\*Gnuplot "
        "\\*BBDB\\*"
        "^\\*Key\\*"
        "\\*magit-"
        "\\*aHG "
        "\\*hg "
        "^\\*Smex: "
        "\\*Occur\\*"
        "-preprocessed\\*"
        "\\*CEDET"
        "^newsrc-dribble$"
        "^\\*gnus trace\\*$"
        "^\\*imap log\\*$"
        "^\\*nnimap "
        "^\\*Article "
        "^\\*Summary "
        "^\\*About GNU Emacs\\*$"
        "^\\*yari "
        "\\.org\\'"))

(require 'ido)

(ido-mode t)
(ido-ubiquitous t)


;; (ido-everywhere t)


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

;; This is your old M-x.
(define-key global-map (kbd "C-c C-m") 'execute-extended-command)
