#lang racket

(require request
         net/url
         json
         gregor
         gregor/period
         "./constants.rkt")

(provide ;set-key!
         set-env!
         DEV
         PROD
         show
         destroy
         save
         save-all
         id
         set-type
         type
         string->time
         course?
         topic?
         meeting?
         room?
         location?
         chunks
         take-until
         drop-until
         name)

(module+ test
  (require rackunit))

(define DEV "http://34.197.96.0")
(define PROD "https://secure.thoughtstem.com")

(define env DEV)

(define key-path (~a
                           (path->string (find-system-path 'home-dir))
                           "/.ts-api-key"))
(define key (if (file-exists? key-path)
                (string-trim
                 (file->string key-path))
                ""))

;Deprecated.  Don't want people typing keys out and accidentally committing them
#;(define (set-key! k)
    (set! key k))

(define (set-env! k)
  (set! env k))


(define (get-url type id)
  (~a env "/" type "/" id ".json?api_key=" key))

(define (get-creation-url type)
  (~a env "/" type ".json?api_key=" key))


(define (pluralize s)
  (~a s "s"))

(define (course? x)
  (and (hash? x)
       (eq? (hash-ref x 'the-type #f) "course")))

(define (topic? x)
  (and (hash? x)
       (eq? (hash-ref x 'the-type #f) "topic")))

(define (meeting? x)
  (and (hash? x)
       (eq? (hash-ref x 'the-type #f) "meeting")))

(define (room? x)
  (and (hash? x)
       (eq? (hash-ref x 'the-type #f) "room")))

(define (location? x)
  (and (hash? x)
       (eq? (hash-ref x 'the-type #f) "location")))

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



(define/contract (id h)
  (-> hash? (or/c number? boolean? string?))
  (hash-ref h 'id #f))

(define/contract (type h)
  (-> hash? string?)
  (hash-ref h 'the-type))

(define/contract (set-type h t)
  (-> hash? string? hash?)
  (hash-set h 'the-type t))



(define (save-all ls)
  (map save ls))

(define (string->time s)
  (parse-moment s "yyyy-MM-dd h:mma"))



(define (chunks n l)
  (if (empty? l)
      '()
      (cons (take-until l
                        (curry char-count>=? n))
            (chunks n (drop-until l
                                  (curry char-count>=? n))))))
(define (char-count>=? n l)
    (define s (apply string-append l))
    (>= (string-length s) n))


(define (drop-until l pred?)
  (define prefix (take-until l pred?))
  (define-values (_ ret)
    (drop-common-prefix prefix l ))
  ret)

(define (take-until l pred?)
  (define (helper ret l pred?)
    (if (or (pred? ret) (empty? l))
        ret
        (helper (append ret (list (first l)))
                (rest l)
                pred?)))

  (helper '() l pred?))

(module+ test
  (define (length=2? l)
    (= 2 (length l)))

  (check-equal? (take-until '(a b c d e f)
                            length=2?)
                '(a b))

  (check-equal? (drop-until '(a b c d e f)
                            length=2?)
                '(c d e f)))


(define/contract (name h)
  (-> hash? (or/c string? boolean?))
  (hash-ref h 'name #f))
