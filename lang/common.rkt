#lang racket


(require request
         net/url
         json
         gregor
         gregor/period
         "./constants.rkt"
         "./util.rkt"
         "./courses.rkt")

(provide set-key!
         set-env!
         DEV
         PROD

         (all-from-out gregor)
         (all-from-out "./constants.rkt")
         (all-from-out "./courses.rkt"))








