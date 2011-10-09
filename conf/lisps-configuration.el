(add-to-list 'interpreter-mode-alist '("sbcl" . lisp-mode))

(setq ielm-header "")

(define-key lisp-mode-shared-map (kbd "<return>") 'reindent-then-newline-and-indent)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)

(define-key emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)
(define-key emacs-lisp-mode-map (kbd "M-;") 'comment-dwim)

(define-key lisp-interaction-mode-map (kbd "C-c j") 'eval-print-last-sexp)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key lisp-interaction-mode-map (kbd "M-.") 'find-function-at-point)

(eval-after-load 'ielm
  '(progn
    (define-key inferior-emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)
    (define-key inferior-emacs-lisp-mode-map (kbd "C-l") 'recenter-top)))


;; hooks

(add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name "eLisp")))

(add-hook 'lisp-interaction-mode-hook (lambda () (setq mode-name "Lisp-int")))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (add-hook 'after-save-hook
                      (lambda ()
                        "If you're saving an elisp file, likely the .elc is no longer valid."
                        (let ((bytecode  (concat buffer-file-name "c")))
                          (when (file-exists-p bytecode)
                            (delete-file bytecode))))
                      nil
                      'make-it-local)))

(add-hook 'before-save-hook
          (lambda ()
            (when (member major-mode '(lisp-mode
                                       emacs-lisp-mode
                                       scheme-mode
                                       lisp-interaction-mode))
              (indent-region (point-min) (point-max)))))

(dolist (mode-hook '(emacs-lisp-mode-hook
                     lisp-mode-hook
                     scheme-mode-hook
                     inferior-scheme-mode-hook
                     lisp-interaction-mode-hook
                     ;; slime-repl-mode-hook
                     ielm-mode-hook))
  (add-hook mode-hook
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

;; paredit for all lisp modes
(dolist (mode-hook '(emacs-lisp-mode-hook
                     clojure-mode-hook
                     scheme-mode-hook
                     inferior-scheme-mode-hook
                     lisp-mode-hook
                     lisp-interaction-mode-hook
                     slime-repl-mode-hook
                     ielm-mode-hook))
  (add-hook mode-hook (lambda () (paredit-mode t))))


;; scheme

(setq scheme-program-name "mzscheme"
      quack-remap-find-file-bindings-p nil)

(eval-after-load 'scheme
  '(require 'quack))
