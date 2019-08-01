#lang racket

(require ts-racket
         (only-in 2htdp/image scale bitmap))
(set-env! PROD)

;2-panel flyer: K-2nd & 3rd-5th Winter
(courses->flyer
 #:first-title "Coding Club: Awesome Animals"
 #:second-title "Coding Club: Epic Quests"
 (course 1702)
 (course 1703))

;2-panel flyer: K-2nd & 3rd-5th Spring
;DAYLIGHT SAVINGS TIME FIX!!!
;(courses->flyer
; #:first-title "Code Superhero Games"
; #:second-title "Code Battle Arena Games"
; (change-meeting-times
;  (add-hours -1)
;  (course 1266))
; (change-meeting-times
;  (add-hours -1)
;  (course 1267)))

;1-panel flyer: K-2nd Winter
#;
(course->flyer
             #:title "Coding Club: Awesome Animals"
             (course 1706))

;1-panel flyer: 3rd-5th Winter
;(course->flyer #:bg (make-flier-bg
;                                (bitmap "resources/student-image-2.jpg")
;                                (bitmap "resources/superhero-screenshot-3.png")
;                                (bitmap "resources/student-image-1.jpg"))
;                           #:title "Code Your Own Superhero Video Games"
;                           (course  1284))