;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(eshell-directory-name "~/.emacs.d/eshell/")
 '(eshell-scroll-show-maximum-output nil)
 '(eshell-scroll-to-bottom-on-input 'this)
 '(eshell-scroll-to-bottom-on-output 'this)
 '(eshell-cmpl-dir-ignore (rx string-start
                              (or (and "." (or
                                            "svn" "hg" "git"
                                            (optional ".")))
                                  "CVS" "_darcs")
                              "/"
                              string-end)))

(with-eval-after-load 'esh-mode
  (require 'em-dirs)

  (defun eshell/cds ()
    "Change directory to the project's root."
    (eshell/cd (locate-dominating-file default-directory ".git")))

  (defun eshell/find (dir &rest opts)
    (find-dired dir (mapconcat 'shell-quote-argument opts " ")))

  (mapc
   (lambda (c) (add-to-list 'eshell-visual-commands c))
   '("mutt" "vim" "screen" "tmux" "lftp" "mc" "ipython" "bpython"
     "telnet" "ssh" "tail" "most" "top" "htop" "iotop" "ncmpcpp"
     "newsbeuter" "alsamixer" "atop")))

(with-eval-after-load 'esh-opt
  (require 'em-prompt)
  (require 'em-term)
  (require 'em-cmpl)
  (setenv "PAGER" "cat"))
