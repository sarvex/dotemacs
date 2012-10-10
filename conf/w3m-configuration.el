(custom-set-variables
 '(w3m-default-display-inline-images nil)
 '(w3m-use-favicon t)
 '(w3m-use-cookies t)
 '(w3m-coding-system 'utf-8)
 '(w3m-file-coding-system 'utf-8)
 '(w3m-file-name-coding-system 'utf-8)
 '(w3m-input-coding-system 'utf-8)
 '(w3m-output-coding-system 'utf-8)
 '(w3m-terminal-coding-system 'utf-8))

(eval-after-load 'w3m
  '(progn

    (mapc
     (lambda (key)
       (define-key w3m-mode-map key nil))
     '([right] [left] [up] [down]))

    (add-hook 'w3m-display-hook
     (lambda (url)
       (rename-buffer
        (format "*%s - w3m*" (or w3m-current-title
                                 w3m-current-url)) t)))))
