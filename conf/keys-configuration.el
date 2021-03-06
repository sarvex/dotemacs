;;; -*- lexical-binding: t -*-

(define-key global-map (kbd "C-c ;") 'comment-or-uncomment-current-line-or-region)
(define-key global-map (kbd "C-c a") 'align)
(define-key global-map (kbd "C-c c") 'duplicate-line)
(define-key global-map (kbd "C-c g") 'magit-status)
(define-key global-map (kbd "C-c j") 'dired-jump)
(define-key global-map (kbd "C-c l") 'linum-mode)
(define-key global-map (kbd "C-c r") 'rake)
(define-key global-map (kbd "C-c s") 'ispell-word)
(define-key global-map (kbd "C-c w") 'whitespace-mode)

(define-key global-map (kbd "M-0") 'delete-window)
(define-key global-map (kbd "M-1") 'delete-other-windows)
(define-key global-map (kbd "M-2") 'split-window-vertically)
(define-key global-map (kbd "M-3") 'split-window-horizontally)
(define-key global-map (kbd "M-4") 'kill-buffer-and-window)
(define-key global-map (kbd "M-5") 'split-change-direction)
(define-key global-map (kbd "M-6") 'transpose-windows)
(define-key global-map (kbd "M-7") 'toggle-current-window-dedication)
(define-key global-map (kbd "M-=") 'balance-windows)

(define-key global-map (kbd "M-P") 'scroll-down-line)
(define-key global-map (kbd "M-N") 'scroll-up-line)

(define-key global-map (kbd "M-?") 'hippie-expand)

(define-key global-map (kbd "C-x C-b") 'ibuffer)

(define-key global-map (kbd "C-x C-d") 'ido-dired)

(define-key global-map (kbd "<f9>") 'recompile)

;; window switching
(define-key global-map (kbd "C-<tab>") 'other-window)
(define-key global-map (kbd "C-S-<iso-lefttab>") (lambda () (interactive) (other-window -1)))

;; window resizing
(define-key global-map (kbd "S-C-<left>") 'shrink-window-horizontally)
(define-key global-map (kbd "S-C-<right>") 'enlarge-window-horizontally)
(define-key global-map (kbd "S-C-<down>") 'shrink-window)
(define-key global-map (kbd "S-C-<up>") 'enlarge-window)

;; text scale
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)
(define-key global-map (kbd "C-=") (lambda () (interactive) (text-scale-set 0)))

;; Good bye, mouse buttons and arrow keys
(mapc
 (lambda (key)
   (global-unset-key key))
 '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
   [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
   [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
   [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
   [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]
   [right] [left] [up] [down] [home] [end] [prior] [next] [S-insert] [delete]
   [C-right] [C-left] [C-up] [C-down] [M-right] [M-left] [M-up] [M-down]
   [C-delete] [M-delete] [M-backspace] [C-backspace] [delete] [deletechar]))

;; disable arrow keys in minibuffer
(mapc
 (lambda (local-mode-map)
   (let ((key-map (symbol-value local-mode-map)))
     (mapc
      (lambda (key)
        (define-key key-map key nil))
      '([right] [left] [up] [down]))))
 '(minibuffer-local-completion-map
   minibuffer-local-filename-completion-map
   minibuffer-local-filename-must-match-map
   minibuffer-local-isearch-map
   minibuffer-local-map
   minibuffer-local-must-match-filename-map
   minibuffer-local-must-match-map
   minibuffer-local-ns-map))


(global-unset-key (kbd "<f10>"))        ; do not f***ing open menu
(global-unset-key (kbd "M-`"))          ; not even in text mode


(define-key global-map (kbd "C-x k")
  (lambda (&optional choose)
    (interactive "P")
    (if choose
        (call-interactively 'ido-kill-buffer)
      (kill-buffer (current-buffer)))))

(define-key global-map (kbd "C-x c") 'save-buffers-kill-emacs)

(define-key help-map "a"
  (let ((map (make-sparse-keymap)))
    (define-key map "a" 'apropos)
    (define-key map "c" 'apropos-command)
    (define-key map "d" 'apropos-documentation)
    (define-key map "l" 'apropos-library)
    (define-key map "v" 'apropos-variable)
    (define-key map "V" 'apropos-value)
    map))

(define-key global-map (kbd "C-c e")
  (let ((map (make-sparse-keymap)))
    (define-key map "b" 'eval-buffer)
    (define-key map "d" 'eval-defun)
    (define-key map "r" 'eval-region)
    (define-key map "f" 'find-function)
    (define-key map "k" 'find-function-on-key)
    (define-key map "l" 'find-library)
    (define-key map "v" 'find-variable)
    (define-key map "C" 'emacs-lisp-byte-compile)
    (define-key map "c" 'emacs-lisp-byte-compile-and-load)
    (define-key map "e" 'toggle-debug-on-error)
    (define-key map "q" 'toggle-debug-on-quit)
    (define-key map "E" 'macrostep-expand)
    (define-key map "m" 'make-elisp-library)
    (define-key map "t" 'ert)
    (define-key map "s" (lambda () (interactive) (switch-to-buffer "*scratch*")))
    map))

(define-key global-map (kbd "C-c m")
  (let ((map (make-sparse-keymap)))
    (define-key map "s" 'kmacro-start-macro-or-insert-counter)
    (define-key map "x" 'kmacro-end-or-call-macro)
    (define-key map "e" 'kmacro-edit-macro)
    (define-key map "E" 'kmacro-edit-lossage)
    (define-key map "?" 'kmacro-view-macro)
    (define-key map "n" 'kmacro-name-last-macro)
    (define-key map "c" 'kmacro-set-counter)
    (define-key map "f" 'kmacro-set-format)
    (define-key map "d" 'kmacro-delete-ring-head)
    (define-key map "b" 'kmacro-bind-to-key)
    (define-key map " " 'kmacro-step-edit-macro)
    (define-key map "i" 'insert-kbd-macro)
    (define-key map "q" 'kbd-macro-query)
    (define-key map (kbd "C-n") 'kmacro-cycle-ring-next)
    (define-key map (kbd "C-p") 'kmacro-cycle-ring-previous)
    (define-key map "l" 'apply-macro-to-region-lines)
    map))

(define-key global-map (kbd "C-c <tab>")
  (let ((map (make-sparse-keymap)))
    (define-key map "d" 'switch-to-dired-buffer)
    (define-key map "i" 'switch-to-irc-buffer)
    (define-key map "t" 'switch-to-twitter-buffer)
    (define-key map "g" 'switch-to-magit-buffer)
    (define-key map "b" 'switch-to-bookmark-file)
    map))

(define-key global-map (kbd "C-x g")
  (lambda (arg)
    (interactive "P")
    (let ((gnus-buffer (get-buffer "*Group*")))
      (when gnus-buffer
        (switch-to-buffer gnus-buffer))
      (when (or arg (not gnus-buffer))
        (gnus)))))

(define-key global-map (kbd "C-w") 'backward-kill-word)
(define-key global-map (kbd "C-x C-k") 'kill-region)

(define-key global-map (kbd "M-w")
  (lambda ()
    (interactive)
    (if (region-active-p)
        (call-interactively 'kill-ring-save)
      (kill-ring-save
       (line-beginning-position)
       (line-beginning-position 2))
      (message "Copied line"))))

(define-key global-map (kbd "C-x C-k")
  (lambda ()
    (interactive)
    (if (region-active-p)
        (call-interactively 'kill-region)
      (kill-region
       (line-beginning-position)
       (line-beginning-position 2))
      (message "Killed line"))))

(define-key global-map (kbd "C-c d") 'drag-stuff-mode)
(define-key global-map (kbd "C-;") 'iedit-mode)
(define-key global-map (kbd "<f7>")
  (lambda (&optional arg)
    (interactive "P")
    (let ((current-prefix-arg (not arg)))
      (scratch))))

(define-key global-map (kbd "C-x C-f")
  (defun my-find-file (&optional arg)
    (interactive "P")
    (if arg
        (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "Find file (using sudo): ")))
      (ido-find-file))))
