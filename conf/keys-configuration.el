(define-key global-map (kbd "C-c ;") 'comment-or-uncomment-current-line-or-region)

;; disable arrow keys in minibuffer
(dolist (local-mode-map
          '(minibuffer-local-completion-map
            minibuffer-local-filename-completion-map
            minibuffer-local-filename-must-match-map
            minibuffer-local-isearch-map
            minibuffer-local-map
            minibuffer-local-must-match-filename-map
            minibuffer-local-must-match-map
            minibuffer-local-ns-map))
  (let ((key-map (symbol-value local-mode-map)))
    (dolist (k '([right] [left] [up] [down]))
      (define-key key-map k nil))))


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


(define-key global-map (kbd "C-<f5>")   ; switch to *scratch*
  (lambda ()
    (interactive)
    (let ((content initial-scratch-message)
          (buf "*scratch*"))
      (when (get-buffer buf)
        (setq content ""))
      (switch-to-buffer buf)
      (insert content))))

(define-key global-map (kbd "C-<f6>")   ; switch to init.el
  (lambda ()
    (interactive)
    (find-file "~/.emacs.d/dotemacs/conf/init.el")))

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

;; Good bye, mouse buttons and arrow keys
(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]
             [right] [left] [up] [down] [home] [end] [prior] [next] [S-insert] [delete]
             [C-right] [C-left] [C-up] [C-down] [M-right] [M-left] [M-up] [M-down]
             [C-delete] [M-delete] [M-backspace] [C-backspace]))
  (global-unset-key k))


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

(define-key global-map (kbd "M-?") 'hippie-expand)

(define-key global-map (kbd "C-<f8>") 'multi-term)
(define-key global-map (kbd "<f8>") 'multi-term-next)

(define-key help-map "a" 'apropos)

(define-key global-map (kbd "C-c f") 'browse-url-at-point)

(define-key global-map (kbd "C-c l") 'linum-mode)
