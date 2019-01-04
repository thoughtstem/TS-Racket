#lang racket

(require request
         net/url
         json
         gregor
         gregor/period
         aws/keys
         (only-in aws/s3 put/file
                         s3-region)
         2htdp/image
         "./constants.rkt")

(provide env
         set-env!
         DEV
         PROD
         index
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
         topic-assignment?
         meeting?
         room?
         location?
         attendance?
         student?
         chunks
         take-until
         drop-until
         name
         host-image!
         get-url
         download-file

         is-prod?
         prod-preferred!)

(module+ test
  (require rackunit))

(s3-region "us-west-1")

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


(define (get-url type id (k key))
  (if (string=? k "")
      (raise "ERROR: NO API KEY")
      (if id
          (~a env "/" type "/" id ".json?api_key=" k)
          (~a env "/" type ".json?api_key=" k)  )))


(define (get-creation-url type)
  (~a env "/" type ".json?api_key=" key))


(define (pluralize s)
  (~a s "s"))

(define (hash-with-type? x t)
  (and (hash? x)
       (eq? (hash-ref x 'the-type #f) t)))

(define (course? x)
  (hash-with-type? x "course"))

(define (meeting? x)
  (hash-with-type? x "meeting"))

(define (topic? x)
  (hash-with-type? x "topic"))

(define (topic-assignment? x)
  (hash-with-type? x "topic_assignment"))

(define (room? x)
  (hash-with-type? x "room"))

(define (location? x)
  (hash-with-type? x "location"))

(define (attendance? x)
  (hash-with-type? x "attendance"))


(define (student? x)
  (hash-with-type? x "student"))

(define (code-snippet? x)
  (hash-with-type? x "code_snippet"))


(define resource?
  (or/c course? meeting? topic? room? location? attendance? code-snippet? topic-assignment?))

(define (index type)
  (define url (string->url (get-url (pluralize type) #f)))
  
  (define l
    (read-json 
     (open-input-string
      (http-response-body
       (get http-requester
            url)))))
  
  (map (λ(h)(hash-set h 'the-type type))
       l)
  )

(define (show type id)
  (with-handlers ([exn:fail? (λ(e) (error (~a "Could not find " type " with id " id)))])
    (define resp
      (http-response-body
       (get http-requester
            (string->url (get-url (pluralize type) id)))))
  
    (define h  (read-json  (open-input-string  resp)))

    (hash-set (hash-set h 'the-type type)
              'env env)))


(define (prod-preferred! x)

  (if (is-prod? x)
      (void)
      (displayln "WARNING: Producing a badge from DEV information.\nYou probably want to (set-env! PROD)."))

  #t)

(define (is-prod? x)
  (string=? PROD
            (hash-ref x 'env)))


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
  (-> resource? resource?)
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

(define (host-image-from-string! s)
  (define p (string->path s))
  (define name (last (explode-path p)))
  (put/file (format "ts-email-assets-and-stuff/~a" name) p)
  (format "https://s3-us-west-1.amazonaws.com/ts-email-assets-and-stuff/~a" name))

(define (host-image-from-image! i)
  (define f (make-temporary-file "~a.png"))
  (define name (last (explode-path f)))
  (save-image i f)
  (put/file (format "ts-email-assets-and-stuff/~a" name) f)
  (format "https://s3-us-west-1.amazonaws.com/ts-email-assets-and-stuff/~a" name))

(define/contract (host-image! x)
  (-> (or/c image? string?) string?)
  (cond [(image? x) (host-image-from-image! x)]
        [(string? x) (host-image-from-string! x)]))

(define (download-file url outfile)
  (call-with-output-file outfile
    (lambda (p)
      (display (port->bytes (get-pure-port (string->url url)))
               p))
    #:exists 'replace))

