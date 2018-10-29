#lang racket

(provide meeting->backup-urls
         meeting+student->backup-url
         previous-meeting
         restore-smw)

(require "../util.rkt"
         "../courses.rkt"
         "../students.rkt")

(define/contract (meeting->backup-urls m)
  (-> meeting? any/c)

  (map backup-url (attendances m)))

(define/contract (meeting+student->backup-url m s)
  (-> meeting? student? any/c)

  (define urls (meeting->backup-urls m))


  (findf (curry backup-url-for? s) urls))

(define (backup-url-for? s u)
  (define parts (string-split u "/"))

  (define i (string->number (third (reverse parts))))

  (= (id s)  i))


;This could get moved to a more general place.
(define/contract (previous-meeting m)
  (-> meeting? (or/c #f meeting?))

  (define c (course (course-id m)))
  (define i (index-of (map id (meetings c))
                      (id m)))

  (if (= 0 i)
      #f
      (meeting ;We do another fetch for this meeting, to augment it with more data...
       (id
        (list-ref (meetings c)
                  (sub1 i))))))


(define (restore-smw link)
  (~a "rm -rf backup.zip;"
      "wget " link " -P ~/Desktop ;"
      "unzip -o backup.zip -d ~/Desktop;"
      "rm -rf backup.zip;"))

