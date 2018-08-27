#lang racket

(require "./util.rkt"
         gregor
         gregor/period
         2htdp/image)

(provide (all-defined-out))

(module+ test
  (require rackunit)

  (define test-course-1
    (hash 'the-type "course"
          'name "Underwater Basket Weaving"
          'description "Learn how to weave baskets underwater!!")))


(define course?  hash?)
(define topic?   hash?)
(define meeting? hash?)
(define room?    hash?)
(define location? hash?)


(define (course id)
  (show "course" id))


(define/contract (meetings h)
  (-> hash? list?)
  (map (curryr set-type "meeting") (hash-ref h 'meetings #f)))



;Takes a hash and returns the value for the 'name key.
(define/contract (name h)
  (-> hash? (or/c string? boolean?))
  (hash-ref h 'name #f))

(module+ test
  (check-equal? (name test-course-1)
                "Underwater Basket Weaving")

  (check-equal? (type test-course-1)
                "course"))


;Sets the 'name value in the provided hash.  Does not save the
;  associated remote resource.  You must use save for that.
(define/contract (set-name h new-name)
  (-> hash? string? hash?)
  (hash-set h 'name new-name))

(module+ test
  (check-equal? (name (set-name test-course-1 "New name"))
                "New name"))



(define/contract (new-course #:name n
                             #:description desc
                             #:location loc
                             #:price p
                             #:foreign-enrollment-url foreign-enrollment-url
                             #:screenshot-url screenshot-url)
  (-> #:name string?
      #:description string?
      #:location number?
      #:price number?
      #:foreign-enrollment-url string?
      #:screenshot-url string?
      hash?)
  
  (hash 'the-type "course"
        'name n
        'description desc
        'dummy_connect_to loc
        'price p
        'foreign_enrollment_url foreign-enrollment-url
        'screenshot_url screenshot-url
        ))

(define (new-meeting #:course id #:start t #:duration x)
  (-> #:course number? #:start string? #:duration number? hash?)
  (hash 'the-type "meeting"
        'start_time (moment->iso8601 t)
        'end_time (moment->iso8601 (+period t (period [minutes x])))
        'course_id id))


(define (course-with-meetings name
                              desc
                              location
                              price
                              meeting-duration
                              foreign-enrollment-url
                              screenshot-url
                              . meeting-times)
  ;Step 1: Make course

  (define coding-club
    (new-course
     #:name name
     #:description desc
     #:location    location
     #:price price
     #:foreign-enrollment-url foreign-enrollment-url
     #:screenshot-url screenshot-url
     ))

  (define saved-course
    (save coding-club))

  (define dummy-meeting
    (first
     (meetings
      (course (id saved-course)))))


  ;Step 2: Make meetings

  (define course-meetings
    (map (λ(t)
           (new-meeting
            #:course   (id saved-course)
            #:start    t
            #:duration meeting-duration))
         meeting-times))

  (save-all course-meetings)


  ;Step 3: Clean up the dummy meeting.  Must do this last.
  ; (It gets used during the creation of the other meetings)
  (destroy dummy-meeting)

  saved-course)




(define/contract (get-topic-name t)
  (-> topic? string?)
  
  (hash-ref
   (hash-ref
    t
    'topic)
   'name))


(define/contract (topics c)
  (-> course? (listof string?))
  
  (define all-topics (hash-ref c 'topic_assignments))

  (map get-topic-name all-topics))


(define/contract (looks-like-grade-level s)
  (-> string? boolean?)
  
  (string-contains? s "-"))

(define (grade-level c)
  (-> course? string?)
  
  (findf looks-like-grade-level
         (topics c)))





(define (make-flier course-title
                    grade-level
                    selling-points
                    duration
                    start
                    end
                    price
                    location-details
                    time-details
                    register-url)

  (define bg (bitmap/file "bg.png"))

  (define bg-with-title
    (place-image
     (text (~a "Coding Club: " grade-level) 80 "white")
     (/ (image-width bg) 2)
     900
     bg))


  (define (string->bullet s)
    (text (~a "•  " s) 60 "white"))

  (define spacer
    (circle 20 "solid" "transparent"))

  (define bullets
    (above/align "left"
                 (string->bullet
                  (first selling-points))
                 spacer
                 (string->bullet
                  (second selling-points))
                 spacer
                 (string->bullet
                  (third selling-points))))

  (define with-bullets
    (place-image
     bullets
     (+ (/ (image-width bg) 2) 200)
     1300
     bg-with-title))


  (define with-course-title
    (place-image
     (text course-title 80 "white")
     (/ (image-width bg) 2)
     1050
     with-bullets))

  (define with-time-and-price
    (place-image
     (text (~a duration " weeks (" start " - " end ") | " price "$")
           80 "white")
     (/ (image-width bg) 2)
     1650
     with-course-title))


  (define with-table-headers
    (place-image
     (above/align "left"
                  (text "LOCATION:" 60 "white")
                  spacer
                  (text "DAY & TIME:" 60 "white")
                  spacer
                  (text "GRADES:" 60 "white")
                  spacer
                  (text "REGISTER:" 60 "white")
                  spacer
                  (text "CONTACT US:" 60 "white"))
     350
     2950
     with-time-and-price)
    )

  (define with-table-lines
    (place-image
     (above/align "left"
                  (text (~a (first location-details)
                            " at "
                            (second location-details)
                            " | "
                            (third location-details)) 60 "white")
                  spacer
                  (text (~a (first time-details)
                            " | "
                            (second time-details)
                            " - "
                            (third time-details)) 60 "white")
                  spacer
                  (text "K-2nd & 3rd-5th classes available year-round" 60 "white")
                  spacer
                  (text register-url 60 "white")
                  spacer
                  (text "(858) 869-9430 | contact@thoughtstem.com | www.thoughtstem.com" 60 "white"))
     1500
     2950
     with-table-headers))

  (scale .25 with-table-lines))




(define/contract (start-time m)
  (-> meeting? moment?)

  (iso8601->moment
   (hash-ref m 'start_time))
  )

(define/contract (end-time m)
  (-> meeting? moment?)

  (iso8601->moment
   (hash-ref m 'end_time))
  )

(define (->nice-date t)
  (-> moment? string?)

  (~t t "M/d"))

(define (->nice-time t)
  (-> moment? string?)

  (~t t "h:m"))

(define (->day-of-week t)
  (-> moment? string?)

  (~t t "EEEE"))


(define (price c)
  (hash-ref c 'price))


(define/contract (room c)
  (-> course? room?)

  (define first-meeting (first (meetings c)))

  
  (hash-ref first-meeting 'room))

(define (room-number r)
  (hash-ref r 'room_number))

(define (location r)
  (-> room? location?)
  (hash-ref r 'location))

(define (address r)
  (hash-ref r 'address))
