#lang racket


(require "./util.rkt"
         "./constants.rkt"
         2htdp/image
         (only-in "./courses.rkt"
                  location
                  room
                  meetings
                  ->nice-date
                  start-time
                  end-time
                  price
                  room-number
                  address
                  ->day-of-week
                  ->nice-time
                  k-2nd?
                  grade-level))

(provide course->flier
         courses->flier
         course->flyer
         courses->flyer)

(module+ test
  (require rackunit))



;grabs selling-points for each grade level from constants.rkt
(define/contract (selling-points c)
  (-> course? list?)
  (if (k-2nd? c)
      k-2nd-selling-points
      3rd-5th-selling-points))

;functions to assist building flyer
(define/contract (bold-text s size color)
  (-> string? number? string? image?)
  (text/font s size color  "Helvetica" 'swiss 'normal 'bold #f))

(define/contract (newline-every n s)
  (-> number? string? string?)
  (define words (chunks n (string-split s " ")))

  (regexp-replace* 
   #rx" \n "

   (string-join
    (flatten (add-between words (list "\n")))
    " ")
   "\n"))

(module+ test
  (check-equal?
   (newline-every 5 "hello world this is stephen")
   "hello\nworld\nthis is\nstephen"))

(define spacer
  (circle 20 "solid" "transparent"))

(define/contract (half-width-plus n i)
  (-> number? image? number?)
  (+ n (/ (image-width i) 2)))

(define/contract (half-height-plus n i)
  (-> number? image? number?)
  (+ n (/ (image-height i) 2)))

(define/contract (do-flier-footer location-details time-details register-url)
  (-> list? list? string? image?)
  (define headers
    (above/align "left"
                 (text "LOCATION:" 60 "white")
                 spacer
                 (text "DAY & TIME:" 60 "white")
                 spacer
                 (text "GRADES:" 60 "white")
                 spacer
                 (text "REGISTER:" 60 "white")
                 spacer
                 (text "CONTACT US:" 60 "white")))
  (beside headers
          
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
                       (text "(858) 869-9430 | contact@thoughtstem.com | www.thoughtstem.com" 60 "white"))))

(define/contract (filter-out-words s l)
  (-> string? list? string?)
  (if (empty? l)
      s
      (filter-out-words (string-replace s (first l) "" #:all? #t)
                        (rest l))))

(define/contract (string->slug s)
  (-> string? string?)
  (define (filter-out-school-words s)
    (filter-out-words s '("elementary" "academy" "school")))
  
  (string-replace #:all? #t
                  (string-trim
                   (filter-out-school-words
                    (string-downcase s)) #rx"\\s+")
  " "
  "-"))

(define/contract (refinery-link c)
  (-> string? string?)
  (~a "https://www.thoughtstem.com/" (slug-name c)))

(define/contract (slug-name c)
  (-> course? string?)
  (string->slug
   (name
    (location
     (room c)))))

;move back to course.rkt??? 
(define (superfluous-course-title-words)
  (define words
    '("K-2" "K-2nd" "3rd-6th" "3-6th" "Studio" "Coding Club:"
            "Grade" "3rd-5th" "3-5th"))

  (define :words
    (map (λ(s) (~a ": " s)) words))

  (sort
   (append :words
           words)
   (λ(a b)
     (> (string-length a)
        (string-length b)))))

;builds flyer from course info
(define/contract (make-flier course-title
                             grade-level
                             selling-points
                             duration
                             start
                             end
                             price
                             location-details
                             time-details
                             register-url)
  (-> string? string? list? number? string? string? number? list? list? string?
      image?)

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
    (scale 1.1
           (above/align "left"
                        (string->bullet
                         (newline-every 50
                                        (first selling-points)))
                        spacer
                        (string->bullet
                         (newline-every 50
                                        (second selling-points)))
                        spacer
                        (string->bullet
                         (newline-every 50
                                        (third selling-points))))))

  (define with-bullets
    (place-image
     bullets
     (half-width-plus 150 bullets)
     (half-height-plus 1150 bullets)
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


  (define footer
    (do-flier-footer location-details time-details register-url))

  (define flier-img-with-footer
    (place-image
     footer
     (half-width-plus 150 footer)
     (half-height-plus 2720 footer)
     with-time-and-price))

  flier-img-with-footer)

; build 2 course flyer
(define/contract (make-flier-double-panel course-title
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
  
  (-> string? string? list? number? string? string? number? list?
      string? string? list? number? string? string? number? list?
      list? string?
      image?)

  (define bg (bitmap "resources/bg-double-panel.png"))

  (define (string->bullet s)
    (text (~a "•  " s) 60 "white"))

  (define spacer
    (circle 20 "solid" "transparent"))

  (define bullets
    (above/align "left"
                 (string->bullet
                  (newline-every 20
                                 (first selling-points)))
                 spacer
                 (string->bullet
                  (newline-every 20
                                 (second selling-points)))
                 spacer
                 (string->bullet
                  (newline-every 20
                                 (third selling-points)))))

  (define bullets1
    (above/align "left"
                 (string->bullet
                  (newline-every 20
                                 (first selling-points1)))
                 spacer
                 (string->bullet
                  (newline-every 20
                                 (second selling-points1)))
                 spacer
                 (string->bullet
                  (newline-every 20
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

  (define header-img (bold-text (~a "CODING CLUB: " grade-level) 65 "white"))

  (define with-header
    (place-image
     header-img
     (half-width-plus 100 header-img)
     (half-height-plus 1760 header-img)
     with-bullets1))

  (define header-img1 (bold-text (~a "CODING CLUB: " grade-level1) 65 "white"))
  
  (define with-header1
    (place-image
     header-img1
     (half-width-plus 1730 header-img1)
     (half-height-plus 1760 header-img1)
     with-header))

  (define title-img (scale 0.8 (bold-text (filter-out-words
                                           course-title
                                           (superfluous-course-title-words))
                                          65 "white")))
  (define with-course-title
    (place-image
     title-img
     (half-width-plus 100 title-img)
     1920
     with-header1))

  (define title-img1 (scale 0.8 (bold-text (filter-out-words
                                            course-title1
                                            (superfluous-course-title-words))
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

  (define footer
    (do-flier-footer location-details time-details register-url))

  (define flier-img-with-footer
    (place-image
     footer
     (half-width-plus 110 footer)
     (half-height-plus 2740 footer)
     with-time-and-price1))

  flier-img-with-footer)


;one course flyer
(define/contract (course->flier c
                       (selling-points (selling-points c))
                       (registration-link "https://secure.thoughtstem.com"))
  ;correct contract for optional arguments?
  (-> course? image?)
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

;for 2 courses at one location
(define (courses->flier c1 ;course one ID
                        c2 ;course two ID
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
    (room-number (room c1)) ; does this need to have data for course 2?
    (name (location (room c1)))
    (address (location (room c1))))
                           
   registration-link))

;to account for alternate spelling

(define course->flyer course->flier)

(define courses->flyer courses->flier)

