#lang racket

(require ts-racket
         (only-in 2htdp/image scale bitmap))
(set-env! PROD)


;2-panel flyer: K-2nd & 3rd-5th Spring

(courses->flyer
 #:first-title "Coding Club: Pokemon Clicker Games"
 #:second-title "Coding Club: Out of This World Coding!"
 (course 1901)
 (course 1900))


;1-panel flyer: 3rd-5th Spring
#;
(course->flyer #:bg (make-flier-bg
                                (bitmap "/Users/lindseyhandley/ts-racket/lang/resources/single-panel-k-2nd-3.jpg")
                                (bitmap "/Users/lindseyhandley/ts-racket/lang/resources/single-panel-3rd-5th.jpg")
                                (bitmap "/Users/lindseyhandley/ts-racket/lang/resources/single-panel-k-2nd.jpg"))
                           #:title "Coding Club: Coding That's Out of This World!"
                           (course  1782))