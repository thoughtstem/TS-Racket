#lang racket
(require ts-racket)

(set-env! PROD)

(define c (course 1171))
(define c1 (course 1170))

(make-flier-double-panel
            (name c)
            (grade-level c)

            ;TODO: Come back to this
            (list
             "Students will create a portfolio of\n comicbook art using MIT's Scratch\n programming interface"
             
             "Students will gain proficiency\n with computers, mice, and keyboards"
             
             "Students will learn how to express\n their creativity through digital\n art that can be shared with family"
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

            (name c1)
            (grade-level c1)

            ;TODO: Come back to this
            (list
             "Selling point 1"
             
             "Selling point 2"
             
             "Selling point 3"
             )

            (length (meetings c1))
            (->nice-date
             (start-time (first (meetings c1))))
            (->nice-date
             (end-time (last (meetings c1))))
            
            (price c1)
            
            (list
             (room-number (room c1))
             (name (location (room c1)))
             (address (location (room c1))))

            (list (->day-of-week
                   (start-time (first (meetings c1))))

                  ;TODO: Adjust for TZ
                  (->nice-time
                   (start-time (first (meetings c1))))
                  (->nice-time
                   (end-time (first (meetings c1)))))

            ;TODO: Figure out how to generate this...
            "https://www.thoughtstem.com/nda"
            )