#lang racket

(provide meeting->backup-urls
         meeting+student->backup-url
         previous-meeting
         create-smw!
         delete-smw!
         restore-smw!
         login!

         current-student
         current-course
         current-meeting)

(require "../util.rkt"
         "../courses.rkt"
         "../students.rkt")

(require json
         anaphoric
         threading
         request
         net/url)


(define SMW-PATH
  (build-path (find-system-path 'home-dir)
              "SAVE_MY_WORK"))

(define SESSION-PATH
  (build-path (find-system-path 'home-dir)
              "remote" "sessions" "sessions"))

(define (API-KEY)
  (hash-ref
   (read-json
    (open-input-string
     (file->string
      (build-path (find-system-path 'home-dir)
                  "remote" "sessions" "config.json"))))
   'api_key))


(module+ test
  (set-env! DEV)
  
  #;(first-name (current-student))
  #;(name (current-course))

  (login! 1120 'cHB)
  (first-name (current-student))
  
  (create-smw!)
  (restore-smw!))


(define/contract (login! course-id password)
  (-> number? symbol? boolean?)

  (define session-folder
    (build-path SESSION-PATH (~a course-id "-" password)))

  (make-directory* session-folder)


  (define url
    (~a env "/courses/" course-id "/get_student_info.json"
        "?pass=" password
        "&api_key=" (API-KEY)))

  (define resp
    (with-handlers ([exn:fail? (thunk* (error "Couldn't read student info from " url))])
      (read-json
       (open-input-string
        (http-response-body
         (get http-requester
              (string->url url)))))))

  
  (define student_id (~> resp
                         (hash-ref _ 'student)
                         (hash-ref _ 'id)))
  
  (define student_first_name (~> resp
                                 (hash-ref _ 'student)
                                 (hash-ref _ 'first_name)))
  
  (define student_last_name (~> resp
                                (hash-ref _ 'student)
                                (hash-ref _ 'last_name)))
  
  (define meeting_id (~> resp
                         (hash-ref _ 'meeting)
                         (hash-ref _ 'id)))


  (define meeting_start (~> resp
                            (hash-ref _ 'meeting)
                            (hash-ref _ 'start_time)))


  (define meeting_end (~> resp
                          (hash-ref _ 'meeting)
                          (hash-ref _ 'end_time)))

  
  (define aws_key (~> resp
                      (hash-ref _ 'computer)
                      (hash-ref _ 'aws_key)))
  
  (define aws_secret_key (~> resp
                             (hash-ref _ 'computer)
                             (hash-ref _ 'aws_secret_key)))
  
  (define on_login_script (~> resp
                              (hash-ref _ 'on_login_script)))
  
  (define h
    (hash 'student_id         student_id
          'student_first_name student_first_name  
          'student_last_name  student_last_name 
          'meeting_id         meeting_id
          'meeting_start      meeting_start
          'meeting_end        meeting_end
          'aws_key            aws_key
          'aws_secret_key     aws_secret_key
          'on_login_script    on_login_script))

  (define json
    (with-output-to-string
      (thunk (write-json h))))

  (display-to-file json (build-path session-folder "data.json")
                   	#:exists 'replace)
  
  #t)

(define/contract (current-student)
  (-> student?)
  (student (get-session-data 'student_id)))

(define/contract (current-meeting)
  (-> meeting?)
  (meeting (get-session-data 'meeting_id)))

(define/contract (current-course)
  (-> course?)
  (aif (current-meeting)
       (course (course-id it))
       #f))


(define (get-session-data key)
  (hash-ref (current-session-data) key))


(define/contract (current-session-data)
  (-> hash?)
  
  (define s (file->string #:mode 'text
                          (current-session-file)))

  (read-json (open-input-string s)))

(define/contract (current-session-file)
  (-> (or/c path? #f))

  ;Most recently changed dir in SESSION-PATH
  (define session-dir
    (most-recently-changed-sub-dir SESSION-PATH))

  (define session-file (build-path SESSION-PATH session-dir "data.json"))

  (and (file-exists? session-file)
       session-file))



(define (most-recently-changed-sub-dir path)
  (first
   (sort (directory-list path)
         (λ(a b)
           (> (file-or-directory-modify-seconds (build-path path a))
              (file-or-directory-modify-seconds (build-path path b)))))))

(define (create-smw!)
  (make-directory* SMW-PATH))

(define (delete-smw!)
  (delete-directory SMW-PATH))

(define (restore-smw!)
  (restore-smw-from-url! (previous-backup-url (current-meeting)
                                              (current-student))))

(define (restore-smw-from-url! link)
  (define temp (make-temporary-file "student-backup~a.zip"))
  
  (download-file link temp)
  
  (system (~a "unzip -o " (path->string temp) " -d ~/Desktop")))


;Looks back recursively for most recent meeting with a backup url
(define/contract (previous-backup-url starting-meeting student)
  (-> meeting? student? (or/c string? #f))

  (define prev (previous-meeting starting-meeting))

  (if (not prev)
      #f
      (aif (meeting+student->backup-url prev student)
           it
           (previous-backup-url prev student))))






  


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


