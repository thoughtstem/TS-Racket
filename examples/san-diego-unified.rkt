#lang racket

(require "../lang/common.rkt")

(set-env! PROD) ;Change to PROD at your own risk


(define meeting-time
  "10:30am")

(course-with-meetings "Python Coding: 2D Game Design"
                      python-racket-description
                      liberal-arts
                      0
                      90
                      ""
                      ""
   
                      ;Meetings
                      
                      (string->time (~a "2018-09-10 " meeting-time))
                      (string->time (~a "2018-09-17 " meeting-time))
                      (string->time (~a "2018-09-24 " meeting-time))
                      (string->time (~a "2018-10-01 " meeting-time))
                      (string->time (~a "2018-10-08 " meeting-time))
                     
                      
                      (string->time (~a "2018-10-15 " meeting-time))
                      (string->time (~a "2018-10-22 " meeting-time))
                      (string->time (~a "2018-10-29 " meeting-time))
                      (string->time (~a "2018-11-05 " meeting-time))
                      (string->time (~a "2018-11-26 " meeting-time))

                      (string->time (~a "2019-01-07 " meeting-time))
                      (string->time (~a "2019-01-14 " meeting-time))
                      (string->time (~a "2019-01-28 " meeting-time))
                      (string->time (~a "2019-02-04 " meeting-time))
                      (string->time (~a "2019-02-11 " meeting-time))

                      (string->time (~a "2019-02-25 " meeting-time))
                      (string->time (~a "2019-03-04 " meeting-time))
                      (string->time (~a "2019-03-11 " meeting-time))
                      (string->time (~a "2019-03-25 " meeting-time))
                      (string->time (~a "2019-04-15 " meeting-time))
                     
                      
                      (string->time (~a "2019-04-22 " meeting-time))
                      (string->time (~a "2019-04-29 " meeting-time)))


