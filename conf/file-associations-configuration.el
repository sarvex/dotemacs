;;; -*- lexical-binding: t -*-

(let ((document-files (rx not-newline "." (or "djvu" "pdf" "ps") string-end))
      (comic-book-files (rx not-newline ".cb" (char "abgrz") string-end))
      (image-files (rx not-newline "." (or (and "jp" (optional "e") "g") (and "tif" (optional "f")) "bmp" "ico" "png") string-end))
      (audio-files (rx not-newline "." (or (and "m" (char "k4") "a") "mp3" "ogg" "flac" "wma" "ac3" "aac" "ape") string-end))
      (office-files (rx not-newline "." (or (and (or "doc" "xls" "vsd" "pps") (optional "x")) (and "od" (char "ts")) "rtf") string-end))
      (archive-files (rx not-newline "."
                         (or (and "a" (or (optional (or "ce" "lz"))
                                          (and "r" (char "cj"))))
                             (and "lz" (or (char "ho") "ma"))
                             (and (char "rwjt") "ar")
                             (and (optional "t") (or "Z" "zo" "bz2"
                                                     (and (char "7bxrgl") "z")))
                             "cab" "cpio" "deb" "lha" "lrz" "rpm" "zip")
                         (optional "." (or "part" "crdownload"))
                         string-end))
      (video-files (rx not-newline "."
                       (or (and "mp" (or (char "24")
                                         (and (optional "e") "g")))
                           (and "m" (char "24ko") "v")
                           (and "f" (char "l4") "v")
                           (and (optional "m2") "ts")
                           "wmv" "divx" "avi" "asf" "vob" "ogv" "webm" "rm" "3gp")
                       (optional "." (or "part" "crdownload"))
                       string-end)))

  (custom-set-variables
   `(openwith-associations
     (list
      (list (rx not-newline ".pdf" string-end) "mupdf" '(file))
      (list (rx not-newline ".chm" string-end) "kchmviewer" '(file))
      (list (rx not-newline ".dvd.iso" string-end) "vlc" '(file))
      (list (rx not-newline ".gif" string-end) "animate" '(file))
      (list ,audio-files "vlc" '(file))
      (list ,comic-book-files "qcomicbook" '(file))
      (list ,document-files "qpdfview --unique" '(file))
      (list ,image-files "feh" '(file))
      (list ,office-files "libreoffice" '(file))
      (list ,video-files "mpv" '(file))))

   `(dired-guess-shell-alist-user
     (list
      (list (rx not-newline ".pdf" string-end) '(list "chromium-browser" "mupdf"))
      (list (rx not-newline ".htm" (optional "l") string-end) "chromium")
      (list (rx not-newline ".gif" string-end) '(list "animate" "feh" "chromium" "firefox"))
      (list (rx not-newline ".torrent" string-end) '(list "torrentinfo" "gtorrentviewer"))
      (list (rx not-newline "." (or "mobi" "epub" "fb2" "lit" "chm") string-end) "fbreader")
      (list ,document-files '(list "mupdf" "qpdfview --unique"))
      (list ,archive-files '(list "aunpack -e *" "mcomix" "qcomicbook"))
      (list ,audio-files "vlc")
      (list ,comic-book-files '(list "mcomix" "qcomicbook" "aunpack -e *"))
      (list ,image-files "feh *")
      (list ,video-files '(list "mpv *" "mpv -vf sub=100"))
      (list "" '(list "feh"))
      ))))
