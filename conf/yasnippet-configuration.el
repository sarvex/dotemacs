;;; -*- lexical-binding: t -*-

(require 'popup)

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (popup-menu*
   (mapcar
    (lambda (choice)
      (popup-make-item
       (or (and display-fn (funcall display-fn choice))
           choice)
       :value choice))
    choices)
   :prompt prompt
   :isearch t))

(custom-set-variables
 '(yas-also-auto-indent-first-line nil)
 '(yas-good-grace nil)
 '(yas-choose-tables-first t)
 '(yas-snippet-dirs '("~/.emacs.d/yasnippets"))
 '(yas-prompt-functions '(yas-popup-isearch-prompt
                          yas-ido-prompt
                          yas-x-prompt
                          yas-completing-prompt
                          yas-no-prompt)))

(add-hook 'prog-mode-hook 'yas-minor-mode-on)

(add-to-list 'auto-mode-alist '("\\.yasnippet\\'" . snippet-mode))

(defun yas-activate-if-extension (mode file-name &rest exts)
  (when (and file-name
             (string-match-p
              (rx-to-string `(and not-newline "." (eval (list 'or ,@exts)) string-end))
              file-name))
    (yas-activate-extra-mode mode)))

(defun yas-activate-extra-modes-based-on-file-name ()
  (yas-activate-if-extension 'handlebars-mode buffer-file-name "hbs" "handlebars")
  (yas-activate-if-extension 'rhtml-mode buffer-file-name "rhtml" "html.erb"))

(eval-after-load 'yasnippet
  (quote
   (progn

     (add-hook 'yas-minor-mode-hook 'yas-activate-extra-modes-based-on-file-name)

     (add-hook 'snippet-mode-hook
               (lambda ()
                 (setq require-final-newline nil)
                 (add-hook 'after-save-hook 'yas-recompile-all 'append 'make-it-local)
                 (add-hook 'after-save-hook 'yas-reload-all 'append 'make-it-local)))

     )))
