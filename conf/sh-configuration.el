;;; -*- lexical-binding: t -*-

(add-to-list 'auto-mode-alist (cons
                               (rx (or (and ".zsh" (optional "-theme"))
                                       (and ".env" (optional ".example")))
                                   string-end)
                               'sh-mode))

(custom-set-variables
 '(sh-basic-offset 2))

(eval-after-load 'sh-script
  '(progn
     (define-key sh-mode-map (kbd "M-l") nil)
     (define-key sh-mode-map (kbd "<f9>") 'executable-interpret)))
