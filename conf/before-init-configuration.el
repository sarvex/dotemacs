(setq save-abbrevs 'silently)

;; custom theme
(when (fboundp 'customize-themes)
  ;; (setq custom-theme-directory "~/.emacs.d/themes")
  ;; (load-theme 'quiet-light)
  ;; (enable-theme 'quiet-light)
  (load-file "~/.emacs.d/themes/quiet-light-theme.el"))

(load "misc/temporary-stuff")
(load "misc/passwords.el.gpg")            ; load passwords
