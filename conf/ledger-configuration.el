;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(ledger-use-iso-dates t)
 '(ledger-post-use-completion-engine :ido))

(add-to-list 'auto-mode-alist '("\\.ledger\\'" . ledger-mode))

(with-eval-after-load 'ledger-mode
  (define-key ledger-mode-map (kbd "C-<tab>") nil))

(with-eval-after-load 'ledger-report
  (define-key ledger-report-mode-map (kbd "p") 'previous-line)
  (define-key ledger-report-mode-map (kbd "n") 'next-line))
