(require 'ielm)
(setq ielm-header "")
;;================================================================
(defun pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(?\\(lambda\\>\\)"
          (0 (progn
               (compose-region (match-beginning 1)
                               (match-end 1)
                               ,(make-char 'greek-iso8859-7 107))
               nil))))))

(dolist (mode-hook '(emacs-lisp-mode-hook
                     clojure-mode-hook
                     lisp-mode-hook
                     scheme-mode-hook
                     lisp-interaction-mode-hook
                     ;; slime-repl-mode-hook
                     ielm-mode-hook))
  (add-hook mode-hook (lambda ()
                        (pretty-lambdas))))
;;================================================================

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq mode-name "eLisp")))

(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (setq mode-name "Lisp-int")))

(add-to-list 'interpreter-mode-alist '("sbcl" . lisp-mode))

;;
;; Keys
;;
(define-key emacs-lisp-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
(define-key lisp-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
(define-key lisp-interaction-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)

(define-key emacs-lisp-mode-map (kbd "M-;") 'comment-dwim)


(define-key emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)
(define-key inferior-emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)
(define-key lisp-interaction-mode-map (kbd "M-.") 'find-function-at-point)

(define-key lisp-interaction-mode-map (kbd "C-c j") 'eval-print-last-sexp)

(defun my-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

(add-hook 'emacs-lisp-mode-hook 'my-remove-elc-on-save)

(defun my-eldoc-init-hook ()
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'my-eldoc-init-hook)
(add-hook 'inferior-emacs-lisp-mode-hook 'my-eldoc-init-hook)

(add-hook 'before-save-hook
          (lambda ()
            (when (member major-mode '(lisp-mode
                                       emacs-lisp-mode
                                       lisp-interaction-mode))
              (indent-region (point-min) (point-max)))))

