(custom-set-variables
 '(openwith-associations
   `(("\\.torrent\\'" "gtorrentviewer" (file))
     ("\\.dvd.iso\\'" "vlc" (file))
     ("\\.\\(bmp\\|ico\\)\\'" "feh" (file))
     ("\\.cb[abgrz]\\'" "qcomicbook" (file))
     ("\\.chm\\'" "kchmviewer" (file))
     ("\\.pdf\\'" "mupdf" (file))
     (,(concat "\\."
               "\\("
               "djvu"
               "\\|"
               ;; "pdf"
               ;; "\\|"
               "ps"
               "\\|"
               "dvi"
               "\\)"
               "\\'")
      "evince" (file))
     (,(concat "\\."
               "\\("
               "mpe?g"
               "\\|"
               "avi"
               "\\|"
               "m[ko]v"
               "\\|"
               "vob"
               "\\|"
               "ogv"
               "\\|"
               "webm"
               "\\|"
               "m[24]v"
               "\\|"
               "flv"
               "\\|"
               "mp[24]"
               "\\|"
               "asf"
               "\\|"
               "rm\\(vb\\)?"
               "\\|"
               "wmv"
               "\\|"
               "divx"
               "\\|"
               "ts"
               "\\)"
               "\\(\\.\\(part\\|crdownload\\)\\)?"
               "\\'")
      "mplayer" (file))

     (,(concat "\\."
               "\\("
               "fb2\\(\\.zip\\)?"
               "\\|"
               "epub"
               "\\)"
               "\\'")
      "fbreader" (file))
     (,(concat "\\."
               "\\("
               "mp3"
               "\\|"
               "ogg"
               "\\|"
               "flac"
               "\\|"
               "wav"
               "\\|"
               "m[k4]a"
               "\\|"
               "wma"
               "\\|"
               "ac3"
               "\\|"
               "aac"
               "\\|"
               "ape"
               "\\)"
               "\\'")
      "deadbeef" (file))
     (,(concat "\\."
               "\\("
               "\\(doc\\|xls\\)x?"
               "\\|"
               "od[ts]"
               "\\|"
               "rtf"
               "\\)"
               "\\'")
      "libreoffice" (file)))))
