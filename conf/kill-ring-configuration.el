(setq delete-active-region 'kill)

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list
        (region-beginning)
        (region-end))
       (message "Copied line")
       (list
        (line-beginning-position)
        (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active
       (list
        (region-beginning)
        (region-end))
       (message "Killed line")
       (list
        (line-beginning-position)
        (line-beginning-position 2)))))

(define-key global-map (kbd "C-w") 'backward-kill-word)
(define-key global-map (kbd "C-x C-k") 'kill-region)
