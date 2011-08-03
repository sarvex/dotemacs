(setq
 openwith-associations
 '(("\\.\\(djvu\\|pdf\\|ps\\|dvi\\)\\'" "evince" (file))
   ("\\.\\(mpe?g\\|avi\\|m[ko]v\\|vob\\|ogv\\|webm\\|m[24]v\\|f[4l]\\|mp[24]\\|asf\\|rm\\(vb\\)?\\|wmv\\|divx\\|ts\\)\\(\\.\\(part\\|crdownload\\)\\)?\\'" "mplayer" (file "&"))
   ;; ("\\.dvd.iso\\'" "mplayer" ("-dvd-device" file "dvdnav://0"))
   ("\\.dvd.iso\\'" "cvlc" (file))
   ("\\.chm\\'" "kchmviewer" (file))
   ("\\.ape\\'" "ffplay" (file))
   ("\\.\\(fb2\\(.zip\\)?\\|epub\\)\\'" "fbreader" (file))
   ("\\.\\(mp3\\|ogg\\|flac\\|wav\\|m[k4]a\\|wma\\|ac3\\|aac\\)\\'" "deadbeef" (file))
   ("\\.\\(\\(doc\\|xls\\)x?\\|od[ts]\\|rtf\\)\\'" "libreoffice" (file))
   ;; ("\\.\\(jp\\(e\\|g\\|eg\\)\\|gif\\|png\\|x[pb]m\\|bmp\\|tiff?\\)\\'" "feh" (file))
   ("\\.bmp\\'" "feh" (file))
   ("\\.cb[abgrz]\\'" "qcomicbook" (file))))
