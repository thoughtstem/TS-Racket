#lang racket

(require ts-racket)

(set-env! PROD)

(save-meetings!
 (change-meeting-times
  (set-minutes 60)
  (course 1247)))