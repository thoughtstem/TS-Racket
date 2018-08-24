#lang racket

(require "../lang/common.rkt"
         2htdp/image
         simple-qr)

(set-key! "zRqrP3sCu3FERScNgL5b")
(set-env! PROD) ;Change to PROD at your own risk

(define s (student 3124))

(define bg
  (square 300 "solid" "black"))

(qr-write "https://github.com/simmone" "qr.png")

(overlay 
 (above/align "left"
              (text (first-name s) 24 "orange")
              (text (last-name s) 24 "orange")
              (bitmap/file "qr.png"))
 bg)


