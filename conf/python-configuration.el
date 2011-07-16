(dolist (x '("python" "python2" "python3" "jython"))
  (add-to-list 'interpreter-mode-alist `(,x . python-mode)))
