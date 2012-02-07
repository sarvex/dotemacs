(setq twittering-auth-method 'xauth
      twittering-connection-type-order '(curl wget native)
      twittering-icon-mode t
      twittering-private-info-file (expand-file-name "~/.emacs.d/dotemacs/misc/twittering.gpg")
      twittering-timer-interval 150
      twittering-use-master-password t)

(make-face 'my-twittering-username-face)
(make-face 'my-twittering-metainfo-face)

(setq twittering-status-format
      (concat
       "%i %FACE[my-twittering-username-face]{%s} (%S), %@:\n"
       "%FILL[ ]{%T}\n"
       "%FILL[  ]{%FACE[my-twittering-metainfo-face]{from %f%L%r%R}}"))

(eval-after-load 'twittering-mode
  '(progn
    (add-hook 'twittering-mode-hook 'turn-on-visual-line-mode)
    (add-hook 'twittering-edit-mode-hook 'turn-on-visual-line-mode)
    (define-key twittering-mode-map (kbd "RET") 'twittering-click)
    (define-key twittering-mode-map (kbd "R") 'twittering-enter)))
