(require 'project-root)

;; (setq project-details nil)

(setq project-root-storage-file "~/.emacs.d/project-roots")

(setq project-roots
      `(("Django project"
         :root-contains-files ("manage.py")
         :filename-regex ,(regexify-ext-list '(py html css js sh))
         :exclude-paths ("contrib"))
        ("Generic Python project"
         :root-contains-files ("setup.py")
         :filename-regex ,(regexify-ext-list '(py)))
        ("Generic Rake project"
         :root-contains-files ("Rakefile")
         :exclude-paths (".git" ".hg"))
        ("Generic Mercurial project"
         :root-contains-files (".hg")
         :exclude-paths (".hg"))
        ("Generic git project"
         :root-contains-files (".git")
         :exclude-paths (".git"))))


(define-key global-map (kbd "C-c p f") 'project-root-find-file)
(define-key global-map (kbd "C-c SPC") 'project-root-find-file)
(define-key global-map (kbd "C-c p g") 'project-root-grep)
(define-key global-map (kbd "C-c p a") 'project-root-ack)
(define-key global-map (kbd "C-c p d") 'project-root-goto-root)
(define-key global-map (kbd "C-c p p") 'project-root-run-default-command)
(define-key global-map (kbd "C-c p l") 'project-root-browse-seen-projects)

(define-key global-map (kbd "C-c p M-x")
  (lambda ()
    (interactive)
    (with-project-root (smex))))

(define-key global-map (kbd "C-c p v")
  (lambda ()
    (interactive)
    (with-project-root
        (let ((root (cdr project-details)))
          (cond
            ((file-exists-p ".svn")
             (svn-status root))
            ((file-exists-p ".git")
             (magit-status root))
            ((file-exists-p ".hg")
             (ahg-status root))
            (t
             (vc-directory root nil)))))))

