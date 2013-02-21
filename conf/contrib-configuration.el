(setq irfc-directory "~/doc/RFC")


(define-key global-map (kbd "C-c d") 'drag-stuff-mode)
(define-key global-map (kbd "C-;") 'iedit-mode)
(define-key global-map (kbd "<f7>")
  (lambda (&optional arg)
    (interactive "P")
    (let ((current-prefix-arg (not arg)))
      (scratch))))


(setq multi-term-program "/bin/zsh")


(setq paren-delay 0.2
      paren-highlight-offscreen t)
(eval-after-load 'mic-paren
  '(paren-activate))


(setq autopair-skip-whitespace 'chomp)
(autopair-global-mode)


(eval-after-load 'doc-mode
  '(add-hook 'doc-mode-hook
    '(lambda ()
      (turn-on-auto-fill)
      (require 'asciidoc))))


(setq display-buffer-function 'popwin:display-buffer
      popwin:popup-window-height 25)

(setq popwin:special-display-config
      '(((lambda (buf)
           (let ((name (with-current-buffer buf
                         mode-name)))
             (string= name "Helm"))))
        (completion-list-mode :noselect t)
        ("*magit-edit-log*" :stick t :height 15)
        ("*Gofmt Errors*" :noselect nil :height 10)
        debugger-mode
        rspec-mode
        rake-mode
        occur-mode
        compilation-mode
        help-mode
        "*Compile-Log*"
        "*Async Shell Command*"
        "*Shell Command Output*"))
(define-key global-map (kbd "C-h e") 'popwin:messages)
(define-key global-map (kbd "C-z") popwin:keymap)


(setq markdown-imenu-generic-expression
     '(("title" "^\\(.*\\)[\n]=+$" 1)
       ("h2-" "^\\(.*\\)[\n]-+$" 1)
       ("h1" "^# \\(.*\\)$" 1)
       ("h2" "^## \\(.*\\)$" 1)
       ("h3" "^### \\(.*\\)$" 1)
       ("h4" "^#### \\(.*\\)$" 1)
       ("h5" "^##### \\(.*\\)$" 1)
       ("h6" "^###### \\(.*\\)$" 1)
       ("fn" "^\\[\\^\\(.*\\)\\]" 1)))
(eval-after-load 'markdown-mode
  '(progn
    (add-hook 'markdown-mode-hook 'turn-on-auto-fill)
    (add-hook 'markdown-mode-hook 'turn-on-orgtbl)
    (add-hook 'markdown-mode-hook (lambda () (setq fill-column 78)))
    (add-hook 'markdown-mode-hook (lambda () (setq imenu-generic-expression markdown-imenu-generic-expression)))))
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist (cons extension 'markdown-mode)))
 '("\\.text\\'" "\\.markdown\\'" "\\.mdo?wn\\'" "\\.mk?dt?\\'"))


(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))


(eval-after-load 'feature-mode
  '(define-key feature-mode-map (kbd "<return>") 'newline-and-indent))


(setq ack-command "ack --color-match='bold underline' ")


(setq smex-save-file "~/.emacs.d/smex-items")
