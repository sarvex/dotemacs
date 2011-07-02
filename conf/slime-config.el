(setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/HyperSpec/"
      inferior-lisp-program "/usr/bin/sbcl --noinform"
      lisp-indent-function 'common-lisp-indent-function
      slime-autodoc-use-multiline-p t
      slime-header-line-p nil
      slime-net-coding-system 'utf-8-unix
      slime-repl-history-file "~/.emacs.d/slime-history.eld"
      slime-repl-history-remove-duplicates t
      slime-repl-history-size 2000
      slime-repl-history-trim-whitespaces t
      slime-startup-animation nil
      slime-truncate-lines nil)

(require 'slime-autoloads)

(slime-setup '(slime-fancy))


(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

(add-hook 'lisp-mode-hook
          (lambda () (slime-mode t)))

(add-hook 'inferior-lisp-mode-hook
          (lambda () (inferior-slime-mode t)))

(setq slime-lisp-implementations
      '((sbcl ("/usr/bin/sbcl"  "--noinform") :coding-system utf-8-unix)))

;;
;; Fontify *SLIME Description* buffer for SBCL
;;
(defun slime-description-fontify ()
  "Fontify sections of SLIME Description."
  (with-current-buffer "*SLIME Description <sbcl>*"
    (highlight-regexp
     (concat "^Function:\\|"
             "^Macro-function:\\|"
             "^Its associated name.+?) is\\|"
             "^The .+'s arguments are:\\|"
             "^Function documentation:$\\|"
             "^Its.+\\(is\\|are\\):\\|"
             "^On.+it was compiled from:$")
     'hi-green-b)))

(defadvice slime-show-description
    (after slime-description-fontify activate)
  "Fontify sections of SLIME Description."
  (slime-description-fontify))
;;
;; Improve usability of slime-apropos: slime-apropos-minor-mode
;;
(defvar slime-apropos-anchor-regexp "^[^ ]")
(defun slime-apropos-next-anchor ()
  (interactive)
  (let ((pt (point)))
    (forward-line 1)
    (if (re-search-forward slime-apropos-anchor-regexp nil t)
        (goto-char (match-beginning 0))
        (goto-char pt)
        (error "anchor not found"))))

(defun slime-apropos-prev-anchor ()
  (interactive)
  (let ((p (point)))
    (if (re-search-backward slime-apropos-anchor-regexp nil t)
        (goto-char (match-beginning 0))
        (goto-char p)
        (error "anchor not found"))))

(defvar slime-apropos-minor-mode-map (make-sparse-keymap))

(define-key slime-apropos-minor-mode-map "\C-m" 'slime-describe-symbol)
(define-key slime-apropos-minor-mode-map "l" 'slime-describe-symbol)
(define-key slime-apropos-minor-mode-map "j" 'slime-apropos-next-anchor)
(define-key slime-apropos-minor-mode-map "k" 'slime-apropos-prev-anchor)

(define-minor-mode slime-apropos-minor-mode "")

(defadvice slime-show-apropos (after slime-apropos-minor-mode activate)
  (when (get-buffer "*SLIME Apropos*")
    (with-current-buffer "*SLIME Apropos*" (slime-apropos-minor-mode 1))))
