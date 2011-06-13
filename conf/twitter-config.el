(setq twittering-icon-mode t
      twittering-use-master-password t
      twittering-private-info-file (expand-file-name "~/.emacs.d/misc/twittering.gpg")
      twittering-auth-method 'xauth
      twittering-connection-type-order '(wget curl native))

(make-face 'my-twittering-username-face)
(make-face 'my-twittering-metainfo-face)

(setq twittering-status-format
      (concat
       "%i %FACE[my-twittering-username-face]{%s} (%S), %@:\n"
       "%FILL[ ]{%T}\n"
       "%FILL[  ]{%FACE[my-twittering-metainfo-face]{from %f%L%r%R}}\n"))


(defun my-twittering-mode-hook ()
  (visual-line-mode t))

(eval-after-load "twittering-mode"
  '(add-hook 'twittering-mode-hook 'my-twittering-mode-hook))
