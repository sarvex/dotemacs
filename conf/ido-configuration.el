;;; -*- lexical-binding: t -*-

(require 'ido)

(ido-mode t)
(ido-ubiquitous-mode t)

(add-hook 'ido-minibuffer-setup-hook
          (lambda ()
            "allow line wrapping in the minibuffer"
            (set (make-local-variable 'truncate-lines) nil)))

(add-hook 'ido-setup-hook
          (lambda ()
            "Set up key bindings for use for `ido-mode' completion"
            (mapc
             (lambda (key) (define-key ido-completion-map key nil))
             '([right] [left] [up] [down]))
            (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
            (define-key ido-completion-map (kbd "C-n") 'ido-next-match)))


(custom-set-variables
 '(ido-case-fold t)
 '(ido-save-directory-list-file (expand-file-name "~/.emacs.d/ido-history"))
 '(ido-completion-buffer nil)
 '(ido-confirm-unique-completion t)
 '(ido-create-new-buffer 'prompt)
 '(ido-default-buffer-method 'selected-window)
 '(ido-enable-flex-matching nil)
 '(ido-enable-last-directory-history t)
 '(ido-use-filename-at-point nil)
 '(ido-use-url-at-point nil)
 '(ido-ubiquitous-command-exceptions '(gnus-topic-move-group
                                       bookmark-set))
 '(ido-decorations '("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]"
                     " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
