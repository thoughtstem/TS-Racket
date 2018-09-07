#lang scribble/manual

@(require scribble/eval)

@title{TS-Racket}



@section{Flyers}

How to use ts-racket to automate flyer generation from a course ID.

@defproc[(course->flyer [course flyer-ready-course?]
                        [selling-points (listof string?) (selling-points course)]
                        [registration-link string? "https://secure.thoughtstem.com"])
         image?]


Builds a flyer out of one course. 

NOTE: alternative spelling of flyer (flier) in this function also works.

@(define helper-eval (make-base-eval))
@interaction-eval[#:eval helper-eval
                  (require "../main.rkt"
                           2htdp/image)]

@examples[
          #:eval helper-eval
          (scale .3 (course->flyer (course 1137)))]


@defproc[(courses->flyer [course flyer-ready-course?]
                         [course2 flyer-ready-course?]
                         [selling-points (listof string?) (selling-points course)]
                         [selling-points2 (listof string?) (selling-points course2)]
                         [registration-link string? "https://secure.thoughtstem.com"])
         image?]

Builds a flyer out of 2 courses (to be used for two courses at one location).

NOTE: alternative spelling of flyer (flier) in this function also works.

@examples[
          #:eval helper-eval
          (scale .3 (courses->flyer (course 1137) (course 1128)))]

@section{Courses}

@defproc[(course [id number?])
         course?]

Returns a course in the form of hash. 

@defproc[(set-room-id [resource (or/c meeting? course?)]
                      [room-id number?])
         (or/c meeting? course?)]

Using this function, you can set the room id for either a singular
meeting or all the meetings in a course.

Reminder!! This does not update information in the environment. You must call
@racket[save] or @racket[save-meetings!] to make changes permanently to the
environment.


save-meetings!
call (link save) on all the courses' meetings

save
takes a hash
keys that are simple values pushed to the set environment

set-env!
PROD
default is dev




@section{Alerts}

@defproc[(send-alerts [alerts alerts?])
         void?]

Sends alerts.  Alerts should be created with @racket[create-alerts].
For example, this will send an alert to all computers at meeting 6686.

@racketblock[
 (send-alerts
  (create-alerts
   (computer-ids (meeting 6686))
   voice-alert
   "Test!"))
]

@defproc[(create-alerts [computer-ids (or/c (listof number?)
                                            string?)]
                        [alert-type alert-type?]
                        [message string?])
         alerts?]

Creates alerts for some list of computer ids.  The computer
ids can either be a comma separated string (for easy pasting):

@racket["1,2,3"]

Or it can be a list of numbers:

@racket['(1 2 3)]


@defproc[(alert-type? [x any/c])
         boolean?]

Can be any member of the following constants.

@racketblock[
 (define phone-alert   "phone")
 (define help-alert    "help")
 (define full-alert    "full")
 (define block-alert   "block")
 (define voice-alert   "voice")
 (define message-alert "message")
 (define link-alert    "link")
 (define command-alert "common")
 ]


