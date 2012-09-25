(setq midnight-period 3600              ; one hour
      clean-buffer-list-delay-general 5)

(setq clean-buffer-list-kill-never-buffer-names
      '("*Group*"
        "*Messages*"
        "*scratch*"
        "newsrc-dribble"))

(setq clean-buffer-list-kill-never-regexps
      '("^ \\*Minibuf-.*\\*$"
        "^\\*tramp/"
        "^*-configuration.el$"))

(setq clean-buffer-list-kill-buffer-names
      '("*Apropos*"
        "*Backtrace*"
        "*Bookmark List*"
        "*Buffer List*"
        "*Calendar*"
        "*Colors*"
        "*Compile-Log*"
        "*Completions*"
        "*Custom Themes*"
        "*Dired log*"
        "*Ediff Registry*"
        "*Faces*"
        "*Ibuffer*"
        "*Image*"
        "*Keys*"
        "*Kill Ring*"
        "*Locate*"
        "*Marked Files*"
        "*Occur"
        "*Packages*"
        "*Phases of Moon*"
        "*Process List*"
        "*Quail Completions*"
        "*Shell Command Output*"
        "*Snake*"
        "*Tetris*"
        "*Warnings*"
        "*WoMan-Log*"
        "*compilation*"
        "*grep*"
        "*interpretation*"))

(setq clean-buffer-list-kill-regexps
      '("^\\*Async Shell Command"
        "^\\*Calc"
        "^\\*Customize"
        "^\\*Finder"
        "^\\*Pylookup"
        "^\\*Smex: "
        "^\\*Thumbs: "
        "^\\*aHg"
        "^\\*helm"
        "^\\*hg "
        "^\\*image-dired"
        "^\\*magit"
        "^\\*yari "))

(require 'midnight)

;; disable midnight mode:
;; (cancel-timer 'midnight-timer)
