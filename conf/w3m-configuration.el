(setq w3m-default-display-inline-images nil
      w3m-use-favicon t
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
