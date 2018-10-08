#lang scribble/manual

@(require scribble/eval)

@(define helper-eval (make-base-eval))
@interaction-eval[#:eval helper-eval
                  (require "../main.rkt"
                           2htdp/image)]

@title{TS-Racket}

@section{General}

@defproc[(save [resource resource?])
         resource?]

Stores the resource on the database (either dev or production,
depending on the @racket[set-env!]

Example:

@racketblock[
             (save (new-meeting #:course 1000
                                #:start (string->time "2018-09-10 3:30pm")
                                #:duration 60))
 ]

@defproc[(set-env! [k dev-or-prod?])
         void?]

Takes either DEV or PROD. Default is DEV.

REMINDER!! Only set to PROD after sufficient testing in DEV.

@section{Flyers}

How to use ts-racket to automate flyer generation from a course ID.

@defproc[(course->flyer [course flyer-ready-course?]
                        [selling-points (listof string?) (selling-points course)]
                        [registration-link string? "https://secure.thoughtstem.com"])
         image?]

Builds a flyer out of one course. 

NOTE: alternative spelling of flyer (flier) in this function also works.

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

@defproc[(save-meetings! [course course?])
         course?]

Calls @racket[save] on all meetings in a course.


@defproc[(make-course-with-meetings! [name string?]
                                     [description string?]
                                     [location-id number?]
                                     [price    positive?]
                                     [duration positive?]
                                     [foreign-enrollment-site string?]
                                     [screenshot-url string?]
                                     [meeting-time moment?] ...)
         course?]

Creates a course with the supplied info.

You can pass in as many meeting times as you want.  Meeting times
are Gregor moments.  See the Gregor docs for more info on moments.

@racketblock[
  (make-course-with-meetings! "Coding and Robotics"
                              coding-and-engineering-description
                              sycamore-ridge
                              330
                              60
                              "https://www.someotherschoolsite.org/Page/30492291103"
                              coding-and-engineering-screenshot

                              (string->time "2018-10-11 2:35pm")
                              (string->time "2018-10-18 2:35pm")
                              (string->time "2018-10-25 2:35pm")
                              )
 ]


@section{Constants for use in course creation}

A list of constants defined to be used in course creation. Last updated 9/7/2018

@larger{locations}

@racketblock[
  albert-einstein
  ocean-air
  ashley-falls
  sage-canyon
  sycamore-ridge
  torrey-hills
  carmel-del-mar
  del-mar-hills
  kumeyaay
  liberal-arts
  jerabek
  JCS
  deer-canyon
  language-academy
 ]

@larger{descriptions}

@racketblock[
  python-racket-description
  robotics-course-description
  code-your-game-decription
  digital-comics-description
  game-design-and-robotics-description
  coding-and-engineering-description
 ]

@larger{screenshots}

@racketblock[
 code-your-game-screenshot
 digital-comics-screenshot
 game-design-and-robotics-screenshot
 ]

@larger{selling points}

@racketblock[
 k-2nd-selling-points
 3rd-5th-selling-points
 k-2nd-del-mar-selling-points
 3rd-5th-del-mar-selling-points
 
 ]

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

