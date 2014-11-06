;;; -*- lexical-binding: t -*-

(add-to-list 'interpreter-mode-alist '("sbcl" . lisp-mode))

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)

(define-key emacs-lisp-mode-map (kbd "M-j") 'eval-print-last-sexp)
(define-key emacs-lisp-mode-map (kbd "M-.") 'find-symbol-at-point)
(define-key emacs-lisp-mode-map (kbd "M-;") 'comment-dwim)

(define-key lisp-interaction-mode-map (kbd "M-j") 'eval-print-last-sexp)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key lisp-interaction-mode-map (kbd "M-.") 'find-symbol-at-point)

(with-eval-after-load 'ielm
  (setq ielm-header "")

  (add-hook 'inferior-emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'inferior-emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'inferior-emacs-lisp-mode-hook (lambda () (auto-complete-mode 1)))
  (add-hook 'inferior-emacs-lisp-mode-hook
            (lambda ()
              (mapc
               (lambda (src) (add-to-list 'ac-sources src))
               '(ac-source-functions
                 ac-source-variables
                 ac-source-features
                 ac-source-symbols))))

  (define-key inferior-emacs-lisp-mode-map (kbd "M-.") 'find-symbol-at-point))


(add-hook 'lisp-interaction-mode-hook (lambda () (setq mode-name "ξlisp-int")))

(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'emacs-lisp-mode-hook 'lexbind-mode)
(add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name "ξlisp")))
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            "Delete corresponding bytecode and check if parens are balanced."
            (add-hook 'after-save-hook
                      (lambda ()
                        "If you're saving an elisp file, likely the .elc is no longer valid."
                        (let ((bytecode (concat buffer-file-name "c")))
                          (when (file-exists-p bytecode)
                            (delete-file bytecode))))
                      nil
                      'make-it-local)
            (add-hook 'after-save-hook 'check-parens nil 'make-it-local)))

(add-hook 'lisp-mode-hook
          (lambda ()
            (set (make-local-variable lisp-indent-function)
                 'common-lisp-indent-function)
            (add-hook 'after-save-hook 'check-parens nil 'make-it-local)))


(custom-set-variables
 '(scheme-program-name "mzscheme"))
