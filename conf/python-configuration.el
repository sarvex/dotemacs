(mapc
 (lambda (py)
   (add-to-list 'interpreter-mode-alist `(,py . python-mode)))
 '("python" "python2" "python3" "jython"))

(eval-after-load 'python
  '(define-key python-mode-map (kbd "<return>") 'newline-and-indent))

(remove-hook 'python-mode-hook 'wisent-python-default-setup)
