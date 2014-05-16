(eval-after-load 'compile
  (quote
   (progn

     (add-to-list 'compilation-error-regexp-alist 'haskell-doctest)
     (add-to-list 'compilation-error-regexp-alist-alist
                  (list 'haskell-doctest
                        (rx line-start
                            "### Failure in "
                            (group (+ not-newline) "." (optional "l") "hs") ; file name
                            ":"
                            (group (+ (char digit)))                        ; line number
                            ":")
                        1 2))

     (add-to-list 'compilation-error-regexp-alist 'rust-test)
     (add-to-list 'compilation-error-regexp-alist-alist
                  (list 'rust-test
                        (rx line-start
                            "\ttask '"
                            (*? anything)
                            "' failed at '"
                            (*? anything)
                            "', "
                            (group (+ not-newline) ".rs") ; file name
                            ":"
                            (group (+ (char digit)))      ; line number
                            line-end)
                        1 2))

     )))
