(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d/conf")
(add-to-list 'load-path "~/.emacs.d/slime")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq debug-on-error t)

(load "cedet-configuration")
(load "el-get-configuration")
(load "elpa-configuration")

;; Local Variables:
;; no-byte-compile: t
;; End:
