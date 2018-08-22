#lang racket

(require request
         net/url
         json)

(provide show
         course
         name
         set-name
         new-course
         save
         robotics-course-description
         albert-einstein
         new-meeting)

(module+ test
  (require rackunit)

  (define test-course-1
    (hash 'the-type "course"
          'name "Underwater Basket Weaving"
          'description "Learn how to weave baskets underwater!!")))

(define (get-url type id)
  (~a "http://34.197.96.0/" type "/" id ".json?api_key=zRqrP3sCu3FERScNgL5b"))

(define (get-creation-url type)
  (~a "http://34.197.96.0/" type ".json?api_key=zRqrP3sCu3FERScNgL5b"))

(define (pluralize s)
  (~a s "s"))

(define (show type id)
  (define h
    (read-json
     (open-input-string
      (http-response-body
       (get http-requester
            (string->url (get-url type id)))))))
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
  (if (id h)
      (update (pluralize t)  
              (id h)
              json)
      (create (pluralize t)  
              json)))


(define (course id)
  (show 'courses id))



(define/contract (id h)
  (-> hash? (or/c number? boolean?))
  (hash-ref h 'id #f))

(define/contract (type h)
  (-> hash? string?)
  (hash-ref h 'the-type))

;Takes a hash and returns the value for the 'name key.
(define/contract (name h)
  (-> hash? (or/c string? boolean?))
  (hash-ref h 'name #f))

(module+ test
  (check-equal? (name test-course-1)
                "Underwater Basket Weaving")

  (check-equal? (type test-course-1)
                'course)
  )


;Sets the 'name value in the provided hash.  Does not save the
;  associated remote resource.  You must use save for that.
(define/contract (set-name h new-name)
  (-> hash? string? hash?)
  (hash-set h 'name new-name))

(module+ test
  (check-equal? (name (set-name test-course-1 "New name"))
                "New name"))



(define/contract (new-course #:name n #:description desc #:location loc #:price p)
  (-> #:name string? #:description string? #:location number? #:price number? hash?)
  (hash 'the-type "course"
        'name n
        'description desc
        'dummy_connect_to loc
        'price p
        ))

(define (new-meeting #:course id #:start t #:duration x)
  (-> #:course number? #:start string? #:duration number? hash?)
  (hash 'the-type "meeting"
        'start_time t
        'end_time t    ;(+minutes x t) ;https://docs.racket-lang.org/gregor/datetime-arithmetic-provider.html
        'course_id id))

(define robotics-course-description
  "<p>Learn to <b>build and code robots</b> using the RoKit, designed locally in San Diego by our friends at Robolink. Students will work in teams as they learn and apply both mechanical and software engineering principles. Students will complete a variety of challenges like maze navigation, line following, and sumo competitions. </p>\n<p>There is so much to learn about robotics! That's why this summer we have an A, B, and C version of this camp. Each camp covers different material, so take one camp or all three!<b>This camp is Version A.</b></p>\n<p>We will send daily email reports with the code that students worked on in camp that day, so that they can keep coding at home. After camp, we'll also provide students with information to purchase a robotics kit for continued learning at home.</p>")

(define albert-einstein 3)