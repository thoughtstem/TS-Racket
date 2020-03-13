#lang racket

(require csv-writing
         "./students.rkt"
         "./courses.rkt")

(provide course-enrollments->csv)

(define (format-phone number)
  (define phone-number
    (string-replace
     (string-replace
      (string-replace
       (string-replace number "-" "") 
       "(" "")                        
      ")" "")                         
     "/" ""))

  (string-append (substring phone-number 0 3) "-"
                 (substring phone-number 3 6) "-"
                 (substring phone-number 6 10)))

(define (course-enrollments->csv course-id
                                 #:create-file? (create-file? #f)
                                 #:display-csv? (display-csv? #t))
  
  (define (enrollments-list course-id)
    
    (define students-list (students (course course-id)))
    (define enrollments-data '())
    
    (for ([i students-list])
      (define student-full-name
        (student-list i))
      (define parent-full-name
        (parent-name i))
      (define parent-phone-num
        (format-phone (parent-phone i)))
      (define parent-email-add
        (parent-email i))
    
      (define enrollment
        (list (first (string-split student-full-name " "))
              (second (string-split student-full-name " "))
              (first (string-split parent-full-name " "))
              (second (string-split parent-full-name " "))
              parent-phone-num
              parent-email-add))
    
      (set! enrollments-data (append enrollments-data
                                     (list enrollment))))

    enrollments-data)

  (if display-csv?
      (display-table (enrollments-list course-id))
      #f)

  (if create-file?
      (with-output-to-file (~a "enrollments-from-course-" course-id ".csv")
        (lambda ()
          (display-table (enrollments-list course-id)))
        )
      #f))


;USAGE replace XXXX with course id
;(set-env! PROD)
;(course-enrollments->csv XXXX)
