;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(el-get-notify-type 'message)
 '(el-get-sources
   '(el-get

     gnus
     rcodetools

     (:name openwith
            :description "Open files with external programs"
            :type hg
            :url "https://bitbucket.org/jpkotta/openwith"
            :features openwith
            :after (openwith-mode 1))

     (:name inf-ruby
            :type http
            :url "https://raw.githubusercontent.com/ruby/ruby/trunk/misc/inf-ruby.el"
            :features nil)

     (:name eval-expr
            :type emacsmirror)

     (:name pomodoro
            :type github
            :pkgname "vderyagin/pomodoro.el"
            :after (setq pomodoro-icon (expand-file-name "pomodoro/pomodoro_technique.png" el-get-dir)))

     (:name rake.el
            :type github
            :pkgname "vderyagin/rake.el")

     (:name ack
            :type github
            :pkgname "leoliu/ack-el"
            :features nil
            :after (setq ack-command "ag --smart-case "))

     (:name miniedit
            :type emacsmirror
            :after (miniedit-install))

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
         (lambda (name) (member name '("el-get" "es-windows")))
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
        (packages (cl-remove-if
                   (lambda (pkg) (member pkg '("ensime" "erc-highlight-nicknames" "erc")))
                   (el-get-list-package-names-with-status "installed"))))
    (mapc 'el-get-update packages)))
