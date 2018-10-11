#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)

(define start-time
  (string->time "2019-04-11 2:20pm"))


(make-course-with-meetings! "Coding Club: Code Your Own Battle Arena Game: 3rd-5th Grade (Spring)"
                            (code-your-game-spring-description "Hearst")
                            hearst
                            180
                            60
                            ""
                            code-your-game-spring-screenshot
 
                            start-time
                            (string->time "2019-04-18 2:20pm")
                            (string->time "2019-04-25 2:20pm")
                            (string->time "2019-05-02 2:20pm")
                            (string->time "2019-05-09 2:20pm")
                            (string->time "2019-05-16 2:20pm")
                            (string->time "2019-05-23 2:20pm")
                            (string->time "2019-05-30 2:20pm"))