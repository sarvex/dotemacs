;;; -*- lexical-binding: t -*-

(define-key global-map (kbd "C-c f") 'projectur-find-file)

(custom-set-variables
 '(pe/omit-regex (rx (or (and string-start "#")
                         (and (or "!"
                                  ".elc"
                                  ".test"
                                  )
                              string-end)
                         (and string-start
                              (or (and ".git" (optional "keep"))
                                  ".module-cache"
                                  "bower_components"
                                  "dist"
                                  "node_modules"
                                  "tmp"
                                  "vendor"
                                  )
                              string-end)))))

(with-eval-after-load 'project-explorer
  (define-key project-explorer-mode-map (kbd "o")
    (lambda ()
      (interactive)
      (let ((win (selected-window)))
        (call-interactively 'pe/find-file)
        (select-window win)))))
