;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ledger-use-iso-dates t)
 '(ledger-post-use-completion-engine :ido))

(add-to-list 'auto-mode-alist '("\\.ledger\\'" . ledger-mode))

(with-eval-after-load 'ledger-mode
  (define-key ledger-mode-map (kbd "C-<tab>") nil)
  (define-key ledger-mode-map (kbd "C-c +")
    (lambda (template)
      (interactive "MTransaction template: ")
      (let ((cmd (format "ledger entry %s" template)))
        (goto-char (point-max))

        ;; Force exactly one empty line between transactions.
        (while (not (looking-back "\n\n" 2)) (insert "\n"))
        (while (not (looking-back ".\n\n" 3)) (delete-char -1))

        (insert (shell-command-to-string cmd)))))

  )

(with-eval-after-load 'ledger-report
  (define-key ledger-report-mode-map (kbd "p") 'previous-line)
  (define-key ledger-report-mode-map (kbd "n") 'next-line))
