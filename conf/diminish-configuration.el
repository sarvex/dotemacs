;;; -*- lexical-binding: t -*-

(eval-after-load 'paredit
  '(diminish 'paredit-mode " P"))

(eval-after-load 'eldoc
  '(diminish 'eldoc-mode "Eld"))

(eval-after-load 'whitespace
  '(progn
    (diminish 'whitespace-mode " w")
    (diminish 'global-whitespace-mode " W")))

(eval-after-load 'autodoc
  '(diminish 'autodoc-mode "AD"))

(eval-after-load 'abbrev
  '(diminish 'abbrev-mode "Ab"))

(eval-after-load 'flymake
  '(diminish 'flymake-mode "Fly"))

(eval-after-load 'yasnippet
  '(diminish 'yas-minor-mode " Y"))
