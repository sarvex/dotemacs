(when (require 'package nil 'noerror)

  (setq package-archives
        '(("ELPA" . "http://tromey.com/elpa/")
          ("gnu" . "http://elpa.gnu.org/packages/")
          ("marmalade" . "http://marmalade-repo.org/packages/")))

  (package-initialize)

  (setq wtf-custom-alist
        '(("AFAICS" . "As Far As I Can See")
          ("DRY" . "Don't Repeat Yourself")))

  (autoload 'sudoku "sudoku" nil t)
  (defvar sudoku-wget-process "/usr/bin/wget")
  (setq sudoku-download-method "wget"
        sudoku-level "easy"
        sudoku-puzzle-source "web-site"))
