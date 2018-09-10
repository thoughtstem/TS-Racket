#lang racket



(provide (all-defined-out))

(require "./util.rkt"
         json
         pict/code
         2htdp/image
         simple-qr
         racket-bricks/renderer)


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
  (show "code_snippet" (~a "no-password-needed::" key "::" id)))


(define/contract (value h)
  (-> hash? string?)
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
         
         
         (eval (read (open-input-string code-string))
               (first nick))))))

(define-syntax (store-snippet stx)
  (syntax-case stx ()
    ((_ nick key snippet)
     #`(let ([code-string (~s 'snippet)])
         (store-snippet-f (~a (second nick)) ;OMG refactor this list bs..
                          (~a (third nick))
                          (~a 'key)
                          code-string)
         snippet))))

;badge base
(define BG
  (rectangle 400 300 "outline" "darkgreen"))

;password getter
(define/contract (password student)
  (-> hash? string?)
  (hash-ref student 'password))

;photo release getter
(define/contract (photo-release? student)
  (-> hash? boolean?)
  (hash-ref student 'photo_release))

;builds qr from student password and course id
(define/contract (qr-me stu-id crs-id)
  (-> string? number? image?)
  (qr-write  (~a stu-id "-" crs-id) "qr.png")
  (bitmap "qr.png"))

;builds badge
(define/contract (build-badge student crs-id)
  (-> hash? number? image?)
  (define photo-icon
    (if (photo-release? student)
      (bitmap "resources/camera.png")
      (bitmap "resources/no_photo_camera.png")))
  (overlay/align "left" "top"
                 photo-icon
                 (overlay
                  (above
                   (text (first-name student) 50 "darkgreen")
                   (text (last-name student) 30 "darkgreen")
                   (qr-me (password student) crs-id)
                   (text (~a (password student) "-" crs-id) 25 "darkgreen"))
                  BG)))


;gets enrollments from course
(define/contract (enrollments c)
  (-> course? list?)
  (hash-ref c 'enrollments))

;gets list of students from course
(define/contract (students course)
  (-> course? (listof student?))
  (define (f x) (hash-ref x 'student))
  (define l (map f (enrollments course)))
  (define (x y) (hash-set y 'the-type "student"))
  (map x l))

(define (badges course)
  (define (b x) (build-badge x (hash-ref course 'id)))
  (map b (students course)))

