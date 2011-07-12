(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(setq cperl-invalid-face nil
      cperl-electric-keywords nil
      cperl-hairy nil
      cperl-electric-parens nil)

(setq cperl-comment-column 42
      cperl-electric-lbrace-space nil
      cperl-electric-parens-string ""
      cperl-highlight-variables-indiscriminately nil
      cperl-indent-level 4
      cperl-lazy-help-time 1)


;; Settings for classic indent-styles: K&R BSD=C++ GNU PerlStyle=Whitesmith
;;   `cperl-indent-level'                5   4       2   4
;;   `cperl-brace-offset'                0   0       0   0
;;   `cperl-continued-brace-offset'     -5  -4       0   0
;;   `cperl-label-offset'               -5  -4      -2  -4
;;   `cperl-continued-statement-offset'  5   4       2   4

(setq cperl-indent-level 4
      cperl-brace-offset 0
      cperl-continued-brace-offset -4
      cperl-label-offset -4
      cperl-continued-statement-offset 4)


;;======================================================================
;; Use eldoc in cperl-mode
;;======================================================================
(defun my-cperl-eldoc-documentation-function ()
  "Return meaningful doc string for `eldoc-mode'."
  (car
   (let ((cperl-message-on-help-error nil))
     (cperl-get-help))))

(eval-after-load 'cperl-mode
  '(add-hook 'cperl-mode-hook
    (lambda ()
      (set (make-local-variable 'eldoc-documentation-function)
           'my-cperl-eldoc-documentation-function))))

