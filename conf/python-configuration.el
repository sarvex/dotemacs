(dolist (x '("python" "python2" "python3" "jython"))
  (add-to-list 'interpreter-mode-alist `(,x . python-mode)))

(eval-after-load 'python
  '(define-key python-mode-map (kbd "<return>") 'reindent-then-newline-and-indent))
