(define-key global-map (kbd "C-c ;") 'comment-or-uncomment-current-line-or-region)


(eval-after-load "sh-script"
  '(progn
    (define-key sh-mode-map (kbd "<f9>") 'executable-interpret)
    (define-key sh-mode-map (kbd "M-l") 'downcase-word)))


;; Good bye, arrow keys
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "C-<right>"))
(global-unset-key (kbd "C-<left>"))
(global-unset-key (kbd "C-<up>"))
(global-unset-key (kbd "C-<down>"))
(global-unset-key (kbd "M-<right>"))
(global-unset-key (kbd "M-<left>"))
(global-unset-key (kbd "M-<up>"))
(global-unset-key (kbd "M-<down>"))
(global-unset-key (kbd "<home>"))
(global-unset-key (kbd "<end>"))
(global-unset-key (kbd "<prior>"))
(global-unset-key (kbd "<next>"))
(global-unset-key (kbd "S-<insert>"))
(global-unset-key (kbd "<delete>"))
(global-unset-key (kbd "C-<delete>"))
(global-unset-key (kbd "M-<delete>"))
(global-unset-key (kbd "M-<backspace>"))
(global-unset-key (kbd "C-<backspace>"))


;; disable arrow keys in some modes
(dolist (local-mode-map
          '(minibuffer-local-completion-map
            minibuffer-local-filename-completion-map
            minibuffer-local-filename-must-match-map
            minibuffer-local-isearch-map
            minibuffer-local-map
            minibuffer-local-must-match-filename-map
            minibuffer-local-must-match-map
            minibuffer-local-ns-map
            w3m-mode-map))
  (let ((key-map (symbol-value local-mode-map)))
    (define-key key-map (kbd "<up>") nil)
    (define-key key-map (kbd "<down>") nil)
    (define-key key-map (kbd "<left>") nil)
    (define-key key-map (kbd "<right>") nil)))

;; make C-l do the right thing in various shells buffs
(dolist (mode-map
          '(inferior-emacs-lisp-mode-map
            slime-repl-mode-map
            comint-mode-map
            inf-ruby-mode-map))
  (let ((key-map (symbol-value mode-map)))
    (define-key key-map (kbd "C-l")
      (lambda ()
        (interactive)
        (goto-char (point-max))
        (recenter-top-bottom 0)))))

(global-unset-key (kbd "<f9>"))         ; do not f***ing pop Gnuplot
(global-unset-key (kbd "<f10>"))        ; do not f***ing open menu


(define-key global-map (kbd "M-g") 'goto-line)


(define-key global-map (kbd "M-0") 'delete-window)
(define-key global-map (kbd "M-1") 'delete-other-windows)
(define-key global-map (kbd "M-2") 'split-window-vertically)
(define-key global-map (kbd "M-3") 'split-window-horizontally)
(define-key global-map (kbd "M-4") 'kill-buffer-and-window)
(define-key global-map (kbd "M-5") 'my-change-split-type)
(define-key global-map (kbd "M-6") 'transpose-windows)
(define-key global-map (kbd "M-7") 'toggle-current-window-dedication)
(define-key global-map (kbd "M-=") 'balance-windows)


(defun my-switch-to-scratch ()
  (interactive)
  (let ((content initial-scratch-message)
        (buf "*scratch*"))
    (when (get-buffer buf)
      (setq content ""))
    (switch-to-buffer buf)
    (insert content)))

(define-key global-map (kbd "C-<f5>") 'my-switch-to-scratch) ; switch to *scratch*
(define-key global-map (kbd "C-<f6>")   ; switch to init.el
  (lambda ()
    (interactive)
    (find-file "~/.emacs.d/conf/init.el")))

(define-key global-map (kbd "C-x c")
  (lambda ()
    (interactive)
    (when (get-buffer "*Group*")
      (gnus-group-exit))
    (desktop-save-in-desktop-dir)
    (save-buffers-kill-emacs)))

;; do not ask to save gnus dribble file
;; TODO: convert to defadvice
(define-key global-map (kbd "C-x s")
  (lambda ()
    (interactive)
    (let ((buf (get-buffer "newsrc-dribble")))
      (when buf
        (with-current-buffer buf
          (save-buffer))))
    (call-interactively 'save-some-buffers)))


(define-key global-map (kbd "<mouse-2>") 'mouse-yank-primary)


;; window switching
(define-key global-map (kbd "C-<tab>")
  (lambda () (interactive) (select-window (next-window))))
(define-key global-map (kbd "C-S-<iso-lefttab>")
  (lambda () (interactive) (select-window (previous-window))))


;; window resizing
(define-key global-map (kbd "S-C-<left>") 'shrink-window-horizontally)
(define-key global-map (kbd "S-C-<right>") 'enlarge-window-horizontally)
(define-key global-map (kbd "S-C-<down>") 'shrink-window)
(define-key global-map (kbd "S-C-<up>") 'enlarge-window)


;; text scale
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)
(define-key global-map (kbd "C-=")
  (lambda () (interactive) (text-scale-set 0)))


(define-key global-map (kbd "C-c c") 'my-duplicate-line)
(define-key global-map (kbd "C-%") 'goto-match-paren)
(define-key global-map (kbd "C-x M-f") 'my-su-edit)

(define-key global-map (kbd "C-c j") 'dired-jump)

(eval-after-load "image-mode"
  '(define-key image-mode-map (kbd "q")
    (lambda () (interactive) (kill-buffer-ask (current-buffer)))))

(eval-after-load "arc-mode"
  '(define-key archive-mode-map (kbd "q")
    (lambda () (interactive) (kill-buffer-ask (current-buffer)))))

(eval-after-load "tar-mode"
  '(define-key tar-mode-map (kbd "q")
    (lambda () (interactive) (kill-buffer-ask (current-buffer)))))

(eval-after-load "conf-mode"
  ;; conflicts with project-root
  '(define-key conf-mode-map (kbd "C-c SPC") nil))

(define-key global-map (kbd "M-?") 'hippie-expand)

(define-key global-map (kbd "C-<f8>") 'multi-term)
(define-key global-map (kbd "<f8>") 'multi-term-next)

