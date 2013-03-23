;;; -*- lexical-binding: t -*-

(mapc
 (lambda (interpreter)
   (add-to-list 'interpreter-mode-alist (cons interpreter 'python-mode)))
 '("python" "python2" "python3" "jython"))
