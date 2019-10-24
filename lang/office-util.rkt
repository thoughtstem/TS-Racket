#lang racket

(provide ring-bell)

(require simple-http)

(define (ring-bell)
  (with-handlers ([exn:fail:network:http:read?
                     (λ(err) (displayln (~a "RESPONSE: " (exn-message err))))])
    (post (update-host xml-requester
                       "maker.ifttt.com")
          "/trigger/new_enrollment/with/key/MH70Fijmw4xTF5KrNL6hH")))
   

