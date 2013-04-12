;;; -*- lexical-binding: t -*-

(package-initialize)

(mapc
 (lambda (item)
   (add-to-list 'package-archives item 'append))
 '(("marmalade" . "http://marmalade-repo.org/packages/")
   ("melpa" . "http://melpa.milkbox.net/packages/")))
