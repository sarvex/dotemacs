(setq clean-buffer-list-delay-general 5
      midnight-period (* 3 60 60))

(setq clean-buffer-list-kill-never-buffer-names
      '("*scratch*"
        "*Messages*"
        "newsrc-dribble"
        "*Group*"))

(setq clean-buffer-list-kill-never-regexps
      '("^ \\*Minibuf-.*\\*$"
        "^\\*tramp/"
        "^my-.*-rc.el$"))

(setq clean-buffer-list-kill-buffer-names
      '("*Apropos*"
        "*Buffer List*"
        "*Bookmark List*"
        "*Process List*"
        "*Ibuffer*"
        "*Compile-Log*"
        "*Completions*"
        "*Custom Themes*"
        "*Ido Completions*"
        "*Quail Completions*"
        "*Kill Ring*"
        "*Dired log*"
        "*Tetris*"
        "*Snake*"
        "*Occur"
        "*Ediff Registry*"
        "*WoMan-Log*"
        "*Keys*"
        "*grep*"
        "*Pymacs*"
        "*Warnings*"
        "*Calendar*"
        "*Phases of Moon*"
        "*Marked Files*"
        "*Locate*"
        "*Colors*"
        "*interpretation*"
        "*Image*"
        "*Packages*"
        "*Backtrace*"
        "*Faces*"
        "*compilation*"))

(setq clean-buffer-list-kill-regexps
      '("^\\*Customize"
        "^\\*aHg"
        "^\\*IPython"
        "^\\*magit"
        "^\\*hg "
        "^\\*anything"
        "^\\*Pylookup"
        "^\\*ioccur"
        "^\\*image-dired"
        "^\\*Finder"
        "^\\*Thumbs: "
        "^\\*yari "
        "^\\*Smex: "
        "^\\*Calc"
        "\\*anything"))

(require 'midnight)

;; disable midnight mode:
;; (cancel-timer 'midnight-timer)
