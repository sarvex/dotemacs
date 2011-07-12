(setq ahg-subprocess-coding-system 'utf-8
      ahg-global-key-prefix (kbd "C-c h g"))

(eval-after-load 'ahg
  '(progn

    (define-key ahg-status-mode-map (kbd "m") 'ahg-status-toggle-mark)
    (define-key ahg-status-mode-map (kbd "n") 'next-line)
    (define-key ahg-status-mode-map (kbd "p") 'previous-line)

    (define-key ahg-status-mode-map (kbd "P")
     (lambda () (interactive) (ahg-do-command "push")))

    (define-key ahg-status-mode-map (kbd "<backspace>")
     (lambda () (interactive) (save-excursion (ahg-status-unmark)) (forward-line -1)))

    ;; Works only this way for some reason
    (add-hook 'ahg-status-mode-hook
     (lambda () (define-key ahg-status-mode-map (kbd "<SPC>") 'next-line)))))
