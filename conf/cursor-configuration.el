;;; -*- lexical-binding: t -*-

;; http://www.emacswiki.org/emacs/ChangingCursorDynamically

;; valid values for `cursor-type' are t, nil, box, hollow, bar, (bar . WIDTH),
;; hbar, (hbar. HEIGHT); see the docs for `cursor-type'

(add-hook 'post-command-hook
          #'(lambda ()
              "Change cursor color and type depending on circumstances."
              (setq cursor-type (if buffer-read-only 'bar 'box))
              (set-cursor-color
               (cond ((region-active-p) "#3c5f8d")
                     ((and overwrite-mode (not buffer-read-only)) "#bd4747")
                     (t "#333333")))))
