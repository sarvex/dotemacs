;;; -*- lexical-binding: t -*-

(package-initialize)

(mapc
 (lambda (item)
   (add-to-list 'package-archives item))
 '(("ELPA"      . "http://tromey.com/elpa/")
   ("marmalade" . "http://marmalade-repo.org/packages/")))
