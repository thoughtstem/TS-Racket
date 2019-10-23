#lang racket

(require "../lang/common.rkt"
         gregor)


(set-env! DEV) ;Change to PROD at your own risk

(define start-date  
  (string->time "2018-10-11 2:35pm")) 

;At Del Mar we're running 12-meeting courses at $330

(course-with-meetings "Coding and Robotics"
                      coding-and-engineering-description
                      sycamore-ridge
                      330
                      60
                      "https://www.dmusd.org/Page/353"
                      coding-and-engineering-screenshot
   
                      ;Meetings
                      
                      start-date
                      (+weeks start-date 1)
                      (+weeks start-date 2) 
                      (+weeks start-date 3)   
                      (+weeks start-date 4)

                      ;Thanksgiving

                      (+weeks start-date 7)
                      (+weeks start-date 8)
                      (+weeks start-date 9)
                      (+weeks start-date 10)

                      ;Christmas

                      (+weeks start-date 13)
                      (+weeks start-date 14)
                      (+weeks start-date 15))





