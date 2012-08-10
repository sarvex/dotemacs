(setq js-indent-level 4)

(add-to-list 'interpreter-mode-alist '("node" . js-mode))

(setq coffee-cleanup-whitespace t
      coffee-js-mode 'js-mode
      coffee-tab-width 2)

(defun coffee-compile-dwim ()
  (interactive)
  (cond
    ((region-active-p)
     (call-interactively 'coffee-compile-region))
    ((buffer-file-name)
     (coffee-compile-file))
    (t
     (coffee-compile-buffer))))

(eval-after-load 'coffee-mode
  '(define-key coffee-mode-map (kbd "<f9>") 'coffee-compile-dwim))


(defun flymake-jslint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name)))
         (jslint (expand-file-name "~/.emacs.d/dotemacs/scripts/jslint-wrapper")))
    (list jslint (list local-file))))

(defun flymake-jshint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name)))
         (arglist (list local-file))
         (config (expand-file-name "~/.jshint-config.json")))
    (when (file-regular-p config)
      (setq arglist (append arglist (list "--config" config))))
    (list "jshint" arglist)))

(defun turn-on-jslint-flymake ()
  (setq flymake-err-line-patterns
        (cons '("^[[:space:]]+#[[:digit:]]+ \\(.+\\)I BLAME BOTH FLYMAKE AND JSLINT.+// Line \\([[:digit:]]+\\), Pos \\([[:digit:]]+\\)$"
                nil 2 3 1)
              flymake-err-line-patterns))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.js\\(on\\)?\\'" flymake-jslint-init)))

(defun turn-on-jshint-flymake ()
  (setq flymake-err-line-patterns
        (cons '(".*: line \\([[:digit:]]+\\), col \\([[:digit:]]+\\), \\(.*\\)$"
                nil 1 2 3)
              flymake-err-line-patterns))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.js\\(on\\)?\\'" flymake-jshint-init)))


(eval-after-load 'js
  '(progn
    (require 'flymake)
    (turn-on-jshint-flymake)
    (define-key js-mode-map (kbd "<return>") 'reindent-then-newline-and-indent)
    (define-key js-mode-map (kbd "C-c e") 'flymake-display-err-menu-for-current-line)
    (add-hook 'js-mode-hook 'turn-on-flymake-mode)))
