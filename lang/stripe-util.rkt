#lang racket

(provide set-stripe-key!
         TEST
         LIVE
         set-product-name
         course->stripe
         delete-sku
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

;if it exists, update it, and if not, create it
(define (course->stripe prod-id c)
  (define c-sku (course-sku c))
  (if (eq? (get-response-status (stripe-get (~a "/v1/skus/" c-sku))) 404)
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
                         )
                   )))

(define (delete-sku sku)
  (stripe-delete (~a "/v1/skus/" sku)))