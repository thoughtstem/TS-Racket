#lang racket

(require ts-racket
         (only-in 2htdp/image scale bitmap))
(set-env! PROD)

(courses->flyer
 #:first-title "Superhero Digital Animation"
 #:second-title "Code Survival Games"
 (course 1258) (course 1259))