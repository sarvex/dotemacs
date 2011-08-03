(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb")

(unless (featurep 'cedet)
  (load-file "~/.emacs.d/el-get/cedet/common/cedet.el"))

(eval-after-load 'cedet
  '(progn
    (semantic-load-enable-code-helpers) ; basic stuff
    (which-function-mode t)
    (global-senator-minor-mode -1)

    (setq which-func-modes
     (append '(ruby-mode org-mode)
      which-func-modes))))

(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
             (when (listp symbol-list)
               (dolist (symbol symbol-list)
                 (let ((name nil) (position nil))
                   (cond
                     ((and (listp symbol) (imenu--subalist-p symbol))
                      (addsymbols symbol))
                     ((listp symbol)
                      (setq name (car symbol))
                      (setq position (cdr symbol)))
                     ((stringp symbol)
                      (setq name symbol)
                      (setq position (get-text-property 1 'org-imenu-marker symbol))))
                   (unless (or (null position) (null name))
                     (add-to-list 'symbol-names name)
                     (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))


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