#lang racket

(require ts-racket)

(set-env! PROD)

(save-meetings!
 (change-meeting-times
  (set-minutes 50)
  (course 1885)))


