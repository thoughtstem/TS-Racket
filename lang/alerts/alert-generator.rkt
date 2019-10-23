#lang racket

(provide send-alerts
         create-alerts
         make-camp
         voice-alert
         phone-alert
         help-alert
         full-alert
         block-alert
         message-alert
         link-alert
         command-alert
         alert-type?
         combine-alerts
         clear-alerts

         on-computers)

(require racket/date
         racket/gui
         racket/hash
         json
         aws/keys
         aws/s3
         aws/util)


; ==== ALERT GENERATOR NOTES (READ ME FIRST) ====
; Modify the definition below and run the program to send alerts to computers.
;   - phone, help, full, and block alerts stay up for 5 minutes or until the entry is removed
;   - message alerts stay up for 1 minute
;   - voice alerts speaks only once or twice but the message stays up for 1 minute
;   - link alerts will open a url in a new tab.
;   - command alerts will run any system command.
; TODO: retrieve data from aws and list existing alerts.
;       create a gui (select multiple computers, add/remove/modify entries, generate alet.json button)

(define phone-alert   "phone")
(define help-alert    "help")
(define full-alert    "full")
(define block-alert   "block")
(define voice-alert   "voice")
(define message-alert "message")
(define link-alert    "link")
(define command-alert "command")

(define (alert-type? s)
  (and (string? s)
       (member s (list phone-alert
                       help-alert
                       full-alert
                       block-alert
                       voice-alert
                       message-alert
                       link-alert
                       command-alert))))



(date-display-format 'iso-8601)

(define (create-alert type [message ""])
  (hasheq 'alert_type type
          'alert_enabled #t
          'alert_date (date->string (current-date) #t)
          'alert_message (cond [(eq? type "phone")    "Please call the office ASAP."]
                               [(eq? type "help")     "This student needs assistance."]
                               [(eq? type "full")     "Please give the instructor your full attention."]
                               [(eq? type "block")    message]
                               [(eq? type "message")  message]
                               [(eq? type "voice")    message]
                               [else                  message])))

(define ALERT-PATH (string->path "alert.json"))

(define (download-file)
  (read-keys) ; Default path: "~/.aws-keys"
  (s3-region "us-west-1")
  ;(ls "ts-email-assets-and-stuff/")

  (get/file "ts-email-assets-and-stuff/alert.json"
            ALERT-PATH
            #:exists 'replace))

(define (get-data)
  (define in (open-input-file ALERT-PATH))
  (define all-data (read-json in))
  (close-input-port in)
  all-data)

(define/contract (create-alerts computer-list type [message ""])
  (->* ((or/c list? string?) alert-type?) (string?) hash?)
  (define pair-alert
    (lambda (computer)
      (cons computer (create-alert type message))))
  ;(make-immutable-hasheq (map pair-alert (zero-pad-if-numbers computer-list)))
  (make-immutable-hasheq (map pair-alert (map string->symbol (map number->string computer-list))))
  )
                
(define (update-data hash computer alert)
  (hash-set hash computer alert))

(define (remove-alert hash computer)
  (hash-remove hash computer))

(define (add-ts-prefix num-str)
  (define num-val (string->number num-str))
  (cond
    [(< num-val 10) (list (string->symbol (string-append "ts" num-str))
                          (string->symbol (string-append "ts00" num-str)))]
    [(< num-val 100)(list (string->symbol (string-append "ts" num-str))
                          (string->symbol (string-append "ts0" num-str)))]
    [else           (list (string->symbol (string-append "ts" num-str)))]))


(define (zero-pad-if-numbers ls)
  (make-camp (if (list? ls)
                 (string-join (map ~a ls) ",")
                 ls)))

(define (make-camp camp-list)
  (define computers (string-split camp-list ","))
  (flatten (map add-ts-prefix computers)))


(define ts-camp
  (make-camp "71,114,44,318,315"))

(define ucsd-camp1
  (make-camp "65,81,99,60,102,97,84,64,121,78,76,108,62,116,99,103,87"))
  
(define ucsd-camp2
  (make-camp "59,88,94,110,75,112,69,70,61,118,115,104,72,95,101,77,79,85,67,111,90,119"))

(define temp-list
  (make-camp "84,108"))

(define quick-test
  (make-camp "23"))


(define (send-alerts alerts)
  (define all-data
    (hash-union
     ; ==== CAMP ALERTS ====
     ;(create-alerts ts-camp "voice" "Test")  ; Creates the same alert for each computer in ts-camp
     ;(create-alerts ucsd-camp1 "command" "sudo sed -i 's/tv_main:add(tabs.play_online)/--tv_main:add(tabs.play_online)/' /usr/share/minetest/builtin/mainmenu/init.lua")
     ;(create-alerts ucsd-camp2 "command" "sudo sed -i 's/tv_main:add(tabs.play_online)/--tv_main:add(tabs.play_online)/' /usr/share/minetest/builtin/mainmenu/init.lua")
     ;(create-alerts temp-list "block" "Please open TS Student Login and click backup\nand logout before continuing on the computer")
     ;(create-alerts ucsd-camp2 "voice" "Reminder: Jigyasa Nayak is getting picked up 5 minutes.")
     ;(create-alerts ucsd-camp2 "message" "Miles and Benjamin are still not scanned in.")
     ;(create-alerts (make-camp "39,269") "link" "https://ts-work-group.slack.com/")

     alerts
   
     ; ==== INDIVIDUAL ALERTS ===
     ; These will overide any alerts class alerts create above
     (hasheq 'blank ""
             ;'ts000 (create-alert "command" "sudo sed -i 's/tv_main:add(tabs.play_online)/--tv_main:add(tabs.play_online)/' /usr/share/minetest/builtin/mainmenu/init.lua")
             ;'ts000 (create-alert "command" "sudo wget -q http://bit.ly/2Mw1tLz -O /usr/share/minetest/builtin/mainmenu/init.lua")
             ;'ts000 (crreat-alert "full")
             )
     #:combine/key (lambda (k v1 v2) v2)))
  
  (define (write-data)
    (define out (open-output-file ALERT-PATH #:exists 'replace))
    (write-json all-data out)
    (close-output-port out))

  (define (upload-data)
    (read-keys) ; Default path: "~/.aws-keys"
    (s3-region "us-west-1")
    (s3-host "s3-us-west-1.amazonaws.com")
    ;(ls "ts-email-assets-and-stuff/")

    (put/file "ts-email-assets-and-stuff/alert.json"
              ALERT-PATH))



  (write-data)
  (upload-data))

(define (combine-alerts . alerts)
  (apply (curry hash-union #:combine/key (lambda (k v1 v2) v2)) alerts))

(define (clear-alerts)
  (send-alerts (create-alerts "" message-alert "")))



(define-syntax-rule (on-computers computer-ids ... #:do command)
  (begin
    (define payload 'command)

    (send-alerts
      (create-alerts (string-join (map ~a (flatten (list computer-ids ...))) ",") command-alert
                     (string-replace
                      (~a "racket -e \"(begin (require ts-racket) " (~s payload) ")\"")  "!" "\\!"
                      )))))






