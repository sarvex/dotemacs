(mapc
 (lambda (interpreter)
   (add-to-list 'interpreter-mode-alist (cons interpreter 'python-mode)))
 '("python" "python2" "python3" "jython"))

(eval-after-load 'python
  '(define-key python-mode-map (kbd "<return>") 'newline-and-indent))
