#lang racket




#;(
(store-snippet stephen my-eyes1
               (eyes2 "red" "blue"))

(store-snippet sara my-eyes
               (eyes1 "green" "orange"))

(store-snippet stephen my-eyes3
               (eyes1 "cyan" "teal"))

(store-snippet stephen my-eyes4
               (eyes1 "green" "red"))
)

(define (boxify i)
  (overlay i
           (rectangle (+ 20 (image-width i))
                      (+ 20 (image-height i))
                      "outline"
                      "black")))



;Put this in game engine??
#;(map boxify
     (list
      (above/align "left"
                   (text "STEPHEN" 24 "black")
                   (display-snippet stephen my-eyes1)
                   (get-snippet stephen my-eyes1))

 
      (above/align "left"
                   (text "SARA" 24 "black")
                   (display-snippet sara my-star)
                   (get-snippet sara my-star))

 
      (above/align "left"
                   (text "SONNY" 24 "black")
                   (display-snippet stephen my-eyes3)
                   (get-snippet stephen my-eyes3))

 
      (above/align "left"
                   (text "JASON" 24 "black")
                   (display-snippet stephen my-eyes4)
                   (get-snippet stephen my-eyes4))))









(require ts-racket
         2htdp/image
         "./ap-eye.rkt")


(enable-snippets stephen)
(enable-snippets sara)

(define saras-eyes (get-snippet sara my-star))

(dude1
 (circle 40 "solid" "green")
 (beside
  saras-eyes
  saras-eyes)
 (mouth1))

























