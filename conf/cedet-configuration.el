(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb")

(unless (featurep 'cedet)
  (load-file "~/.emacs.d/el-get/cedet/common/cedet.el"))

(eval-after-load 'cedet
  '(progn
    (semantic-load-enable-code-helpers) ; basic stuff
    (semanticdb-toggle-global-mode)
    (which-function-mode t)
    (global-senator-minor-mode -1)

    (setq which-func-modes
     (append '(ruby-mode org-mode)
      which-func-modes))))



;; Speedbar

(setq speedbar-use-images t
      speedbar-track-mouse-flag nil
      speedbar-update-flag nil
      speedbar-show-unknown-files t
      speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|_darcs\\|\\.\\(git\\|hg\\|svn\\)\\)\\'")

(eval-after-load 'speedbar
  '(progn
    ;; some dired-like bindings
    (define-key speedbar-key-map (kbd ";") 'speedbar-up-directory)
    (define-key speedbar-key-map (kbd "f") 'speedbar-edit-line)))
