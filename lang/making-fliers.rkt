#lang racket

(require ts-racket
         (only-in 2htdp/image scale bitmap))
(set-env! PROD)

;2-panel flyer: K-2nd & 3rd-5th Winter
;(scale 0.25 (courses->flyer
; #:first-title "Superhero Digital Animation"
; #:second-title "Code Survival Games"
; (course 1258) (course 1259)))

;1-panel flyer: K-2nd Winter
(scale 0.25 (course->flyer
             #:title "Digital Animation with Superheroes"
             (course 1258)))

;1-panel flyer: 3rd-5th Winter
;(scale 0.25 (course->flyer #:bg (make-flier-bg
;                                (bitmap "resources/student-image-2.jpg")
;                                (bitmap "resources/survival-screenshot.png")
;                                (bitmap "resources/student-image-1.jpg"))
;                           #:title "Code Your Own Survival Games"
;                           (course 1259)))