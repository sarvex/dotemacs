(custom-set-variables
 '(which-func-modes t)
 '(speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|_darcs\\|\\.\\(git\\|hg\\|svn\\|bzr\\)\\)\\'")
 '(speedbar-hide-button-brackets-flag nil)
 '(speedbar-indentation-width 2)
 '(speedbar-select-frame-method 1)
 '(speedbar-show-unknown-files t)
 '(speedbar-directory-button-trim-method 'trim)
 '(speedbar-tag-hierarchy-method nil)
 '(speedbar-tag-split-minimum-length 50)
 '(speedbar-track-mouse-flag nil)
 '(speedbar-update-flag nil)
 '(speedbar-use-images nil)
 '(speedbar-frame-parameters '((minibuffer . t)
                               (width . 20)
                               (border-width . 0)
                               (menu-bar-lines . 0)
                               (tool-bar-lines . 0)
                               (unsplittable . t)
                               (left-fringe . 0)
                               (right-fringe . 0))))

(eval-after-load 'speedbar
  '(progn
    (mapc
     (lambda (ext)
       (speedbar-add-supported-extension ext))
     '(".rb" ".z?sh" ".go"))

    (define-key speedbar-key-map (kbd ";") 'speedbar-up-directory)
    (define-key speedbar-key-map (kbd "f") 'speedbar-edit-line)))

(semantic-mode)
(which-function-mode)
