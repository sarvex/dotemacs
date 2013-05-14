;;; -*- lexical-binding: t -*-

(add-to-list 'interpreter-mode-alist '("sbcl" . lisp-mode))

(define-key lisp-mode-shared-map (kbd "<return>") 'reindent-then-newline-and-indent)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)

(define-key emacs-lisp-mode-map (kbd "M-j") 'eval-print-last-sexp)
(define-key emacs-lisp-mode-map (kbd "M-.") 'find-symbol-at-point)
(define-key emacs-lisp-mode-map (kbd "M-;") 'comment-dwim)

(define-key lisp-interaction-mode-map (kbd "M-j") 'eval-print-last-sexp)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key lisp-interaction-mode-map (kbd "M-.") 'find-symbol-at-point)

(eval-after-load 'ielm
  '(progn
    (setq ielm-header "")

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

    (define-key inferior-emacs-lisp-mode-map (kbd "M-.") 'find-symbol-at-point)))


(add-hook 'lisp-interaction-mode-hook (lambda () (setq mode-name "Lisp-int")))

(add-hook 'emacs-lisp-mode-hook 'lexbind-mode)
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

(mapc
 (lambda (hooks)
   (add-hook hooks
             (lambda ()
               "Display pretty lambdas in lisp modes"
               (font-lock-add-keywords
                nil
                `(("(?\\(lambda\\>\\)"
                   (0 (progn
                        (compose-region
                         (match-beginning 1)
                         (match-end 1)
                         ,(make-char 'greek-iso8859-7 107))
                        nil))))))))
 '(emacs-lisp-mode-hook
   lisp-mode-hook
   inferior-scheme-mode-hook
   lisp-interaction-mode-hook
   ielm-mode-hook))


(custom-set-variables
 '(scheme-program-name "mzscheme")
 '(quack-remap-find-file-bindings-p nil)
 '(quack-fontify-style 'emacs))

(eval-after-load 'scheme
  '(require 'quack))
