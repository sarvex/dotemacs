(setq css-indent-offset 2)

(setq scss-compile-at-save nil)

(setq js2-cleanup-whitespace t)

(setq coffee-js-mode 'js-mode)

(defun pretty-js-functions ()
  (font-lock-add-keywords
   nil `(("\\(function *\\) "
          (0 (progn (compose-region (match-beginning 1)
                                    (match-end 1) "ƒ")
                    nil))))))

;; (eval-after-load 'css-mode
;;   '(add-hook 'css-mode-hook (lambda () (rainbow-mode t))))

;; (eval-after-load 'js
;;   '(add-hook 'js-mode-hook 'pretty-js-functions))

(eval-after-load 'haml-mode
  '(define-key haml-mode-map (kbd "<return>") 'newline-and-indent))

(dolist (hook '(css-mode-hook
                sass-mode-hook
                scss-mode-hook))
  (add-hook hook (lambda () (rainbow-mode))))
