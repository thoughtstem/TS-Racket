#lang racket

;How to distribute this to students/chromebooks...
(require "../lang/common.rkt")

(require 2htdp/image)


(enable-snippets stephen mHc) ;Make password optional...

(overlay
 (circle 10 "solid" "red")
 (get-snippet stephen my-avatar2))


#;(store-snippet stephen my-avatar2
                 (circle 40 "solid" "blue"))



