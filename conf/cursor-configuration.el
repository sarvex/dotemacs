;; -*- eval: (rainbow-mode 1) -*-

;; http://www.emacswiki.org/emacs/ChangingCursorDynamically

;; valid values for `cursor-type' are t, nil, box, hollow, bar, (bar . WIDTH),
;; hbar, (hbar. HEIGHT); see the docs for set-cursor-type

(defun change-cursor-appropriately-to-circumstances ()
  "Change cursor color and type depending on circumstances."
  (let ((normal-color    "#333333")
        (overwrite-color "#BD4747")
        (read-only-color "#333333")
        (normal-cursor-type    'box)
        (overwrite-cursor-type 'box)
        (read-only-cursor-type 'bar))
    (cond
      (buffer-read-only
       (set-cursor-color read-only-color)
       (setq cursor-type read-only-cursor-type))
      (overwrite-mode
       (set-cursor-color overwrite-color)
       (setq cursor-type overwrite-cursor-type))
      (t
       (set-cursor-color normal-color)
       (setq cursor-type normal-cursor-type)))))

(add-hook 'post-command-hook 'change-cursor-appropriately-to-circumstances)
