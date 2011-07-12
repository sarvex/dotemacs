;; Savehist
(setq savehist-file "~/.emacs.d/savehist") ; keep my ~/ clean

(setq savehist-save-minibuffer-history t)

(setq savehist-additional-variables
      '(search-ring
        kill-ring
        ioccur-history
        ido-work-directory-list
        regexp-search-ring))

(setq savehist-ignored-variables
      '(bmkp-tag-history
        bookmark-history
        buffer-name-history
        minibuffer-history
        ido-buffer-history
        ido-file-history
        file-name-history))

(require 'savehist)

(savehist-mode t)

(defun my-savehist-save-hook ()
  (dolist (var (append savehist-additional-variables
                       savehist-minibuffer-history-variables))
    (when (boundp var)
      (setq var (delete-dups (symbol-value var))))))

(add-hook 'savehist-save-hook 'my-savehist-save-hook)

(savehist-save)


;; Recentf
(setq recentf-save-file "~/.emacs.d/recentf")

(setq recentf-max-saved-items 1000)

(setq recentf-exclude
      '("\\.\\(jp\\(e\\|g\\|eg\\)\\|gif\\|png\\|ico\\|x[pb]m\\|bmp\\|tiff?\\)\\'" ; images
        "\\.\\(zip\\|rar\\|xpi\\|crx\\|oex\\)\\'" ; archives
        "\\.nfo\\'"
        "\\.cue\\'"
        "\\.sfv\\'"
        "\\.m3u\\'"
        "\\.url\\'"
        "\\.srt\\'"
        "^Thumbs\\.db\\'"))

(require 'recentf)

(recentf-mode 1)
(recentf-save-list)


;; desktop
(setq desktop-path '("~/.emacs.d/")
      desktop-load-locked-desktop t
      desktop-save t
      desktop-save-mode t)

(setq desktop-files-not-to-save "\\(^/[^/:]*:\\|(ftp)$\\|\\.gpg\\'\\|recentf\\|newsrc-dribble\\|archive_.*\\.org\\)")

(setq desktop-globals-to-save nil)      ; not needed, `savehist' does the thing

(setq desktop-locals-to-save
      '(desktop-locals-to-save
        truncate-lines
        case-fold-search
        case-replace
        fill-column
        overwrite-mode
        change-log-default-name
        size-indication-mode
        buffer-file-coding-system
        indent-tabs-mode
        show-trailing-whitespace))

(require 'desktop)

(desktop-save-mode 1)
