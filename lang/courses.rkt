#lang racket

(require "./util.rkt"
         "./constants.rkt"
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


(define (half-width-plus n i)
  (+ n (/ (image-width i) 2)))

(define (half-height-plus n i)
  (+ n (/ (image-height i) 2)))

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


(define (bold-text s size color)
  (text/font s size color  "Helvetica" 'swiss 'normal 'bold #f))


(define (chunks n l)
  (if (<= (length l) n)
      (list l)
      (cons (take l n) (chunks n (drop l n)))))



(define (newline-every n s)
  (define words (chunks n (string-split s " ")))

  (regexp-replace* 
   #rx" \n "

   (string-join
    (flatten (add-between words (list "\n")))
    " ")
   "\n"))



(define spacer
  (circle 20 "solid" "transparent"))
 

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

  (define bg (bitmap "resources/bg.png"))

  (define bg-with-title
    (place-image
     (bold-text (~a "Coding Club: " grade-level) 80 "white")
     (/ (image-width bg) 2)
     900
     bg))


  (define (string->bullet s)
    (beside/align "top"
     (text "•  " 60 "white")
     (text s 60 "white")))


  (define bullets
    (above/align "left"
                 (string->bullet
                  (newline-every 9
                                 (first selling-points)))
                 spacer
                 (string->bullet
                  (newline-every 9
                                 (second selling-points)))
                 spacer
                 (string->bullet
                  (newline-every 9
                                 (third selling-points)))))

  (define with-bullets
    (place-image
     bullets
     (+ 150 (/ (image-width bullets) 2))
     1350
     bg-with-title))


  (define with-course-title
    (place-image
     #;(text course-title 80 "white")
     (bold-text	course-title	 	 	 	 
                80	 	 	 	 
                "white")	
     (/ (image-width bg) 2)
     1050
     with-bullets))

  (define with-time-and-price
    (place-image
     (text (~a duration " weeks (" start " - " end ") | $" price)
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

  (do-flier-footer with-table-headers location-details time-details register-url))


(define (do-flier-footer flier-img location-details time-details register-url)
  (define flier-img-with-footer
    (place-image
     (above/align "left"
                  (text (~a (first location-details)
                            " at "
                            (second location-details)
                            ; " | "
                            ;(third location-details)
                            ) 60 "white")
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
     flier-img))

  flier-img-with-footer)


(define (make-flier-double-panel course-title
                                 grade-level
                                 selling-points
                                 duration
                                 start
                                 end
                                 price
                                 time-details

                                 course-title1
                                 grade-level1
                                 selling-points1
                                 duration1
                                 start1
                                 end1
                                 price1
                                 time-details1
                                 
                                 location-details
                                 register-url)

  (define bg (bitmap "resources/bg-double-panel.png"))

  (define (string->bullet s)
    (text (~a "•  " s) 60 "white"))

  (define spacer
    (circle 20 "solid" "transparent"))

  (define bullets
    (above/align "left"
                 (string->bullet
                  (newline-every 4
                                 (first selling-points)))
                 spacer
                 (string->bullet
                  (newline-every 4
                                 (second selling-points)))
                 spacer
                 (string->bullet
                  (newline-every 4
                                 (third selling-points)))))

  (define bullets1
    (above/align "left"
                 (string->bullet
                  (newline-every 4
                                 (first selling-points1)))
                 spacer
                 (string->bullet
                  (newline-every 4
                                 (second selling-points1)))
                 spacer
                 (string->bullet
                  (newline-every 4
                                 (third selling-points1)))))

  (define with-bullets
    (place-image
     (scale 0.8 bullets)
     (+ 100 (/ (image-width (scale 0.8 bullets)) 2))
     (+ (/ (image-height (scale 0.8 bullets)) 2) 1970)
     bg))

  (define with-bullets1
    (place-image
     (scale 0.8 bullets1)
     (+ 1730 (/ (image-width (scale 0.8 bullets1)) 2))
     (+ (/ (image-height (scale 0.8 bullets1)) 2) 1970)
     with-bullets))

  (define title-img (scale 0.8 (bold-text (filter-out-words
                                           course-title
                                           '("K-2" "K-2nd" "3rd-6th" "3-6th" "Studio"))
                                          65 "white")))
  (define with-course-title
    (place-image
     title-img
     (half-width-plus 100 title-img)
     1920
     with-bullets1))

  (define title-img1 (scale 0.8 (bold-text (filter-out-words
                                            course-title1
                                            '("K-2" "K-2nd" "3rd-6th" "3-6th" "Studio"))
                                           65 "white")))
  (define with-course-title1
    (place-image
     title-img1
     (half-width-plus 1730 title-img1)
     1920
     with-course-title))

  (define time-and-price (text (~a duration " weeks (" start " - " end ") | $" price )
                               55 "white"))
  (define with-time-and-price
    (place-image
     time-and-price
     (half-width-plus 100 time-and-price)
     2660
     with-course-title1))

  (define time-and-price1 (text (~a duration " weeks (" start1 " - " end1 ") | $" price1 )
                                55 "white"))
   (define with-time-and-price1
    (place-image
     time-and-price1
     (half-width-plus 1730 time-and-price)
     2660
     with-time-and-price))


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
     with-time-and-price1)
    )

  (do-flier-footer with-table-headers location-details time-details register-url))


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

  (~t t "h:ma"))

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


(define (filter-out-words s l)
  (if (empty? l)
      s
      (filter-out-words (string-replace s (first l) "" #:all? #t)
                        (rest l))))

(define (string->slug s)
  (define (filter-out-school-words s)
    (filter-out-words s '("elementary" "academy" "school")))
  
  (string-replace #:all? #t
                  (string-trim
                   (filter-out-school-words
                    (string-downcase s)) #rx"\\s+")
  " "
  "-"))

(define (refinery-link c)
  (~a "https://www.thoughtstem.com/" (slug-name c)))

(define (slug-name c)
  (string->slug
   (name
    (location
     (room c)))))

(define (k-2nd? c)
  (string=?
   (grade-level c)
   "K-2nd"))

(define (selling-points c)

  
  (if (k-2nd? c)
      k-2nd-selling-points
      3rd-5th-selling-points)

  )


(define (course->flier c
                       (selling-points (selling-points c))
                       (registration-link "https://secure.thoughtstem.com"))
  (make-flier (name c)
              (grade-level c)

              ;TODO: Come back to this
              selling-points

              (length (meetings c))
              (->nice-date
               (start-time (first (meetings c))))
              (->nice-date
               (end-time (last (meetings c))))
            
              (price c)
            
              (list
               (room-number (room c))
               (name (location (room c)))
               (address (location (room c))))

              (list (->day-of-week
                     (start-time (first (meetings c))))

                    
                    (->nice-time
                     (start-time (first (meetings c))))
                    (->nice-time
                     (end-time (first (meetings c)))))

              ;TODO: Figure out how to generate this...
              registration-link))

(define (courses->flier c1
                        c2
                        (selling-points1 (selling-points c1))
                        (selling-points2 (selling-points c2))
                        (registration-link "https://secure.thoughtstem.com"))
  
  (make-flier-double-panel

   ;Course 1 Details
   (name c1)
   (grade-level c1)
   selling-points1
   (length (meetings c1))
   (->nice-date
    (start-time (first (meetings c1))))
   (->nice-date
    (end-time (last (meetings c1))))
   (price c1)
   (list (->day-of-week
          (start-time (first (meetings c1))))
         (->nice-time
          (start-time (first (meetings c1))))
         (->nice-time
          (end-time (first (meetings c1)))))

   ;Course 2 Details
   (name c2)
   (grade-level c2)
   selling-points2
   (length (meetings c2))
   (->nice-date
    (start-time (first (meetings c2))))
   (->nice-date
    (end-time (last (meetings c2))))
   (price c2)
   (list (->day-of-week
          (start-time (first (meetings c2))))

                    
         (->nice-time
          (start-time (first (meetings c2))))
         (->nice-time
          (end-time (first (meetings c2)))))

   ;Location Details
   (list
    (room-number (room c1))
    (name (location (room c1)))
    (address (location (room c1))))
                           
   registration-link))

