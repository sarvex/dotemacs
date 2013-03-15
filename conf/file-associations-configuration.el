;;; -*- lexical-binding: t -*-

(let ((document-files (rx "." (or "djvu" "dvi" "ps") string-end))
      (comic-book-files (rx ".cb" (char "abgrz") string-end))
      (ebook-files (rx "." (or (and "fb2" (optional ".zip")) "epub") string-end))
      (image-files (rx "." (or (and "jp" (optional "e") "g") (and "tif" (optional "f")) "bmp" "ico" "png") string-end))
      (audio-files (rx "." (or (and "m" (char "k4") "a") "mp3" "ogg" "flac" "wma" "ac3" "aac" "ape") string-end))
      (office-files (rx "." (or (and (or "doc" "xls") (optional "x")) (and "od" (char "ts")) "rtf") string-end))
      (archive-files (rx "."
                         (or (and "t"
                                  (or (and (optional "ar.") (and (char "gbx") "z"))
                                      (and "ar"
                                           (optional "." (or "Z"
                                                             (and "bz"
                                                                  (optional "2")))))))
                             (or "zip"
                                 "rar"
                                 "bz2"
                                 "arc"
                                 (and (char "7xg")
                                      "z")))
                         string-end))
      (video-files (rx "."
                       (or (and "mp" (optional "e") "g")
                           (and "m" (char "24ko") "v")
                           (and "rm" (optional "vb"))
                           (and "mp" (char "24"))
                           "wmv" "divx" "ts" "avi" "asf" "vob" "ogv" "webm" "flv" "mp4")
                       (optional "." (or "part" "crdownload"))
                       string-end)))

  (custom-set-variables
   `(openwith-associations
     (list
      (list (rx ".chm" string-end) "kchmviewer" '(file))
      (list (rx ".dvd.iso" string-end) "vlc" '(file))
      (list (rx ".gif" string-end) "animate" '(file))
      (list (rx ".pdf" string-end) "mupdf -r 96" '(file))
      (list (rx ".torrent" string-end) "gtorrentviewer" '(file))
      (list ,audio-files "vlc" '(file))
      (list ,comic-book-files "qcomicbook" '(file))
      (list ,document-files "evince" '(file))
      (list ,ebook-files "fbreader" '(file))
      (list ,image-files "feh" '(file))
      (list ,office-files "libreoffice" '(file))
      (list ,video-files "mplayer" '(file))))

   `(dired-guess-shell-alist-user
     (list
      (list (rx ".gif" string-end) '(list "animate" "feh" "firefox"))
      (list (rx ".pdf" string-end) '(list "mupdf -r 96" "qpdfview --unique"))
      (list (rx ".torrent" string-end) '(list "torrentinfo" "gtorrentviewer"))
      (list ,archive-files "aunpack")
      (list ,audio-files "vlc")
      (list ,comic-book-files '("mcomix" "qcomicbook" "aunpack"))
      (list ,document-files "evince")
      (list ,image-files "feh *")
      (list ,video-files '(list "mplayer" "mplayer -ass-bottom-margin 100 2>/dev/null >&2"))))))
