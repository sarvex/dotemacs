(custom-set-variables
 '(kmacro-ring-max 20))

(define-key global-map (kbd "C-c m")
  (let ((map (make-sparse-keymap)))
    (define-key map "s" 'kmacro-start-macro-or-insert-counter)
    (define-key map "x" 'kmacro-end-or-call-macro)
    (define-key map "e" 'kmacro-edit-macro)
    (define-key map "?" 'kmacro-view-macro)
    (define-key map "l" 'apply-macro-to-region-lines)
    (define-key map "n" 'kmacro-cycle-ring-next)
    (define-key map "p" 'kmacro-cycle-ring-previous)
    map))
