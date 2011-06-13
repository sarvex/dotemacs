(require 'ansi-color)
(require 'eshell)
(require 'em-dirs)

(setq eshell-directory-name "~/.emacs.d/eshell/"
      eshell-cmpl-cycle-completions nil
      eshell-save-history-on-exit t
      eshell-scroll-show-maximum-output nil
      eshell-scroll-to-bottom-on-input 'this
      eshell-scroll-to-bottom-on-output 'this
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.hg\\|\\.git\\)/\\'"
      eshell-output-filter-functions '(eshell-handle-ansi-color
                                       eshell-handle-control-codes
                                       eshell-postoutput-scroll-to-bottom
                                       eshell-truncate-buffer
                                       eshell-watch-for-password-prompt))

(defun my-eshell-mode-hook ()
  (define-key eshell-mode-map (kbd "C-l")
    (lambda () (interactive) (goto-char (point-max)) (recenter-top-bottom 0)))

  (setq eshell-visual-commands
        (append
         '("mutt" "vim" "screen" "tmux" "lftp" "mc" "ipython" "bpython"
           "telnet" "ssh" "tail" "most" "top" "htop" "iotop" "ncmpcpp"
           "newsbeuter" "alsamixer" "atop")
         eshell-visual-commands)))

(eval-after-load 'esh-opt
  '(progn
    (require 'em-prompt)
    (require 'em-term)
    (require 'em-cmpl)
    (setenv "PAGER" "cat")
    (add-hook 'eshell-mode-hook 'my-eshell-mode-hook)))

(defun eshell/cds ()
  "Change directory to the project's root."
  (eshell/cd (locate-dominating-file default-directory "src")))

(defun eshell/find (dir &rest opts)
  (find-dired dir (mapconcat 'identity opts " ")))
