;;; -*- lexical-binding: t -*-

(with-eval-after-load 'paredit
  (diminish 'paredit-mode " P"))

(with-eval-after-load 'eldoc
  (diminish 'eldoc-mode "Eld"))

(with-eval-after-load 'whitespace
  (diminish 'whitespace-mode " w")
  (diminish 'global-whitespace-mode " W"))

(with-eval-after-load 'autodoc
  (diminish 'autodoc-mode "AD"))

(with-eval-after-load 'abbrev
  (diminish 'abbrev-mode "Ab"))

(with-eval-after-load 'yasnippet
  (diminish 'yas-minor-mode " Y"))
