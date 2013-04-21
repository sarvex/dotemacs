;;; -*- lexical-binding: t -*-

(require 'ido)

(custom-set-variables
 '(ido-case-fold t)
 '(ido-save-directory-list-file "~/.emacs.d/ido-history")
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

(defun ido-find-file-in-work-directory-list ()
  "Find file starting at directory selected from `ido-find-file-in-work-directory-list'."
  (interactive)
  (let* ((candidates (mapcar 'abbreviate-file-name ido-work-directory-list))
         (default-directory (ido-completing-read "Directory: " candidates)))
    (call-interactively 'ido-find-file)))

(define-key global-map (kbd "C-x C-d") 'ido-find-file-in-work-directory-list)

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (or (not buffer-file-name)
              (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


(ido-mode t)
(ido-ubiquitous-mode t)
