;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(lisp-indent-function 'common-lisp-indent-function))

(add-to-list 'interpreter-mode-alist '("sbcl" . lisp-mode))

(define-key lisp-mode-shared-map (kbd "<return>") 'reindent-then-newline-and-indent)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)

(define-key emacs-lisp-mode-map (kbd "M-j") 'eval-print-last-sexp)
(define-key emacs-lisp-mode-map (kbd "M-.") 'find-symbol-at-point)
(define-key emacs-lisp-mode-map (kbd "M-;") 'comment-dwim)

(define-key emacs-lisp-mode-map (kbd "C-c t") 'ert)
(define-key lisp-interaction-mode-map (kbd "C-c t") 'ert)

(eval-after-load 'ert
  '(define-key ert-results-mode-map (kbd "C-c t") 'ert))

(define-key lisp-interaction-mode-map (kbd "M-j") 'eval-print-last-sexp)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key lisp-interaction-mode-map (kbd "M-.") 'find-symbol-at-point)

(eval-after-load 'ielm
  '(progn
    (setq ielm-header "")
    (add-hook 'inferior-emacs-lisp-mode-hook 'turn-on-eldoc-mode)
    (define-key inferior-emacs-lisp-mode-map (kbd "M-.") 'find-symbol-at-point)
    (define-key inferior-emacs-lisp-mode-map (kbd "C-c t") 'ert)))


(add-hook 'lisp-interaction-mode-hook (lambda () (setq mode-name "Lisp-int")))

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
            (add-hook 'before-save-hook
                      (lambda () (indent-region (point-min) (point-max)))
                      nil
                      'make-it-local)))

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
