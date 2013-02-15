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
      "vlc" (file))
     (,(concat "\\."
               "\\("
               "\\(doc\\|xls\\)x?"
               "\\|"
               "od[ts]"
               "\\|"
               "rtf"
               "\\)"
               "\\'")
      "libreoffice" (file))))
 '(dired-guess-shell-alist-user
   '(("\\.pdf\\'" '("mupdf" "qpdfview --unique"))
     ("\\.\\(djvu\\|ps\\|dvi\\)\\'" "evince")
     ("\\.cb[abgrz]\\'" "qcomicbook")

     ("\\.tar\\(\\.Z\\)?\\'" "aunpack")
     ("\\.t\\(ar\\.\\)?gz\\'" "aunpack")
     ("\\.t\\(ar\\.bz2\\|bz\\)\\'" "aunpack")
     ("\\.t\\(ar\\.\\)?xz\\'" "aunpack")
     ("\\.\\(zip\\|rar\\|7z\\|xz\\|bz2\\|gz\\|arc\\)\\'" "aunpack" )
     ("\\.\\(bmp\\|ico\\|jpe?g\\|gif\\|tiff?\\|png\\)\\'" "feh")
     ("\\.\\(mp3\\|ogg\\|flac\\|wav\\|m[k4]a\\|wma\\|ac3\\|aac\\|ape\\)\\'" "vlc"))))
