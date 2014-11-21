;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(el-get-notify-type 'message)
 '(el-get-sources
   '(el-get
     rcodetools

     (:name eval-expr
            :type emacsmirror)

     (:name pomodoro
            :type github
            :pkgname "vderyagin/pomodoro.el"
            :after (setq pomodoro-icon (expand-file-name "pomodoro/pomodoro_technique.png" el-get-dir)))

     (:name rake.el
            :type github
            :pkgname "vderyagin/rake.el")

     (:name go-oracle
            :type http
            :url "http://tools.go.googlecode.com/hg/cmd/oracle/oracle.el"
            :load-path "."
            :post-init nil)

     (:name rspec-simple
            :type github
            :pkgname "code-mancers/rspec-simple"
            :features nil)

     (:name projectur
            :type github
            :pkgname "vderyagin/projectur"))))

(unless (require 'el-get "~/.emacs.d/el-get/el-get/el-get" 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync
        (cl-remove-if
         (lambda (name) (string= name "el-get"))
         (mapcar 'el-get-source-name el-get-sources)))

(load (file-name-sans-extension el-get-autoload-file) 'noerror)

(defun el-get-regenerate-all-autoloads ()
  "Regenerates all autoloads for el-get"
  (interactive)
  (let ((f el-get-autoload-file))
    (unless (file-writable-p f)
      (error "Autoloads file can not be written"))
    (delete-file f)
    (el-get)
    (byte-compile-file f)))

(defun el-get-update-most ()
  "Update most el-get-packages (except those not in need of update)"
  (interactive)
  (let ((el-get-default-process-sync t)
        (el-get-elpa-do-refresh 'once)
        (packages (el-get-list-package-names-with-status "installed")))
    (mapc 'el-get-update packages)))
