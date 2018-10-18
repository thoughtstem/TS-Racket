#lang racket

(require ts-racket
         (only-in 2htdp/image scale bitmap))
(set-env! PROD)

(courses->flyer
 #:first-title "Superhero Digital Animation"
 #:second-title "Code Survival Games"
 #:bg (make-2-course-flier-bg
       (bitmap "resources/k-2nd-screenshot.png")
       (bitmap "resources/survival-screenshot.png")
       (bitmap "resources/student-image-1.jpg")
       (bitmap "resources/student-image-2.jpg")) (course 1258) (course 1259))