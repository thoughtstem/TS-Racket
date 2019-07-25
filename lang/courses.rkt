#lang racket

(require "./util.rkt"
         "./constants.rkt"
         gregor
         gregor/period
         2htdp/image
         threading)

(provide (all-defined-out))

;saves all meetings in a course
(define/contract (save-meetings! c)
  (-> course? course?)
  (set-meetings c
   (map save (meetings c))))

(define/contract (save-topics! c)
  (-> course? course?)
  (hash-set c 'topic_assignments
   (map save (topic-assignments c))))

(define/contract (add-topic c t)
  (-> course? string? course?)
  (define current (hash-ref c 'topic_assignments '()))

  (define new (new-topic-assignment (id c)
                                    (topic-id-for t)))

  (hash-set c 'topic_assignments
            (cons new current)))

(define (add-topics c ts)
  (foldl (λ(t prev-c)
           (add-topic prev-c t)) c ts))

(define/contract (new-topic-assignment cid tid)
  (-> number? number? topic-assignment?)
  (hash 'course_id cid
        'topic_id tid
        'the-type "topic_assignment"))

(define/contract (topic-id-for t)
  (-> string? number?)
  
  (define topics (index "topic"))

  (define i
    (id
     (findf (λ(topic)
              (string=? t
                        (hash-ref topic 'name)))
         topics)))

  i)

(module+ test
  (require rackunit) 

  (define test-course-1
    (hash 'the-type "course"
          'name "Underwater Basket Weaving"
          'description "Learn how to weave baskets underwater!!")))

(define/contract (course id)
  (-> number? course?)
  (show "course" id))

(define/contract (meeting-id meeting)
  (-> meeting? number?)
  (hash-ref meeting 'id))

(define (no-attendance? ar)
  (eq? ar ""))

(define/contract (attendance student-id meeting-id)
  (-> number? number? (or/c attendance?
                            no-attendance?))
  (show "attendance" (~a student-id "_" meeting-id)))


(define/contract (topic-assignment id)
  (-> number? topic-assignment?)
  (show "topic_assignment" id))

(define (meeting id)
  (show "meeting" id))

(define/contract (meetings h)
  (-> course? (listof meeting?))
  (map (curryr set-type "meeting") (hash-ref h 'meetings #f)))

(define/contract (topic-assignments h)
  (-> course? (listof topic-assignment?))
  (map (curryr set-type "topic_assignment")
       (hash-ref h 'topic_assignments)))

(define/contract (set-meetings c m)
  (-> course? (listof meeting?) course?)
  (hash-set c 'meetings m))

(define/contract (attendances m)
  (-> meeting? (listof attendance?))
  (map (curryr set-type "attendance")
       (hash-ref m 'attendances)))

(define/contract (course-id m)
  (-> meeting? number?)
  (hash-ref m 'course_id))


(define/contract (backup-url a)
  (-> attendance? (or/c string? #f))

  (hash-ref a 'backup_url #f))

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

(define/contract (every-t-appearance course)
  (-> course? list?)
  (define m (hash-ref course 'meetings))
  (define (get-meeting-teachers meeting-list day)
    (cond
      [(>= day (length meeting-list)) '()]
      [else (append (hash-ref (list-ref meeting-list day) 'teachers)
                    (get-meeting-teachers meeting-list (+ day 1)))])
    )
    (map t-first-name (flatten (get-meeting-teachers m 0)))
  )

(define/contract (all-t-names course)
  (-> course? (listof string?))
  (define t-list (teachers course))
  (cond
    [(null? t-list) (list "no teacher")]
    [else (map t-first-name t-list)]))

(define (t-first-name teacher)
  (hash-ref teacher 'first_name))

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





(define (make-course-with-meetings-from-bundle! bundle id price duration foreign-url . meeting-times)
  (define c
    (apply (curry make-course-with-meetings! (first bundle)
                (second bundle)
                id
                price
                duration
                foreign-url
                (third bundle))
 
         (flatten meeting-times)))


  (save-topics!
   (add-topics c
               (fourth bundle)))
  
  c)

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




(define/contract (start-time m [adj 7])
  (->* (meeting?) (number?) moment?)

  (define s (hash-ref m 'start_time))

  (if (string? s)
      (-hours
       (iso8601->moment
        s)
       adj)
      s))

(define/contract (end-time m (adj 7))
  (->* (meeting?) (number?) moment?)


  (define s (hash-ref m 'end_time))

  (if (string? s)
      (-hours
       (iso8601->moment
        s)
       adj)
      s))



(define (->nice-date t)
  (-> moment? string?)

  (~t t "M/d"))

(define (->nice-time t)
  (-> moment? string?)

  (~t t "h:mma"))

(define (->day-of-week t)
  (-> moment? string?)

  (~t t "EEEE"))

(define/contract (->nice-start-year m)
  (-> meeting? string?)
  (define start-year (hash-ref m 'start_time))
  (if (equal? start-year 'null) "N/A" (substring start-year 0 4)))

(define/contract (->nice-full-date m)
  (-> meeting? string?)
  (define start-date (hash-ref m 'start_time))
  (if (equal? start-date 'null)
      "N/A"
      (~a (substring start-date 5 7) "/"
          (substring start-date 8 10) "/"
          (substring start-date 0 4))))

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



#;(define/contract (roster course)
  (-> course? image?)
  (build-roster (students course)))

#;(define/contract (build-roster students)
  (-> (listof student?) image)
  ())

(define (date-strings->dates time s)
  (define (->better-date-string time-string)
    (λ(date-string)
      (define month-num (first  (string-split date-string "/")))
      (define day-num   (second (string-split date-string "/")))
      (define year-num (third  (string-split date-string "/")))
      (~a (~a year-num)
          "-"
          (~a month-num #:width 2 #:align 'right #:pad-string "0")
          "-"
          (~a day-num #:width 2 #:align 'right #:pad-string "0")
          " " time-string)))

  (define meetings-string s)
  (define date-strings (string-split meetings-string ", "))
  (define better-date-strings (map (->better-date-string time) date-strings))
  (define dates (map string->time better-date-strings))

  dates)

;to change times for all meetings in a course
(define/contract (change-meeting-times f c)
  (-> procedure? course? course?)

  (hash-set c 'meetings (map f (meetings c))))

;option to pass in to change-meeting-times
(define (add-hours h)
  (lambda (m)
    (define start (+hours (start-time m 0) h))
    (define end   (+hours (end-time m 0) h))

    (~> m
        (hash-set _ 'start_time (moment->iso8601 start))
        (hash-set _ 'end_time   (moment->iso8601 end)))
    ))

;option to pass in to change-meeting-times
(define (add-minutes mins)
  (lambda (m)
    (define start (+minutes (start-time m 0) mins))
    (define end   (+minutes (end-time m 0) mins))

    (~> m
        (hash-set _ 'start_time (moment->iso8601 start))
        (hash-set _ 'end_time   (moment->iso8601 end)))
    ))

;option to pass in to change-meeting-times
(define (set-minutes minutes)
  (lambda (m)
    (define end (+minutes (start-time m 0) minutes))

    (~> m
        (hash-set _ 'end_time   (moment->iso8601 end)))
    ))

