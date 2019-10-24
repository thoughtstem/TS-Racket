#lang racket

(require ts-racket
         (only-in 2htdp/image scale bitmap))
(set-env! PROD)

(save-meetings!
 (set-room-id (course 1815) 587))