;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error nil)
 '(compilation-disable-input t)
 '(compilation-read-command nil)
 '(compilation-window-height 20)
 '(compilation-scroll-output 'first-error)
 )

(add-hook 'compilation-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'compilation-filter-hook
          (defun colorize-compilation-buffer ()
            (let ((inhibit-read-only t))
              (ansi-color-apply-on-region (point-min) (point-max)))))

(with-eval-after-load 'compile
  (define-key compilation-mode-map (kbd "f") 'ffap)

  (add-to-list 'compilation-error-regexp-alist 'haskell-doctest)
  (add-to-list 'compilation-error-regexp-alist-alist
               (list 'haskell-doctest
                     (rx line-start
                         "### Failure in "
                         (group (+ not-newline) "." (optional "l") "hs") ; file name
                         ":"
                         (group (+ (char digit)))                        ; line number
                         ":")
                     1 2))

  (add-to-list 'compilation-error-regexp-alist 'rust-test)
  (add-to-list 'compilation-error-regexp-alist-alist
               (list 'rust-test
                     (rx line-start
                         "\ttask '"
                         (*? anything)
                         "' failed at '"
                         (*? anything)
                         "', "
                         (group (+ not-newline) ".rs") ; file name
                         ":"
                         (group (+ (char digit)))      ; line number
                         line-end)
                     1 2))
  )
