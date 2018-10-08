#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)

(define start-time
  (string->time "2018-10-27 12:30pm"))


(make-course-with-meetings! "2D Game Design"
                            ""
                            ucsd-extension
                            270
                            120
                            ""
                            ""
 
                            start-time
                            (string->time "2018-11-03 12:30pm")
                            (string->time "2018-11-10 12:30pm")
                            (string->time "2018-11-17 12:30pm")
                            (string->time "2018-12-01 12:30pm")
                            (string->time "2018-12-08 12:30pm"))
                          
                          