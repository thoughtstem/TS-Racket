#lang racket

(require "./util.rkt"
         "./constants.rkt"
         gregor
         gregor/period
         2htdp/image)

(provide (all-defined-out))


;saves all meetings in a course
(define/contract (save-meetings! c)
  (-> course? course?)
  (set-meetings c
   (map save (meetings c))))

(module+ test
  (require rackunit)

  (define test-course-1
    (hash 'the-type "course"
          'name "Underwater Basket Weaving"
          'description "Learn how to weave baskets underwater!!")))

(define/contract (course id)
  (-> number? course?)
  (show "course" id))

(define (meeting id)
  (show "meeting" id))

(define/contract (meetings h)
  (-> course? (listof meeting?))
  (map (curryr set-type "meeting") (hash-ref h 'meetings #f)))

(define/contract (set-meetings c m)
  (-> course? (listof meeting?) course?)
  (hash-set c 'meetings m))

(define/contract (attendances m)
  (-> meeting? (listof attendance?))
  (map (curryr set-type "attendance")
       (hash-ref m 'attendances)))

(define/contract (computer-id a)
  (-> attendance? number?)
  (hash-ref a 'computer_id))

(define/contract (computer-ids m)
  (-> meeting? (listof number?))

  (map computer-id (attendances m)))

(define/contract (teachers course)
  (-> course? list?)
  (define m (hash-ref course 'meetings))
  (define t (first m))
  (define t-list (hash-ref t 'teachers))  
  t-list)

(define/contract (on-site-t course)
  (-> course? string?)
  (define t-list (teachers course))
  (cond
    [(null? t-list) "no teacher"]
    [(eq? (length t-list) 1) (hash-ref (first t-list) 'first_name)]
    [else (filter-leads t-list)]))

(define (filter-leads t-list)
  (define l (filter in-classroom? t-list))
  (if (empty? l)
      (hash-ref (first t-list) 'first_name)
      (hash-ref (first l) 'first_name)))
  
(define (in-classroom? t)
  (if (null? (hash-ref t 'tags))
      #t
      #f))

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


(define (make-course-with-meetings! name
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




(define/contract (start-time m)
  (-> meeting? moment?)

  (-hours
   (iso8601->moment
    (hash-ref m 'start_time))
   7))

(define/contract (end-time m)
  (-> meeting? moment?)

  (-hours
   (iso8601->moment
    (hash-ref m 'end_time))
   7))



(define (->nice-date t)
  (-> moment? string?)

  (~t t "M/d"))

(define (->nice-time t)
  (-> moment? string?)

  (~t t "h:mma"))

(define (->day-of-week t)
  (-> moment? string?)

  (~t t "EEEE"))


(define (price c)
  (hash-ref c 'price))


(define/contract (room c)
  (-> course? room?)

  (define first-meeting (first (meetings c)))

  (hash-set (hash-ref first-meeting 'room)'the-type "room"))

(define (room-number r)
  (hash-ref r 'room_number))


(define/contract (set-room-id x i)
  
  (-> (or/c meeting? course?) number? (or/c meeting? course?))
  
  (if (course? x)
      (set-meetings x (map (curryr set-room-id i) (meetings x)))
      (hash-set x 'room_id i)))



(define (location r)
  (-> room? location?)
  
  (hash-ref r 'location))

(define (address r)
  (hash-ref r 'address))

;following 3 functions grab and process grade of course
(define/contract (looks-like-grade-level s)
  (-> string? boolean?)
  
  (string-contains? s "-"))

(define (grade-level c)
  (-> course? string?)
  
  (findf looks-like-grade-level
         (topics c)))

(define/contract (k-2nd? c)
  (-> course? boolean?)
  (string=?
   (grade-level c)
   "K-2nd"))


;turns topic into string
(define/contract (get-topic-name t)
  (-> hash? string?)
  
  (hash-ref
   (hash-ref
    t
    'topic)
   'name))


;gets all topics assigned and turns into list of strings
(define/contract (topics c)
  (-> course? (listof string?))
  
  (define all-topics (hash-ref c 'topic_assignments))

  (map get-topic-name all-topics))


