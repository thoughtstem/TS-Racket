#lang racket

(require "./common.rkt"
         json)


;(name (course 879))

#;(define course-with-new-name
  (set-name
   (course 879)
   "New name 3"))

;(save course-with-new-name)

#;(define new-robotics-course
  (new-course
   #:name "Robotics"
   #:description robotics-course-description
   #:location albert-einstein
   #:price 260))

;(save new-robotics-course)

(define new-robotics-meeting
  (new-meeting
   #:course 1040
   #:start "2018-09-5T15:00:00.000Z" ; (datetime ....)
   #:duration 60))

(save new-robotics-meeting)

#;(

   (define start-date
     (parse-time "Jan 1, 2019, 2pm"))
   
   (define new-robotics-course
     (new-course
      #:name "Robotics"
      #:description robotics-course-description
      #:location albert-einstein
      #:price 260
      #:duration 60
      #:meetings
       start-date
       (+weeks start-date 1)
       (+weeks start-date 2)
       (+weeks start-date 3)
       ;Holiday here.  Skipping a week
       (+weeks start-date 5)
       (+weeks start-date 6)
       (+weeks start-date 7)))


   (save new-robotics-course)

   )

