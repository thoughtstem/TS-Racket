#lang racket

(require "./common.rkt"
         json)

;Step 1: Make course

(define coding-club
  (new-course
   #:name "Coding Club: Digital Comic Books: K-2nd"
   #:description (digital-comics-description "Ocean Air")
   #:location    ocean-air
   #:price 330))

(define saved-course
  (save coding-club))

(define dummy-meeting
  (first
   (meetings
    (course (id saved-course)))))


;Step 2: Make meetings



(define start-date
  (+hours
   (datetime 2018 10 9
             2 35)
   19))



(define course-meetings
  (list
   (new-meeting
    #:course   (id saved-course)
    #:start    start-date
    #:duration 60)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 1)
    #:duration 60)
   
   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 2)
    #:duration 60)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 3)
    #:duration 60)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 4)
    #:duration 60)

   ;Skip two weeks (Thanksgiving)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 7)
    #:duration 60)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 8)
    #:duration 60)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 9)
    #:duration 60)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 10)
    #:duration 60)

   ;Skip two weeks (Christmas + New Years)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 13)
    #:duration 60)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 14)
    #:duration 60)

   (new-meeting
    #:course   (id saved-course)
    #:start    (+weeks start-date 15)
    #:duration 60)
   
   ))

(save-all course-meetings)


;Step 3: Clean up the dummy meeting.  Must do this last.
; (It gets used during the creation of the other meetings)
(destroy dummy-meeting)





