(setq save-abbrevs 'silently)
(setq anything-command-map-prefix-key "<f5>")

;; custom theme
(when (fboundp 'customize-themes)
  ;; (setq custom-theme-directory "~/.emacs.d/lisp/themes")
  ;; (load-theme 'quiet-light)
  ;; (enable-theme 'quiet-light)
  (load-file "~/.emacs.d/themes/quiet-light-theme.el"))
