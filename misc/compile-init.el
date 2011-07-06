(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d/conf")
(add-to-list 'load-path "~/.emacs.d/slime")

(setq debug-on-error t)

;; fix el-get-config loading
(require 'inversion "~/.emacs.d/el-get/cedet/common/inversion")

(load "el-get-config")
(load "elpa-config")

;; Local Variables:
;; no-byte-compile: t
;; End:
