#lang racket



(provide (all-defined-out))

(require "./util.rkt"
         "./argus/argus.rkt"
         "./courses.rkt"
        "./image-util.rkt"
         json
         pict/code
         2htdp/image
         simple-qr
         gregor
         gregor/period
         )


(define (get-password-from-student-json)
  (define SESSIONS-DIR
    (string->path
     #;"/Users/thoughtstem/sessions/sessions"
     "/home/thoughtstem/remote/sessions/sessions/"))


  ; === GET PATH OF THE MOST RECENT SESSIONS FOLDER ===
  (define (get-student-path)
    (define paths (map (lambda (p) (build-path SESSIONS-DIR p)) (directory-list SESSIONS-DIR)))
    (define dir-paths (filter-not file-exists? paths))
    (define mod-times (map file-or-directory-modify-seconds dir-paths))
    (list-ref dir-paths (index-of mod-times (apply max mod-times))))

  (define STUDENT-DATA
    (string->path
     (string-append (path->string (get-student-path)) "/data.json")))

  ; === READ DATA.JSON ===
  (define in (open-input-file STUDENT-DATA))
  (define json-hash
    (read-json in))
  (close-input-port in)

  (hash-ref json-hash 'password))



(define hidden-pw-file-path
  (~a
   (path->string (find-system-path 'home-dir))
   "/.ts-student-pw"))

(define (get-password-from-hidden-file)
  (string-trim
   (file->string
    (path->string
     (string->path hidden-pw-file-path)))))

(define (lookup-student-pw)
  (cond [(file-exists? hidden-pw-file-path)
         (get-password-from-hidden-file)]
        [(directory-exists? "/home/thoughtstem/remote/sessions/sessions/")
         (get-password-from-student-json)]
        [else (raise "~/.ts-student-pw file not found")]))

(define (student id)
  (show "student" id))

(define (password->student pw)
  (show "student" pw))

(define/contract (first-name h)
  (-> hash? (or/c string? boolean?))
  (hash-ref h 'first_name #f))

(define/contract (last-name h)
  (-> hash? (or/c string? boolean?))
  (hash-ref h 'last_name #f))

(define/contract (code-snippets h)
  (-> hash? list?)
  (map (curryr set-type "code_snippet")
       (hash-ref h 'code_snippets #f)))


(define (code-snippet key id)
  (show "code_snippet"
        (~a "no-password-needed::" key "::" id)))


(define/contract (value h)
  (-> hash? (or/c string? #f))
  (hash-ref h 'value #f))


;===== BADGES ======


;logos
(define red-logo (scale .6 (bitmap "resources/ts-logo-red.png")))
(define orange-logo (scale .5 (bitmap "resources/ts-logo-orange.png")))
(define blue-logo (scale .6 (bitmap "resources/ts-logo-blue.png")))
(define purple-logo (scale .6 (bitmap "resources/ts-logo-purple.png")))

;badge base
(define/contract (badge-bg c)
  (-> number? image?)
  (define line-c
    (cond
      [(= c 1) (color 255 35 42 255)]
      [(= c 2) (color 240 141 36 255)]
      [(= c 3) (color 120 186 65 255)]
      [(= c 4) (color 36 165 240 255)]
      [(= c 5) (color 162 36 240 255)]))
  (overlay/align "left" "bottom"
   (cond
     [(= c 1) red-logo]
     [(= c 2) orange-logo]
     [(= c 3) logo]
     [(= c 4) blue-logo]
     [(= c 5) purple-logo])
   (rectangle 400 270 "outline" (pen line-c 5 "long-dash" "round" "bevel"))))

;password getter
(define/contract (password student)
  (-> hash? string?)
  (hash-ref student 'password))

;photo release getter
(define/contract (photo-release? student)
  (-> student? boolean?)
  (define ans (hash-ref student 'photo_release #f))

  (define is-null? (eq? ans 'null))
  
  (and ans (not is-null?)))

;builds qr from student password and course id
(define/contract (qr-me stu-id crs-id)
  (-> string? number? image?)
  (define p (make-temporary-file))
  (qr-write  (~a stu-id "-" crs-id) p)
  (bitmap/file p))

(define-namespace-anchor a)



;builds badge with QR
(define/contract (build-qr-badge student
                                 crs-id
                                 (name (first-name student)))
  (->* ((and/c student? prod-preferred!) number?) (string?) image?)

  
  (define QR-and-code
    (above
     (qr-me (password student) crs-id)
     (text (~a (password student) "-" crs-id) 25 "grey")))

  
  (badge-builder student crs-id QR-and-code 45 25 name))


;builds badge -- NO QR
(define/contract (build-badge student
                              crs-id
                              (name (first-name student)))
  (->* ((and/c student? prod-preferred!) number?) (string?) image?)

  (define course-only
    (above
     (rectangle 1 20 'solid 'transparent)
     (text (number->string crs-id) 20 "gray")))

  (badge-builder student crs-id course-only 55 35 name))

;badge-builder function
(define/contract (badge-builder student
                              crs-id
                              img
                              n1
                              n2
                              name)
  (-> (and/c student? prod-preferred!) number? image? number? number? string? image?)
  (define photo-icon
    (if (photo-release? student)
      (buffer 5 (bitmap "resources/camera.png"))
      (buffer 5 (bitmap "resources/no_photo_camera.png"))))
  #;(define s (avatar-snippet student))
  #;(define avatar
    (if s
        (run-snippet-string a s)
        (overlay
         (text "no avatar" 20 "black")
         (circle 30 "solid" "red"))))

  (define avatar
    (random-dude))


  (define bg
    ;(rectangle 400 300 "outline" "black")
    (badge-bg
     (if (photo-release? student)
         (random 2 6)
         1)))
  
  (define content
    (above
     (text name n1 "black")
     (text (last-name student) n2 "black")
     img
     ))
  
  (define badge (overlay/align "right" "bottom"
                               (overlay/align "left" "top"
                                              photo-icon
                                              (overlay
                                               content
                                               bg))
                               (buffer 10 (scale-to-fit avatar 100))))
  (buffer 40 badge))


  

;print all badges in course or list of courses (only works on macs)
;no QR
(define (print-badges! . courses)
  (map print-image!
       (cards->pages
        (apply append
               (map badges courses)))))

;print all badges in course or list of courses (only works on macs)
;YES QR
(define (print-qr-badges! . courses)
  (map print-image!
       (cards->pages
        (apply append
               (map qr-badges courses)))))


;attempt at function to save-out badges
#;(define (save-badges! course)
  (save-out-materials "badges"
                      (cards->pages (badges course))))

;--------------------------------
;gets student's full name
(define/contract (student-list student)
  (-> student? string?)
  
  (define content
    (string-append
     (first-name student)
     " "
     (last-name student)))
  
  content)


;returns list of student names enrolled in course
(define/contract (all-students course)
  (-> course? (listof string?))
  (define (b x) (student-list x))
  (map b (students course)))

;returns number of courses student has been signed up for and attended in the past
;ignores cancelled enrollments
(define/contract (prev-enrolled student)
  (-> student? number?)
  (define e (hash-ref student 'enrollments))
  (define c (map (curryr hash-ref 'canceled) e))
  (define l (map swap c))
  (length (filter true? l)))

(define (true? x)
  (eq? x #t))

;------------------------------------------------

;gets enrollments from course
(define/contract (enrollments c)
  (-> course? list?)
  (define x (hash-ref c 'enrollments))
  (define (f y) (hash-set y 'the-type "enrollment"))
  (map f x))

;gets list of students from course
(define/contract (students course)
  (-> course? (listof student?))
  (define (f x) (hash-ref x 'student))
  (define l (map f (enrollments course)))
  (define (x y) (hash-set (hash-set y 'the-type "student")
                          'env env))
  (map x l))

;builds QR badges for all students in a course
(define/contract (qr-badges course)
  (-> course? (listof image?))
  (define (b x) (build-qr-badge x (hash-ref course 'id)))
  (map b (students course)))

;builds non-QR badges for all students in a course
(define/contract (badges course)
  (-> course? (listof image?))
  (define (b x) (build-badge x (hash-ref course 'id)))
  (map b (students course)))

;gets age of a student
(define/contract (age student)
  (-> student? number?)
  (define (stud-age dob) (period-ref (period-between dob (now) '(years)) 'years))
  (if (equal? 'null (hash-ref student 'dob))
      0 
      (stud-age (iso8601->datetime (hash-ref student 'dob))))
  )

;gets id of a student
(define/contract (student-id student)
  (-> student? number?)
  (hash-ref student 'id))

;gets medical notes of a student
(define (medical-notes student)
  (define tmp-notes (hash-ref student 'medical_notes))
  (cond
    [(eq? tmp-notes 'null) ""]
    [else tmp-notes])
  )

;gets parent's name of a student
(define/contract (parent-name student)
  (-> student? string?)

  (cond
    [(equal? (hash-ref student 'customers) (list )) "No Name"]
    [else
     (define parent (list-ref (hash-ref student 'customers) 0))
  
     (define content
       (string-append
        (first-name parent)
        " "
        (last-name parent)))
  
     content]))

;gets parent's phone number of a student
(define/contract (parent-phone student)
  (-> student? string?)
  (cond
    [(equal? (hash-ref student 'customers) (list )) "No Phone"]
    [else
     (define parent (list-ref (hash-ref student 'customers) 0))

     (hash-ref parent 'phone_number)])
  )

(define (swap i)
  (if (or (eq? i 'null) (not i))
  #t
  #f))