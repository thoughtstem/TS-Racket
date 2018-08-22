#lang racket

;TODO: ORganize this file into multiple files.  It's getting gross.

(require request
         net/url
         json
         gregor
         gregor/period
         "./constants.rkt")

(provide set-key!

         show
         destroy

         meetings
         course
         name
         id
         set-name
         set-type
         new-course
         save
         
         
         new-meeting
         save-all
         (all-from-out gregor)
         ->time
         course-with-meetings
         
         (all-from-out "./constants.rkt"))


(module+ test
  (require rackunit)

  (define test-course-1
    (hash 'the-type "course"
          'name "Underwater Basket Weaving"
          'description "Learn how to weave baskets underwater!!")))

(define DEV "http://34.197.96.0")
(define PROD "https://secure.thoughtstem.com")

(define host PROD)


(define key "NOPE")

(define (set-key! k)
  (set! key k))


(define (get-url type id)
  (~a host "/" type "/" id ".json?api_key=" key))

(define (get-creation-url type)
  (~a host "/" type ".json?api_key=" key))


(define (pluralize s)
  (~a s "s"))



(define (show type id)
  (define h
    (read-json
     (open-input-string
      (http-response-body
       (get http-requester
            (string->url (get-url (pluralize type) id)))))))
  (hash-set h 'the-type type))


(define (update type id json)
  (read-json
   (open-input-string
    (http-response-body
     (put http-requester
          (string->url (get-url type id))
          (string->bytes/utf-8 json)
          #:headers
          '("Content-Type: application/json"))))))


(define (create type json)
  (read-json
   (open-input-string
    (http-response-body
     (post http-requester
          (string->url (get-creation-url type))
          (string->bytes/utf-8 json)
          #:headers
          '("Content-Type: application/json"))))))

(define (destroy h)
  (read-json
   (open-input-string
    (http-response-body
     (delete http-requester
             (string->url (get-url (pluralize (type h)) (id h)))
             #:headers
             '("Content-Type: application/json"))))))

(define/contract (save h)
  (-> hash? hash?)
  (define t (type h))
  (displayln (list t
                   (string? t)))
  (define json
    (with-output-to-string
        (λ ()
          (write-json (hash (string->symbol t) ;Singular (course)
                            h)))))
  (set-type
   (if (id h)
      (update (pluralize t)  
              (id h)
              json)
      (create (pluralize t)  
              json))
   t))


(define (course id)
  (show "course" id))


(define/contract (meetings h)
  (-> hash? list?)
  (map (curryr set-type "meeting") (hash-ref h 'meetings #f))
  )

(define/contract (id h)
  (-> hash? (or/c number? boolean?))
  (hash-ref h 'id #f))

(define/contract (type h)
  (-> hash? string?)
  (hash-ref h 'the-type))



(define/contract (set-type h t)
  (-> hash? string? hash?)
  (hash-set h 'the-type t))

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

(define (save-all ls)
  (map save ls))

(define (->time s)
  (parse-moment s "yyyy-MM-dd h:mma"))

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










