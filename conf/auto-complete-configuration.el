;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ac-auto-show-menu nil)
 '(ac-auto-start nil)
 '(ac-comphist-file "~/.emacs.d/ac-comphist.dat")
 '(ac-menu-height 25)
 '(ac-quick-help-delay 0.8))

(eval-after-load 'auto-complete-config
  (quote
   (progn
     (ac-config-default)

     (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
     (add-to-list 'ac-modes 'cider-mode)

     (add-to-list 'ac-dictionary-directories (expand-file-name "auto-complete/dict" el-get-dir))

     (setq-default ac-sources
                   '(ac-source-abbrev
                     ac-source-dictionary
                     ac-source-words-in-same-mode-buffers
                     ac-source-yasnippet
                     ac-source-filename))

     (define-key ac-mode-map (kbd "M-<tab>") 'auto-complete)
     (define-key ac-complete-mode-map (kbd "M-?") 'ac-quick-help)
     (define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
     (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
     (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
     (define-key ac-complete-mode-map (kbd "C-g") 'ac-stop)
     (define-key ac-complete-mode-map (kbd "<return>") 'ac-expand))))
