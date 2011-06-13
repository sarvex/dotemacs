;; Change cursor color according to mode; inspired by
;; http://www.emacswiki.org/emacs/ChangingCursorDynamically

;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar. HEIGHT); see the docs for set-cursor-type
(setq my-read-only-color       "#333333"
      my-read-only-cursor-type 'bar
      my-overwrite-color       "#BD4747"
      my-overwrite-cursor-type 'box
      my-normal-color          "#333333"
      my-normal-cursor-type    'box)

(defun my-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."
  (cond
    (buffer-read-only
     (set-cursor-color my-read-only-color)
     (setq cursor-type my-read-only-cursor-type))
    (overwrite-mode
     (set-cursor-color my-overwrite-color)
     (setq cursor-type my-overwrite-cursor-type))
    (t
     (set-cursor-color my-normal-color)
     (setq cursor-type my-normal-cursor-type))))

(add-hook 'post-command-hook 'my-set-cursor-according-to-mode)
