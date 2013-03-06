;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(irfc-directory "~/doc/RFC")
 '(multi-term-program "/bin/zsh")
 '(smex-save-file "~/.emacs.d/smex-items")
 '(ack-command "ack --color-match='bold underline' "))


(define-key global-map (kbd "C-c d") 'drag-stuff-mode)
(define-key global-map (kbd "C-;") 'iedit-mode)
(define-key global-map (kbd "<f7>")
  (lambda (&optional arg)
    (interactive "P")
    (let ((current-prefix-arg (not arg)))
      (scratch))))

(custom-set-variables
 '(paren-delay 0.2)
 '(paren-highlight-offscreen t))
(paren-activate)


(custom-set-variables
 '(sp-highlight-pair-overlay nil))
(smartparens-global-mode)
(sp-with-modes '(
                 cperl-mode
                 go-mode
                 haskell-mode
                 perl-mode
                 ruby-mode
                 scala-mode
                 sh-mode
                 )
  (sp-local-pair "`" "`"))
(mapc
 (lambda (mode)
   (add-to-list 'sp-ignore-modes-list mode))
 '(lisp-mode
   term-mode))


(eval-after-load 'doc-mode
  '(add-hook 'doc-mode-hook
    '(lambda ()
      (turn-on-auto-fill)
      (require 'asciidoc))))


(custom-set-variables
 '(display-buffer-function 'popwin:display-buffer)
 '(popwin:popup-window-height 25)
 '(popwin:special-display-config
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
     "*interpretation*"
     "*Compile-Log*"
     "*Async Shell Command*"
     "*Shell Command Output*")))
(define-key global-map (kbd "C-h e") 'popwin:messages)
(define-key global-map (kbd "C-z") popwin:keymap)


(eval-after-load 'markdown-mode
  '(progn
    (add-hook 'markdown-mode-hook 'turn-on-auto-fill)
    (add-hook 'markdown-mode-hook 'turn-on-orgtbl)
    (add-hook 'markdown-mode-hook (lambda () (setq fill-column 78)))
    (add-hook 'markdown-mode-hook
     (lambda () (setq imenu-generic-expression
                 '(("title" "^\\(.*\\)[\n]=+$" 1)
                   ("h2-" "^\\(.*\\)[\n]-+$" 1)
                   ("h1" "^# \\(.*\\)$" 1)
                   ("h2" "^## \\(.*\\)$" 1)
                   ("h3" "^### \\(.*\\)$" 1)
                   ("h4" "^#### \\(.*\\)$" 1)
                   ("h5" "^##### \\(.*\\)$" 1)
                   ("h6" "^###### \\(.*\\)$" 1)
                   ("fn" "^\\[\\^\\(.*\\)\\]" 1)))))))
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist (cons extension 'markdown-mode)))
 '("\\.text\\'" "\\.markdown\\'" "\\.mdo?wn\\'" "\\.mk?dt?\\'"))


(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))


(eval-after-load 'feature-mode
  '(define-key feature-mode-map (kbd "<return>") 'newline-and-indent))
