#lang racket

(provide set-stripe-key!
         TEST
         LIVE
         
         set-product-name
         city->stripe
         course->stripe
         
         stripe-get-status
         stripe-get-data
         
         show-products
         show-skus
         delete-sku
         delete-product
         )

(require stripe-integration
         metacoders-dot-org-lib)

(define TEST "/.stripe-test-api-key")
(define LIVE "/.stripe-api-key")

(define stripe-key TEST)

(define (set-stripe-key! k)
  (set! stripe-key k))

(define stripe-key-path (~a
                           (path->string (find-system-path 'home-dir))
                           stripe-key))

(define stripe-key-data (if (file-exists? stripe-key-path)
                            (string-trim
                             (file->string stripe-key-path))
                            ""))

(stripe-secret-key (if (string=? stripe-key "")
                       (raise "ERROR: NO STRIPE API KEY")
                       stripe-key-data))

(define (set-product-name prod-id name)
  (stripe-post (~a "/v1/products/" prod-id)
               (hash 'name name)))

(define (course->sku-name c)
  ; === SINGLE-LINE FORMATTING ===
  (~a (course-location c) " - "
      (course-topic c) " (" (course-grade-range c) ") -  "
      (meeting-date->weekday (first (course-meeting-dates c)))"s from "
      (course-start-time c) "-" (course-end-time c) " - "
      "Dates: " (apply (curry ~a #:separator ", ") (course-meeting-dates c)))
  ; === MULTI-LINE FORMATTING ===" this doesn't work consistently without a monospace font
  #;(apply (curry ~a #:separator " ") (append (map (compose (curry ~a #:width 46 #:pad-string "=" #:align 'left)
                          (λ(s) (~a s " ")))
      (list (~a "Topic: " (course-topic c))
            (~a "Grades: " (course-grade-range c))
            (~a "Total Meetings: " (length (course-meeting-dates c)))
            (~a "Meets On: " (meeting-date->weekday (first (course-meeting-dates c)))"s")
            (~a "Time: " (course-start-time c) " - " (course-end-time c))
            ))
      (list (~a "Dates: " (apply (curry ~a #:separator ", ") (course-meeting-dates c))))
      ))
  )

(define-syntax-rule (get-response-status response)
  (let-values ([(status headers json ik) response])
    status))

(define (stripe-get-status url) (get-response-status (stripe-get url)))

(define-syntax-rule (get-response-data response)
    (let-values ([(status headers json ik) response])
    json))

(define (stripe-get-data url) (get-response-data (stripe-get url)))

;if it exists, update it, and if not, create it
(define (city->stripe prod-id city-name)
  (define name (~a "Coding Classes in " city-name))
  (if (eq? (stripe-get-status (~a "/v1/products/" prod-id)) 404)
      (stripe-post (~a "/v1/products")
                   (hash 'id prod-id
                         'name name
                         (string->symbol "attributes[]") "name"
                         'type "good"))
      (stripe-post (~a "/v1/products/" prod-id)
                   (hash 'name name))))

;if it exists, update it, and if not, create it
(define (course->stripe prod-id c)
  (define c-sku (course-sku c))
  (if (eq? (stripe-get-status (~a "/v1/skus/" c-sku)) 404)
      (stripe-post (~a "/v1/skus")
                   (hash (string->symbol "attributes[name]") (course->sku-name c)
                         'id c-sku
                         'image "https://metacoders.org/img/weekly-classes.jpg"
                         'price (~a (* 100 (course-price c)))
                         'currency "usd"
                         (string->symbol "inventory[type]") "infinite"
                         'product prod-id
                         )
                   )
      (stripe-post (~a "/v1/skus/" c-sku)
                   (hash (string->symbol "attributes[name]")
                         (course->sku-name c)
                         'image "https://metacoders.org/img/weekly-classes.jpg"
                         'price (~a (* 100 (course-price c)))
                         'product prod-id ;this will link the existing sku to a new product
                         )
                   )))

; this only works if all linked skus are deleted first
(define (delete-product prod-id)
  (stripe-delete (~a "/v1/products/" prod-id)))

(define (delete-sku sku)
  (stripe-delete (~a "/v1/skus/" sku)))

(define (format-date d)
    (~a (date-month d) "/" (date-day d) "/" (date-year d)
      " " (date-hour d) ":" (date-minute d) ":" (date-second d)))

(define (show-products)
  (displayln (~a (~a "NAME"           #:width 40 #:limit-marker "...") "| "
                 (~a "PRODUCT ID"     #:width 20 #:limit-marker "...") "| "
                 (~a "LAST UPDATED " #:width 20 #:limit-marker "...") "\n"
                 (~a #:width 84 #:pad-string "-") "\n"
                 (apply ~a (map (λ(p) (~a (~a (hash-ref p 'name)    #:width 40 #:limit-marker "...") "| "
                                          (~a (hash-ref p 'id)      #:width 20 #:limit-marker "...") "| "
                                          (~a (format-date (seconds->date (hash-ref p 'updated))) #:width 20 #:limit-marker "...") "\n"))
                                (hash-ref (stripe-get-data "/v1/products?limit=100") 'data))))))

(define (show-skus [product-id #f])
  (displayln (~a (~a "NAME"       #:width 40 #:limit-marker "...") "| "
                 (~a "PRICE"      #:width 6 #:limit-marker "...") "| "
                 (~a "SKU ID"     #:width 20 #:limit-marker "...") "| "
                 (~a "PRODUCT ID"     #:width 20 #:limit-marker "...") "| "
                 (~a "LAST UPDATED " #:width 20 #:limit-marker "...") "\n"
                 (~a #:width 114 #:pad-string "-") "\n"
                 (apply ~a (map (λ(p) (~a (~a (hash-ref (hash-ref p 'attributes) 'name) #:width 40 #:limit-marker "...") "| "
                                           (~a "$" (/ (hash-ref p 'price) 100)  #:width 6 #:limit-marker "...") "| "
                                           (~a (hash-ref p 'id)      #:width 20 #:limit-marker "...") "| "
                                           (~a (hash-ref p 'product)      #:width 20 #:limit-marker "...") "| "
                                           (~a (format-date (seconds->date (hash-ref p 'updated))) #:width 20 #:limit-marker "...") "\n"))
                                 (filter (if product-id
                                             (λ(s) (string=? (hash-ref s 'product) product-id))
                                             identity)
                                         (hash-ref (stripe-get-data "/v1/skus?limit=100") 'data)))))))

