#lang racket

;How to distribute this to students/chromebooks...
(require "../lang/common.rkt")

(require 2htdp/image)


(enable-snippets stephen) 

#;(overlay
 (circle 10 "solid" "red")
 (get-snippet stephen my-avatar2))


(store-snippet stephen my-avatar
               (circle #:test 40 "solid" "green"))



