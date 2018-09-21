#lang racket



(provide (all-defined-out))

(require "./util.rkt"
         "./argus/argus.rkt"
         "./courses.rkt"
         json
         pict/code
         2htdp/image
         simple-qr
         racket-bricks/renderer
         gregor
         gregor/period)


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


(define (new-code-snippet key snippet-string student-pw snippet-nickname)
  (hash 'the-type "code_snippet"
        'key key
        'value snippet-string
        'nickname snippet-nickname
        'id (~a student-pw "::" snippet-nickname "::" key)))


(define (store-snippet-f student-pw snippet-nickname key snippet-string)
  (save
   (new-code-snippet key snippet-string student-pw snippet-nickname)))


(define (avatar-snippet s)
  (get-snippet-by-pw-and-name (hash-ref s 'password) "avatar"))

(define (get-snippet-by-pw-and-name student-pw snippet-name)
  (value (code-snippet (~a student-pw)
                       (~a snippet-name))))


(define (run-snippet-string a code-string)
  (eval (read (open-input-string code-string))
        (namespace-anchor->namespace a)))



(define-syntax-rule (enable-snippets nick)
  (begin
    (set-env! PROD)
    (define-namespace-anchor a)
    (define nick (list
                  (namespace-anchor->namespace a)
                  (lookup-student-pw)
                  'nick))))

(define-syntax (display-snippet stx)
  (syntax-case stx ()
    ((_ nick key)
     #`(let ([code-string
              (value (code-snippet (~a (third nick))
                                   (~a 'key)))])
         
         ((render-text)
          (read (open-input-string code-string))))
         )))

(define-syntax (get-snippet stx)
  (syntax-case stx ()
    ((_ nick key)
     #`(let ([code-string
              (value (code-snippet (~a (third nick))
                                   (~a 'key)))])
         
         (if code-string
             (eval (read (open-input-string code-string))
                   (first nick))
             (displayln (~a "No snippet for " (third nick) " " 'key)))

         ))))

(define-syntax (store-snippet stx)
  (syntax-case stx ()
    ((_ nick key snippet)
     #`(let ([code-string (~s 'snippet)])
         (store-snippet-f (~a (second nick)) ;OMG refactor this list bs..
                          (~a (third nick))
                          (~a 'key)
                          code-string)
         snippet))))

;buffer function
(define/contract (buffer n i)
  (-> number? image? image?)
  (overlay
   i
   (rectangle (+ n (image-width i))
              (+ n (image-height i))
              'solid 'transparent )))

;logos
(define red-logo (scale .6 (bitmap "resources/ts-logo-red.png")))
(define orange-logo (scale .5 (bitmap "resources/ts-logo-orange.png")))
(define logo (scale .6 (bitmap "resources/ts-logo.png")))
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

;scaling avatar funct
(define/contract (scale-to-fit i w)
  (-> image? number? image?)
  (scale (/ w (image-width i)) i))

;builds badge
(define/contract (build-badge student
                              crs-id
                              (name (first-name student)))
  (->* (student? number?) (string?) image?)
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
     (text name 45 "black")
     (text (last-name student) 25 "black")
     (qr-me (password student) crs-id)
     (text (~a (password student) "-" crs-id) 25 "grey")))
  
  (define badge (overlay/align "right" "bottom"
                               (overlay/align "left" "top"
                                              photo-icon
                                              (overlay
                                               content
                                               bg))
                               (buffer 10 (scale-to-fit avatar 100))))
  (buffer 40 badge))

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

(define/contract (prev-enrolled student)
  (-> student? number?)
  (define e (hash-ref student 'enrollments))
  (define c (map (curryr hash-ref 'canceled) e))
  (define l (map swap c))
  (length (filter true? l))
)

(define (true? x)
  (if x #t #f))

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
  (define (x y) (hash-set y 'the-type "student"))
  (map x l))

;builds badges for all students in a course
(define/contract (badges course)
  (-> course? (listof image?))
  (define (b x) (build-badge x (hash-ref course 'id)))
  (map b (students course)))


(define/contract (age student)
  (-> student? number?)
  (define dob (iso8601->datetime (hash-ref student 'dob)))
  (period-ref (period-between dob (now) '(years)) 'years))

(define (swap i)
  (if (or (eq? i 'null) (not i))
  #t
  #f))