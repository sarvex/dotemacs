;;; -*- lexical-binding: t -*-

(let ((document-files (rx "." (or "djvu" "dvi" "ps") string-end))
      (comic-book-files (rx ".cb" (char "abgrz") string-end))
      (ebook-files (rx "." (or (and "fb2" (optional ".zip")) "epub") string-end))
      (image-files (rx "." (or (and "jp" (optional "e") "g") (and "tif" (optional "f")) "bmp" "ico" "png") string-end))
      (audio-files (rx "." (or (and "m" (char "k4") "a") "mp3" "ogg" "flac" "wma" "ac3" "aac" "ape") string-end))
      (office-files (rx "." (or (and (or "doc" "xls") (optional "x")) (and "od" (char "ts")) "rtf") string-end))
      (archive-files (rx "."
                         (or (and "a" (or (optional (or "ce" "lz"))
                                          (and "r" (char "cj"))))
                             (and "lz" (or (char "ho") "ma"))
                             (and (char "rwjt") "ar")
                             (and (optional "t") (or "Z" "zo" "bz2"
                                                     (and (char "7bxrgl") "z")))
                             "cab" "cpio" "deb" "lha" "lrz" "rpm" "zip")
                         string-end))
      (video-files (rx "."
                       (or (and "mp" (or (char "24")
                                         (and (optional "e") "g")))
                           (and "m" (char "24ko") "v")
                           "wmv" "divx" "ts" "avi" "asf" "vob" "ogv" "webm" "flv" "rm")
                       (optional "." (or "part" "crdownload"))
                       string-end)))

  (ert-deftest test-archive-files-regexp ()
    (mapc
     (lambda (file-name)
       (should (string-match-p archive-files file-name)))
     '("foo.7z" "foo.Z" "foo.a" "foo.ace" "foo.alz" "foo.arc" "foo.arj" "foo.bz" "foo.bz2" "foo.cab" "foo.cpio" "foo.deb" "foo.gz"
       "foo.jar" "foo.lha" "foo.lrz" "foo.lz" "foo.lzh" "foo.lzma" "foo.lzo" "foo.rar" "foo.rpm" "foo.rz" "foo.t7z" "foo.tZ" "foo.tar"
       "foo.tar.7z" "foo.tar.Z" "foo.tar.bz" "foo.tar.bz2" "foo.tar.gz" "foo.tar.lz" "foo.tar.lzo" "foo.tar.xz" "foo.tbz" "foo.tbz2"
       "foo.tgz" "foo.tlz" "foo.txz" "foo.tzo" "foo.war" "foo.xz" "foo.zip")))

  (ert-deftest test-video-files-regexp ()
    (mapc
     (lambda (file-name)
       (should (string-match-p video-files file-name)))
     '("foo.asf" "foo.avi" "foo.divx" "foo.flv" "foo.m2v" "foo.m4v" "foo.mkv" "foo.mov" "foo.mp2" "foo.mp4" "foo.mpeg" "foo.mpg"
       "foo.ogv" "foo.rm" "foo.ts" "foo.vob" "foo.webm" "foo.wmv")))

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
