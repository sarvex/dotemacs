;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(bookmark-default-file "~/.emacs.d/bookmarks")
 '(bookmark-old-default-file "~/.emacs.d/bookmarks")
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(bookmark-save-flag 1)
 '(bookmark-bmenu-file-column 52)
 '(bmkp-other-window-pop-to-flag nil)
 '(bmkp-bmenu-commands-file "~/.emacs.d/bmk-bmenu-commands.el")
 '(bmkp-bmenu-state-file "~/.emacs.d/bmk-bmenu-state.el")
 '(bmkp-bookmark-name-length-max 50))

(eval-after-load 'bookmark+
  '(require 'ffap))
