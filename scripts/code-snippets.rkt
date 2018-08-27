#lang racket

;How to distribute this to students/chromebooks...
(require "../lang/common.rkt")

(require 2htdp/image
         (only-in 2htdp/universe
                  animate)
         )


(enable-snippets stephen) 


(store-snippet
 stephen face
 (lambda (eye nose)
   (animate
    (lambda (t)
      (define x (overlay
                 (above
                  (beside eye eye)
                  nose)
                 (circle 50 "solid" "red")))
      (rotate t (beside x x))))))


 
