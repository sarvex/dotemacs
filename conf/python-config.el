(dolist (x '("python" "python2" "python3" "jython"))
  (add-to-list 'interpreter-mode-alist `(,x . python-mode)))

(defun my-python-mode-hook ()
  (eldoc-mode t))

;; (eval-after-load "python"
;;   '(add-hook 'python-mode-hook 'my-python-mode-hook))
