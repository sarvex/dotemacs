;; (require 'bookmark)

(setq bookmark-default-file "~/.emacs.d/emacs.bmk"
      bookmark-old-default-file "~/.emacs.d/emacs.bmk"
      bookmark-save-flag 1
      bookmark-bmenu-file-column 52)

(setq bmkp-other-window-pop-to-flag nil
      bmkp-bmenu-commands-file "~/.emacs.d/bmk-bmenu-commands.el"
      bmkp-bmenu-state-file "~/.emacs.d/bmk-bmenu-state.el"
      bmkp-bookmark-name-length-max 50)

(defun bookmarks/diredp-help ()
  (let ((bn "*dired+ help*"))
    (if (get-buffer bn)
        (pop-to-buffer-same-window bn)
        (diredp-dired-plus-help)
        (pop-to-buffer-same-window "*Help*")
        (rename-buffer bn))
    (delete-other-windows)))
