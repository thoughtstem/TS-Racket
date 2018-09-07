#lang scribble/manual

@(require scribble/eval)

@title{TS-Racket}

@section{General}

@defproc[(save [resource resource?])
         resource?]

Stores the resource on the database (either dev or production,
depending on the @racket[set-env!]

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

@defproc[(save-meetings! [course course?])
         course?]

Calls @racket[save] on all meetings in a course.

