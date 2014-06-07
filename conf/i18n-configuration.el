;;; -*- lexical-binding: t -*-

(set-clipboard-coding-system 'utf-8)

(set-default-coding-systems 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(prefer-coding-system 'cp866)
(prefer-coding-system 'koi8-r-unix)
(prefer-coding-system 'koi8-u-unix)
(prefer-coding-system 'windows-1251-dos)
(prefer-coding-system 'utf-8)

(add-to-list 'file-coding-system-alist '("\\.rb\\'" utf-8 . utf-8))
(add-to-list 'file-coding-system-alist '("\\.go\\'" utf-8 . utf-8))


(defun toggle-specified-isearch-input-method (new-input-method)
  "Toggle specified input method in interactive search."
  (interactive)
  (let ((overriding-terminal-local-map nil)))

  (if (eq new-input-method 'default-method)
      (deactivate-input-method)
    (set-input-method new-input-method))

  (setq isearch-input-method-function input-method-function
        isearch-input-method-local-p t
        input-method-function nil)
  (isearch-update))


(define-key isearch-mode-map (kbd "<f31>")
  (lambda ()
    (interactive)
    (toggle-specified-isearch-input-method 'default-method)))

(define-key isearch-mode-map (kbd "<f32>")
  (lambda ()
    (interactive)
    (toggle-specified-isearch-input-method 'ukrainian-computer)))

(define-key isearch-mode-map (kbd "<f33>")
  (lambda ()
    (interactive)
    (toggle-specified-isearch-input-method 'russian-computer)))


(define-key global-map (kbd "<f31>")
  (lambda ()
    (interactive)
    (deactivate-input-method)
    (when flyspell-mode
      (ispell-change-dictionary "american"))))

(define-key global-map (kbd "<f32>")
  (lambda ()
    (interactive)
    (set-input-method 'ukrainian-computer)
    (when flyspell-mode
      (ispell-change-dictionary "ukrainian"))))

(define-key global-map (kbd "<f33>")
  (lambda ()
    (interactive)
    (set-input-method 'russian-computer)
    (when flyspell-mode
      (ispell-change-dictionary "ru"))))
