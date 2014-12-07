;;; -*- lexical-binding: t -*-

(smartparens-global-mode)
(show-smartparens-global-mode)

(require 'smartparens-config)

(with-eval-after-load 'rust
  (defun sp--rust-after-colon-p (id action context)
    (looking-back (rx-to-string '(and "::" (eval id)))
                  (+ 2 (length id))))

  (defun sp--rust-after-ampersand-p (id action context)
    (looking-back (rx-to-string '(and "&" (eval id)))
                  (+ 1 (length id))))

  (defun sp--rust-after-opening-angle-bracket-p (id action context)
    (looking-back (rx-to-string '(and "<" (eval id)))
                  (+ 1 (length id))))

  (sp-local-pair 'rust-mode "<" ">"
                 :unless '(sp-point-in-string)
                 :when '(sp--rust-after-colon-p
                         sp-point-after-word-p))

  (sp-local-pair 'rust-mode "'" nil
                 :unless '(:add
                           sp--rust-after-ampersand-p
                           sp--rust-after-opening-angle-bracket-p)))

(mapc
 (lambda (mode)
   (add-to-list 'sp-ignore-modes-list mode))
 '(
   twittering-mode
   term-mode
   ))

(defadvice wdired-finish-edit (before dired-turn-smartparens-mode-off activate)
  "Turn off `smartparens-mode' when switching from `wdired-mode' to `dired-mode'."
  (smartparens-mode -1))
