(setq irfc-directory "~/doc/RFC")


(define-key global-map (kbd "C-c d") 'drag-stuff-mode)
(define-key global-map (kbd "C-;") 'iedit-mode)
(define-key global-map (kbd "<f7>") 'scratch)

(setq ioccur-buffer-completion-style 'ido)
(define-key global-map (kbd "C-c i") 'ioccur)

(setq ac-comphist-file "~/.emacs.d/ac-comphist.dat"
      ac-auto-show-menu nil
      ac-auto-start nil
      ac-quick-help-delay 0.8)
(eval-after-load 'auto-complete-config
  '(progn
    (add-to-list 'ac-dictionary-directories (expand-file-name "auto-complete/dict" el-get-dir))

    (ac-config-default)

    (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
    (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
    (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
    (define-key ac-complete-mode-map (kbd "C-g") 'ac-stop)
    (define-key ac-complete-mode-map (kbd "<return>") 'ac-expand)))


(setq multi-term-program "/bin/zsh")


(setq paren-delay 0.2
      paren-highlight-offscreen t)
(eval-after-load 'mic-paren
  '(paren-activate))


(eval-after-load 'doc-mode
  '(add-hook 'doc-mode-hook
    '(lambda ()
      (turn-on-auto-fill)
      (require 'asciidoc))))


(setq
 ;; display-buffer-function 'popwin:display-buffer
 special-display-function 'popwin:special-display-popup-window)
(setq popwin:special-display-config
      '(("*Help*")
        ;; ("*Completions*" :noselect nil)
        ("*Compile-Log*" :noselect t)
        ("*Occur*" :noselect t)
        ("*Async Shell Command*")
        ("*Shell Command Output*")))

(setq special-display-buffer-names
      '("*Help*" "*Occur*"
        "*Compile-Log*"
        "*Async Shell Command*"
        "*twittering-edit*"
        "*magit-edit-log*"
        "*Shell Command Output*"))
(define-key global-map (kbd "C-h e") 'popwin:messages)



(defun my-markdown-mode-hook ()
  (setq fill-column 78)
  (turn-on-auto-fill)
  (turn-on-orgtbl))
(eval-after-load 'markdown-mode
  '(add-hook 'markdown-mode-hook 'my-markdown-mode-hook))
(dolist (ext '("\\.text\\'" "\\.markdown\\'" "\\.mdo?wn\\'" "\\.mk?dt?\\'"))
  (add-to-list 'auto-mode-alist `(,ext . markdown-mode)))


(setq coffee-cleanup-whitespace t
      coffee-js-mode 'js-mode
      coffee-tab-width 2)
(defun coffee-compile-dwim ()
  (interactive)
  (cond
    ((region-active-p)
     (call-interactively 'coffee-compile-region))
    ((buffer-file-name)
     (coffee-compile-file))
    (t
     (coffee-compile-buffer))))
(eval-after-load 'coffee-mode
  '(define-key coffee-mode-map (kbd "<f9>") 'coffee-compile-dwim))


(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("nginx.conf\\'" . nginx-mode))
