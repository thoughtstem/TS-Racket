#lang racket

(require "./courses.rkt"
         "./students.rkt"
         "./util.rkt"
         (except-in pict scale-to-fit bitmap)
         (only-in 2htdp/image bitmap)
         pict/color)

;(set-env! PROD)

(provide (all-defined-out))

(define green-check (rotate
                     (vl-append
                      (filled-rectangle 6
                                        10
                                        #:color "green"
                                        #:border-color "green")
                      (filled-rectangle 40
                                        6
                                        #:color "green"
                                        #:border-color "green"))
                     (/ pi 3))
 )

(define red-x (cc-superimpose
               (rotate
                (filled-rectangle 40
                                  6
                                  #:color "red"
                                  #:border-color "red")
                (/ pi 3))
               (rotate
                (filled-rectangle 40
                                  6
                                  #:color "red"
                                  #:border-color "red")
                (/ pi 1.5)))
  )
;Will need to change path of camera.png if this file is moved
(define camera-pict (scale (bitmap "resources/camera.png") .5))
(define logo-pict   (scale (bitmap "resources/ts-logo-name.png").25))
(define pizza-pict  (inset (bitmap "resources/pizza-sprite.png") 2))

(define filler-title       "Marvel Course")
(define filler-course-num  "03000")
(define filler-instructors "Nick Fury")
(define filler-location    "Wakanda")
(define filler-room        "Battlefield")
(define filler-time        "12am - forever...")
(define filler-year        "N/A")

;##################|Useful Functions|##################;
;Removes trailing \n characters
(define (remove-trailing-whitespace this-string)
  (cond
    [(<= (string-length this-string) 0) "N/A"]
    [(or (equal? (substring this-string (- (string-length this-string) 1) (string-length this-string)) "\n")
         (equal? (substring this-string (- (string-length this-string) 1) (string-length this-string)) "\t")
         (equal? (substring this-string (- (string-length this-string) 1) (string-length this-string)) "\r")
         (equal? (substring this-string (- (string-length this-string) 1) (string-length this-string)) " "))
     (remove-trailing-whitespace (substring this-string 0 (- (string-length this-string) 1)))]
    [else this-string]
  ))

;Saves a pict as a png
(define (save-pict this-pict name)
  (send (pict->bitmap this-pict) save-file name 'png))
  
;Creates a box surrounding a pict
(define (make-pict-box this-pict width height)
  (cc-superimpose (gray (rectangle (+ width 10)
                                   (+ height 10)))
                  this-pict)
  )
  
;Creates a text box given a string and width
(define (make-text-box string width)
  (define text-pict (wrap-pict-text string width))
  (lc-superimpose (gray (rectangle (+ width 10) (+ (pict-height text-pict) 10)))
                  (hc-append (blank 5)text-pict))
  )
;Creates a text box given a string, width, and height
(define (make-text-box-height string width height)
  (define text-pict (wrap-pict-text string width))
  (lc-superimpose (gray (rectangle (+ width 10) height))
                  (hc-append (blank 5) text-pict))
  )
;Creates a colored text box given a string, width, and height
(define (make-colored-text-box string width height color)
  (define text-pict (colorize (wrap-pict-text string width) "white"))
  (cc-superimpose (filled-rectangle (+ width 10) height
                                    #:color color
                                    #:border-color (dark "white"))
                  text-pict)
  )
;Creates a colored, bold text box given a string, width, and height
(define (make-bold-colored-text-box string width height color)
  (define text-pict (colorize (wrap-bold-pict-text string width) "white"))
  (cc-superimpose (filled-rectangle (+ width 10) height
                                    #:color color
                                    #:border-color (dark "white"))
                  text-pict)
  )
;Creates a text pict with wrapped text given a string and width
(define (wrap-pict-text string width)
  (define text-pict (text string))
  (cond
    [(>= (pict-width text-pict) width)                   ;Check for pict width vs allowed
     (vl-append (text (find-wrap-line string width 0 0))   
                (wrap-pict-text (substring string
                                           (string-length (find-wrap-line string width 0 0))
                                           (string-length string))
                                width))]
    [(equal? string "") (blank 1)]                       ;Remove any blank lines
    [else text-pict]                                     ;Return the current text-pict
  ))

(define (wrap-bold-pict-text string width)
  (define text-pict (text string (cons 'bold null)))
  (cond
    [(>= (pict-width text-pict) width)                   ;Check for pict width vs allowed
     (vl-append (text (find-wrap-line string width 0 0) (cons 'bold null))   
                (wrap-pict-text (substring string
                                           (string-length (find-bold-wrap-line string width 0 0))
                                           (string-length string))
                                width))]
    [(equal? string "") (blank 1)]                       ;Remove any blank lines
    [else text-pict]                                     ;Return the current text-pict
  ))

;If the a word in a string doesn't fit, then this function becomes an infinite loop
(define (find-wrap-line string width pointer last)
  (cond
    [(equal? (string-ref string 0) #\ )                        ;Get rid of leading spaces
     (string-append (find-wrap-line (substring string 1) width pointer last) " ")]
    [(eqv? pointer (string-length string))                     ;Check for end of string
     (cond
       [(<= width (pict-width (text string))) (substring string 0 last)]
       [else string]
       )]
    [(equal? (string-ref string pointer) #\ )                  ;Check for word
     (cond
       [(< (pict-width (text (substring string 0 pointer))) width);Check for pict < width
        (find-wrap-line string width (+ pointer 1) pointer)]          ;increment pointer and save last know valid string
       [else (substring string 0 last)]               ;Check for pict >= width
     )]
    [else (find-wrap-line string width (+ pointer 1) last)])   ;Else recurssion
  )

(define (find-bold-wrap-line string width pointer last)
  (cond
    [(equal? (string-ref string 0) #\ )                        ;Get rid of leading spaces
     (string-append (find-wrap-line (substring string 1) width pointer last) " ")]
    [(eqv? pointer (string-length string))                     ;Check for end of string
     (cond
       [(<= width (pict-width (text string (cons 'bold null)))) (substring string 0 last)]
       [else string]
       )]
    [(equal? (string-ref string pointer) #\ )                  ;Check for word
     (cond
       [(< (pict-width (text (substring string 0 pointer) (cons 'bold null))) width);Check for pict < width
        (find-wrap-line string width (+ pointer 1) pointer)]          ;increment pointer and save last know valid string
       [else (substring string 0 last)]               ;Check for pict >= width
     )]
    [else (find-wrap-line string width (+ pointer 1) last)])   ;Else recurssion
  )

;##################|Header Code|##################;
(define (find-reoccuring-teachers course-object)
  (define total-teachers (every-t-appearance course-object))
  (define (get-teachers teacher-list test-list return-list index)
    (cond
      [(>= index (length teacher-list)) return-list]
      [(not (member (list-ref teacher-list index) test-list)) (get-teachers teacher-list
                                                                            (flatten(append test-list (list-ref teacher-list index)))
                                                                            return-list
                                                                            (+ index 1))]
      [(and (member (list-ref teacher-list index) test-list)
            (not (member (list-ref teacher-list index) return-list)))(get-teachers teacher-list
                                                                            test-list
                                                                            (flatten(append return-list (list-ref teacher-list index)))
                                                                            (+ index 1))]
      [else (get-teachers teacher-list
                          test-list
                          return-list
                          (+ index 1))])
    )
  (format-teacher-names (get-teachers total-teachers '() '() 0))
  )
(define (format-teacher-names teacher-list)
   (apply string-append (cdr ( append*
                               (map (lambda (x) (list ", " x))
                                    teacher-list)
                               ))))

(define (get-meeting-time course day)
  (define d day)
  (cond [(>= d 0)]
        [else (set! d 0)])
   (string-append (->nice-time (start-time (list-ref (meetings course)  d)))
                  "-"
                  (->nice-time (end-time (list-ref (meetings course) d)))
                  ))

#;(define (get-meeting-day course day)
  (define d day)
  (cond [(>= d 0)]
        [else (set! d 0)])
   (->day-of-week (start-time (list-ref (meetings course)  d))))

(define (get-start-year course)
  (define m (list-ref (meetings course) 0))
  (->nice-start-year m))

(define (get-start-date course)
  (define m (list-ref (meetings course) 0))
  (->nice-full-date m))

(define (make-roster-header course-number course-day body-width)
  (define title-pict       (text (string-append "Course Name:  " filler-title)))
  (define course-num-pict  (text (string-append "Course Number: " filler-course-num)))
  (define coach-day-pict   (text (string-append "Coaches: " filler-instructors)))
  (define lr-label-pict    (text (string-append "Location: " filler-location)))
  (define loc-room-pict    (text (string-append "Room: " filler-room)))
  (define coach-time-pict  (text (string-append "Time: " filler-time)))
  (define start-year-pict  (text (string-append "Start Date:" filler-year)))
  (define course-object    "")
  
  (cond
    [(eqv? course-number -1)];Do nothing
    [else                    ;Reset to new things
     (set! course-object    (course course-number))
     (set! title-pict       (wrap-bold-pict-text (name course-object) (- (/ body-width 1.5) (pict-width logo-pict))))
     (set! course-num-pict  (hc-append (blank 1)(colorize (text "Course Number: ") (dark "gray")) (text (number->string course-number) (cons 'bold null))))
     (set! start-year-pict (hc-append (colorize (text "Start Date: ") (dark "gray")) (text (get-start-date course-object) (cons 'bold null))))
     (set! coach-day-pict   (vr-append (colorize (text "Coaches:")  (dark "gray"))                       (blank 1)(colorize (text "Time:") (dark "gray"))))
     (set! lr-label-pict    (vr-append (colorize (text "Location:") (dark "gray"))                       (blank 1)(colorize (text "Room:") (dark "gray"))))
     (set! loc-room-pict    (vl-append (text (name (location (room course-object)))   (cons 'bold null)) (blank 1) (text (room-number (room course-object))          (cons 'bold null))))
     (set! coach-time-pict  (vl-append (text (find-reoccuring-teachers course-object) (cons 'bold null)) (blank 1) (text (get-meeting-time course-object course-day) (cons 'bold null))))
     ;Assemble the pict
     (blank 50)
     ])
  ;Assemble the pict
  
  (scale
    (rb-superimpose
     (vl-append (lb-superimpose
                  (vr-append
                   logo-pict
                   (colorize (hline (/ body-width 1.5) 2) (dark "green")))
                  (vl-append
                   (colorize (scale title-pict 1.5) (dark "green"))
                   (hc-append
                    (colorize course-num-pict (dark "gray"))
                    (blank 5)
                    (blank 5)
                    (blank 5)
                    (colorize start-year-pict (dark "gray")))
                   (blank 10)))
                (blank 2)
                (hb-append
                 (blank 2)
                 (colorize coach-day-pict (dark "gray"))
                 (blank 4)
                 (colorize coach-time-pict (dark "gray"))))
    
     (hb-append (colorize lr-label-pict (dark "gray"))
                (blank 4)
                (colorize loc-room-pict (dark "gray"))
                (blank 2)))
   1.5
   )
  
  )

;##################|Body Code|##################;
;Creates a label row
(define (make-label-row meeting-list)
  (define meeting-list-length (length meeting-list))
  (define row-height 40)
  (define my-green (dark "green"))
  (hb-append (make-colored-text-box ""
                                    20
                                    row-height
                                    my-green)
             (make-bold-colored-text-box "Photo?"
                                    (+ (pict-width camera-pict) 10)
                                    row-height
                                    my-green)
             (make-bold-colored-text-box "Student Name"
                                    150
                                    row-height
                                    my-green)
             (make-bold-colored-text-box "Age"
                                    30
                                    row-height
                                    my-green)
             (vc-append (make-bold-colored-text-box "Attendance"
                                               (- (* (+ (pict-width green-check) 10)
                                                     meeting-list-length) 10)
                                               20
                                               my-green)
                        (get-course-dates meeting-list (-(length meeting-list)1))
                        (get-course-days  meeting-list (-(length meeting-list)1)))
             (make-bold-colored-text-box "Parent Name"
                                    150
                                    row-height
                                    my-green)
             (make-bold-colored-text-box "Parent Phone"
                                    100
                                    row-height
                                    my-green)
             (make-bold-colored-text-box "Notes"
                                    200
                                    row-height
                                    my-green)
             )
  )

;Takes in a course and returns a list of the days of the meetings
(define (get-course-days meeting-list days)
  (define this-moment (start-time (list-ref meeting-list days)))
  (define shorthand-day (cond [(equal? (->day-of-week this-moment) "Monday")    "Mon"]
                              [(equal? (->day-of-week this-moment) "Tuesday")   "Tue"]
                              [(equal? (->day-of-week this-moment) "Wednesday") "Wed"]
                              [(equal? (->day-of-week this-moment) "Thursday")  "Thu"]
                              [(equal? (->day-of-week this-moment) "Friday")    "Fri"]
                              [(equal? (->day-of-week this-moment) "Saturday")  "Sat"]
                              [(equal? (->day-of-week this-moment) "Sunday")    "Sun"]
                              [else "N/A"]))
  
  (cond
    [(eq? days 0) (make-bold-colored-text-box shorthand-day
                                         (pict-width green-check)
                                         20
                                         (dark "green"))]
    [else (hc-append
           (get-course-days meeting-list (- days 1) )
           (make-bold-colored-text-box shorthand-day
                                  (pict-width green-check)
                                  20
                                  (dark "green")))
          ])
   
  )

;Takes in a course and returns a list of the dates of the meetings
(define (get-course-dates meeting-list days)
   (define this-moment (start-time (list-ref meeting-list days)))
   (cond
     [(eq? days 0) (make-bold-colored-text-box (->nice-date this-moment)
                                          (pict-width green-check)
                                          20
                                          (dark "green"))]
     [else (hc-append
            (get-course-dates meeting-list (- days 1) )
            (make-bold-colored-text-box (->nice-date this-moment)
                                   (pict-width green-check)
                                   20
                                   (dark "green")))
      ])
   
   )

;Creates a student index text box
(define (make-student-index index height)
  (make-bold-colored-text-box (number->string (+ index 1))
                                  20
                                  height
                                  (dark "green"))
  )

;Creates a student photo eligible box
(define (make-student-photo-e students-list student-index height)
  (define h 0)
  (cond [(> height (+ (pict-height green-check) 10)) (set! h (- height 10))]
        [else (set! h (pict-height green-check))])

  (cond [(photo-release? (list-ref students-list student-index))
         (make-pict-box camera-pict  (+ (pict-width camera-pict) 10) h)]
        [else (make-pict-box (cc-superimpose
                              (scale (bitmap "resources/camera.png") .5)
                              red-x)
                              (+ (pict-width camera-pict) 10) h)])
        )

;Creates a student name text box
(define (make-student-name students-list student-index height)
  (define name (student-list (list-ref students-list student-index)))
  (make-text-box-height name
                        150
                        height)
  )

;Creates a student age text box
(define (make-student-age students-list student-index height)
  (define student-age "0")
  (if (equal? 'null (list-ref students-list student-index))
      (set! student-age "0")
      (set! student-age (number->string(age (list-ref students-list student-index)))))
  (make-text-box-height student-age
                        30
                        height)
  )

;Creates a student attendance box set
(define (make-student-attendances student meeting-list day height)
  (define this-attendance 'null)
  (cond
    [(< day 0)]
    [else
     (define meeting-num (meeting-id (list-ref meeting-list day)))
     (define student-num (student-id student))
     (set! this-attendance (attendance student-num meeting-num))
     ])
  (define h 0)
  (cond [(> height (+ (pict-height green-check) 10)) (set! h (- height 10))]
        [else (set! h (pict-height green-check))])
  (cond ;Recursive conditional
    [(< day 0) (blank 0)]
    [(eq? day 0)
     (cond [(eq? this-attendance "")
            (make-pict-box red-x (pict-width green-check) h)]
           [else (make-pict-box green-check (pict-width green-check) h)])
     ]
    [else (hc-append (make-student-attendances student meeting-list (- day 1) height)
                     (cond [(eq? this-attendance "")
                            (make-pict-box red-x (pict-width green-check) h)]
                           [else (make-pict-box green-check (pict-width green-check) h)]))
          ]
    )
  )

;Creates the rest of the attendance boxes
(define (make-rest-attendances meeting-list day height)
  (define h 0)
  (cond [(> height (+ (pict-height green-check) 10)) (set! h (- height 10))]
        [else (set! h (pict-height green-check))])
  (cond
    [(< day 0) (hc-append (make-pict-box (blank 10) (pict-width green-check) h)
                          (make-rest-attendances meeting-list 0 height))]
    [(>= (+ day 1) (length meeting-list)) (blank 0)]
    [else (hc-append (make-pict-box (blank 10) (pict-width green-check) h)
                     (make-rest-attendances meeting-list (+ day 1) height))])
  )

;Creates a parent name text box
(define (make-parent-name students-list student-index height)
  (define name (parent-name (list-ref students-list student-index)))
  (make-text-box-height name
                        150
                        height)
  )

;Creates a parent phone text box
(define (make-parent-phone students-list student-index height)
  (define phone-number (format-parent-phone
                         (parent-phone
                          (list-ref students-list student-index))))
  (make-text-box-height phone-number
                        100
                        height)
  )

;Removed all the "-", "(", and ")" substrings from a string
(define (format-parent-phone number)
  (define phone-number
    (string-replace
     (string-replace
      (string-replace
       (string-replace number "-" "") ;dashes
       "(" "")                        ;open paren
      ")" "")                         ;close paren
     "/" " "))

  (if (eq? (string-length phone-number) 10)
  (string-append "(" (substring phone-number 0 3) ") "
                 (substring phone-number 3 6) "-"
                 (substring phone-number 6 10))
  phone-number)
  )

(define (maybe-pizza-box str)
  (if (string-contains? (string-downcase str) "pizza: yes")
      (rb-superimpose (make-text-box (string-replace str "Permission to get pizza: Yes." "") 200)
                      pizza-pict)
      (make-text-box (string-replace str "Permission to get pizza: No." "") 200)))

(define (maybe-pizza-box-height str)
  (if (string-contains? (string-downcase str) "pizza: yes")
      (rb-superimpose (make-text-box-height (string-replace str "Permission to get pizza: Yes." "") 200 (+ (pict-height green-check) 10))
                      pizza-pict)
      (make-text-box-height (string-replace str "Permission to get pizza: No." "") 200 (+ (pict-height green-check) 10))))

;Health notes stuff
;Creates a health notes text box
(define (make-health-notes students-list student-index width)
  (define student-med-notes (map (compose (curryr string-replace "\n" "")
                                          remove-trailing-whitespace
                                          format-medical-notes
                                          (curryr hash-ref 'note))
                                 (student-notes
                                  (list-ref students-list
                                            student-index))))
  (define pict-list (map maybe-pizza-box student-med-notes))
  (define notes-pict (if (empty? pict-list)
                         (make-text-box "" 200)
                         (apply vl-append pict-list)))

  (cond [(> (+ (pict-height green-check) 10) (pict-height notes-pict))
         (if (and (= (length student-med-notes) 1)
                  (equal? (first student-med-notes) "N/A"))
             (colorize (make-text-box-height (first student-med-notes) 200 (+(pict-height green-check) 10)) (dark "gray"))
             (if (empty? student-med-notes)
                 (make-text-box-height "" 200 (+(pict-height green-check) 10))
                 (apply vl-append (map maybe-pizza-box-height student-med-notes))))]
        [else notes-pict])
  )

;If a string is an empty string then this function returns "N/A"
(define (format-medical-notes notes)
   (define tmp-notes (string-downcase (string-replace notes " " "")))
   (cond
     [(or (equal? notes "")
          (equal? tmp-notes "none")
          (equal? tmp-notes "no")
          (equal? tmp-notes "nope")
          (equal? tmp-notes "nada")
          (equal? tmp-notes "non")) "N/A"]
     [else notes])
   )
;##################|Assembling Pict Code|##################;
;THIS FUNCTION DOES NOT WORK
;Organizes students in alphabetical order
#;(define (alphabetize-list students-list best-list original-size)
  (define first-student (get-student-alphabetically students-list 0 0))
  (cond [(< (length best-list) original-size)
         (append best-list (list first-student))
         (alphabetize-list (remove first-student students-list) best-list original-size)]
        [else best-list])
  )

;THIS FUNCTION DOES NOT WORK
;Returns the index of the first student alphabetically
#;(define (get-student-alphabetically students-list student-index best-index)
  (define student-name "zzzzzzzzzzz")
  (define best-name "zzzzzzzzzzz")
  (cond [(>= student-index (length students-list))]
        [else
         (set! student-name (first-name (list-ref students-list student-index)))
         (set! best-name    (first-name (list-ref students-list best-index)))])
  (cond [(eq? 0 (length students-list)) '()]
        [(>= student-index (length students-list)) (list-ref students-list best-index)]
        [(string<=? student-name best-name) (get-student-alphabetically students-list (+ student-index 1) student-index)]
        [else (get-student-alphabetically students-list (+ student-index 1) best-index)])
  )

;Builds a student
(define (assemble-student meeting-list students-list student-index day)

  (cond [(equal? students-list (list )) (blank 0)] 
        [else
  (define health-notes-pict (make-health-notes students-list student-index 100))
  
  (hc-append (make-student-index   student-index                              ;index
                                   (pict-height health-notes-pict))
             (make-student-photo-e students-list                              ;photo eligible
                                   student-index
                                   (pict-height health-notes-pict))
             (make-student-name    students-list                              ;student name
                                   student-index
                                   (pict-height health-notes-pict))
             (make-student-age     students-list                              ;student age
                                   student-index
                                   (pict-height health-notes-pict))
             (make-student-attendances (list-ref students-list student-index) ;attendances
                                       meeting-list
                                       day
                                       (pict-height health-notes-pict))
             (make-rest-attendances    meeting-list
                                       day
                                       (pict-height health-notes-pict))
             (make-parent-name   students-list                                ;parent name
                                 student-index
                                 (pict-height health-notes-pict))
             (make-parent-phone  students-list                                ;parent phone
                                 student-index
                                 (pict-height health-notes-pict))
             health-notes-pict                                                ;medical notes
             )])
  )


;Builds all students

(define (assemble-all-students meeting-list students-list student-index day)
  (cond
    [(equal? students-list (list )) (blank 0)]
    [(eq? (+ student-index 1) (length students-list))
     (assemble-student meeting-list students-list student-index day)]
    [else (vl-append (assemble-student meeting-list students-list student-index day)
                     (assemble-all-students meeting-list students-list (+ student-index 1) day))
          ])
  )
;Builds the roster body
(define (assemble-roster-body course-number day)
  (define course-object (course   course-number))
  (define students-list (students course-object))
  ;(define canceled-list (canceled-students course-object)) ; not used yet
  (define meeting-list  (meetings course-object))
  
  (vl-append (make-label-row        meeting-list)
             (assemble-all-students meeting-list students-list 0 day))
  )

;Builds the whole roster as pict
(define/contract (assemble-roster course-number course-day)
  (-> number? number? pict?)
  (define body   (assemble-roster-body course-number course-day))
  (define header (make-roster-header course-number course-day (pict-width body)))
  (define front-roster (vc-append header
                                  body))
  (define full-roster
    (cc-superimpose (filled-rectangle (pict-width  front-roster)
                                      (pict-height front-roster)
                                      #:color "white"
                                      #:border-color "white")
                    front-roster))
    (if (> (pict-height full-roster) 1375)
        full-roster
        (ct-superimpose (filled-rectangle (pict-width  front-roster)
                                          1375
                                          #:color "white"
                                          #:border-color "white")
                        full-roster))
  )
;Builds roster as a single image
(define (print-roster course-number)
  ;(-> number? bitmap?)
  (pict->bitmap (assemble-roster course-number -1)))

(define (print-completed-roster course-number meetings)
  ;(-> number? bitmap?)
  (pict->bitmap (assemble-roster course-number (- meetings 1))))

;Saves roster as a PNG
(define (save-roster course-number)
  (save-pict (assemble-roster course-number -1) (string-append (number->string course-number) "-roster.png")))

           