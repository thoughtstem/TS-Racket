#lang racket
(require ts-racket)

(set-env! PROD)

(define c (course 1171))

(make-flier-double-panel (name c)
            (grade-level c)

            ;TODO: Come back to this
            (list
             "Students will create a portfolio of comicbook art using MIT's Scratch programming interface"
             
             "Students will gain proficiency with computers, mice, and keyboards"
             
             "Students will learn how to express their creativity through digital art that can be shared with family"
             )

            (length (meetings c))
            (->nice-date
             (start-time (first (meetings c))))
            (->nice-date
             (end-time (last (meetings c))))
            
            (price c)
            
            (list
             (room-number (room c))
             (name (location (room c)))
             (address (location (room c))))

            (list (->day-of-week
                   (start-time (first (meetings c))))

                  ;TODO: Adjust for TZ
                  (->nice-time
                   (start-time (first (meetings c))))
                  (->nice-time
                   (end-time (first (meetings c)))))

            ;TODO: Figure out how to generate this...
            "https://www.thoughtstem.com/nda"
            )