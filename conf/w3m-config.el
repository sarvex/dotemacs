(setq browse-url-generic-program "/usr/bin/firefox"
      browse-url-browser-function 'choose-browser)

(defun choose-browser (url &rest args)
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (browse-url-generic url)
      (w3m-browse-url url)))

(define-key global-map (kbd "C-c f") 'browse-url-at-point)

(setq w3m-default-display-inline-images nil
      w3m-use-cookies t)

(setq w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)

(eval-after-load 'w3m
  '(progn

    (dolist (k '([right] [left] [up] [down]))
      (define-key w3m-mode-map k nil))

    (add-hook 'w3m-display-hook
     (lambda (url)
       (rename-buffer
        (format "*%s - w3m*" (or w3m-current-title
                                 w3m-current-url)) t)))))
