;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(openwith-associations
   (list
    (list (rx ".dvd.iso" string-end) "vlc" '(file))
    (list (rx ".gif" string-end) "animate" '(file))
    (list (rx ".chm" string-end) "kchmviewer" '(file))
    (list (rx ".pdf" string-end) "mupdf -r 96" '(file))
    (list (rx ".torrent" string-end) "gtorrentviewer" '(file))
    (list (rx ".cb" (char "abgrz") string-end) "qcomicbook" '(file))
    (list (rx "." (or "djvu" "dvi" "ps") string-end) "evince" '(file))
    (list (rx "." (or (and "fb2" (optional ".zip")) "epub") string-end) "fbreader" '(file))
    (list (rx "." (or (regexp "jpe?g") (regexp "tiff?") "bmp" "ico" "png") string-end) "feh" '(file))
    (list (rx "." (or (regexp "m[k4]a") "mp3" "ogg" "flac" "wma" "ac3" "aac" "ape") string-end) "vlc" '(file))
    (list (rx "." (or (and (or "doc" "xls") (optional "x")) (regexp "od[ts]") "rtf") string-end) "libreoffice" '(file))
    (list (rx "."
              (or (regexp "mpe?g") (regexp "m[ko]v") (regexp "m[24]v") (regexp "rm\\(vb\\)?") (regexp "mp[24]")
                  "wmv" "divx" "ts" "avi" "asf" "vob" "ogv" "webm" "flv" "mp4")
              (optional "." (or "part" "crdownload"))
              string-end)
     "mplayer" '(file))))

 '(dired-guess-shell-alist-user
   (list
    (list (rx ".pdf" string-end) '(list "mupdf -r 96" "qpdfview --unique"))
    (list (rx "." (or "djvu" "dvi" "ps") string-end) "evince")
    (list (rx ".cb" (char "abgrz") string-end) "qcomicbook")
    (list (rx ".tar" (optional ".Z") string-end) "aunpack")
    (list (rx ".t" (optional "ar.") (regexp "[gx]z") string-end) "aunpack")
    (list (rx ".t" (or "ar" ".bz2" "bz") string-end) "aunpack")
    (list (rx "." (or "zip" "rar" "bz2" "arc" (regexp "[7xg]z")) string-end) "aunpack")
    (list (rx "." (or (regexp "jpe?g") (regexp "tiff?") "bmp" "ico" "png") string-end) "feh *")
    (list (rx "."
              (or (regexp "mpe?g") (regexp "m[ko]v") (regexp "m[24]v") (regexp "rm\\(vb\\)?") (regexp "mp[24]")
                  "wmv" "divx" "ts" "avi" "asf" "vob" "ogv" "webm" "flv" "mp4")
              (optional "." (or "part" "crdownload"))
              string-end)
     '(list "mplayer" "mplayer -ass-bottom-margin 100 2>/dev/null >&2"))
    (list (rx "." (or (regexp "m[k4]a") "mp3" "ogg" "flac" "wma" "ac3" "aac" "ape") string-end) "vlc"))))
