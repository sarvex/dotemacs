(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb")

(add-to-list 'load-path "~/.emacs.d/el-get/cedet")

(unless (featurep 'cedet)
  (require 'cedet-devel-load))

(eval-after-load 'cedet
  '(progn
    (semantic-load-enable-code-helpers) ; basic stuff
    (which-function-mode t)

    (setq which-func-modes
     (append '(ruby-mode org-mode)
      which-func-modes))))

;; Speedbar

(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|_darcs\\|\\.\\(git\\|hg\\|svn\\)\\)\\'"
      speedbar-hide-button-brackets-flag nil
      speedbar-indentation-width 2
      speedbar-show-unknown-files t
      speedbar-directory-button-trim-method 'trim
      speedbar-tag-hierarchy-method nil
      speedbar-tag-split-minimum-length 50
      speedbar-track-mouse-flag nil
      speedbar-update-flag nil
      speedbar-use-images t
      speedbar-update-flag t)


(setq speedbar-visiting-tag-hook
      '(speedbar-highlight-one-tag-line
        speedbar-recenter
        (lambda ()
          (and
           (derived-mode-p 'org-mode)
           (org-show-context 'org-goto)))
        speedbar-highlight-one-tag-line))

(setq speedbar-frame-parameters
      '((minibuffer . t)
        (width . 20)
        (border-width . 0)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (unsplittable . t)
        (left-fringe . 0)))

(eval-after-load 'speedbar
  '(progn
    (add-to-list 'speedbar-supported-extension-expressions ".rb")
    ;; some dired-like bindings
    (define-key speedbar-key-map (kbd ";") 'speedbar-up-directory)
    (define-key speedbar-key-map (kbd "f") 'speedbar-edit-line)))
