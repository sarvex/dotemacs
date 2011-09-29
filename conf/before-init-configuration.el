(setq save-abbrevs 'silently)

;; custom theme
(when (fboundp 'customize-themes)
  ;; (setq custom-theme-directory "~/.emacs.d/themes")
  ;; (load-theme 'quiet-light)
  ;; (enable-theme 'quiet-light)
  (load-file "~/.emacs.d/themes/quiet-light-theme.el"))

(load "dotemacs/misc/temporary-stuff")
(load "dotemacs/misc/passwords.el.gpg") ; load passwords
