(setq bookmark-default-file "~/.emacs.d/bookmarks"
      bookmark-old-default-file "~/.emacs.d/bookmarks"
      bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks"
      bookmark-save-flag 1
      bookmark-bmenu-file-column 52)

(setq bmkp-other-window-pop-to-flag nil
      bmkp-bmenu-commands-file "~/.emacs.d/bmk-bmenu-commands.el"
      bmkp-bmenu-state-file "~/.emacs.d/bmk-bmenu-state.el"
      bmkp-bookmark-name-length-max 50)

(defun bookmarks/diredp-help ()
  (let ((bn "*dired+ help*"))
    (if (get-buffer bn)
        (switch-to-buffer bn)
        (diredp-dired-plus-help)
        (switch-to-buffer "*Help*")
        (rename-buffer bn))
    (delete-other-windows)))

(defun bookmarks/jump-to-info (buffer-name)
  (if (not (get-buffer buffer-name))
      (rename-buffer buffer-name)
      (kill-buffer "*info*")
      (switch-to-buffer buffer-name)))
