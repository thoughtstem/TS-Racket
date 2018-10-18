#lang racket

(provide make-flier-bg)

(require 2htdp/image)

(define (make-flier-bg i1 i2 i3)
  ;Definitions for all composable flyer image pieces. Note: course images must be 792 X 936
  (define header (bitmap "resources/header.png"))
  (define middle (bitmap "resources/middle.png"))
  (define bottom (bitmap "resources/bottom.png"))
  (define white-divider (rectangle 2550 10 "solid" "white"))

  ;Switch out course images as necessary here:
  (define image-row
    (overlay
     (beside
      i1
      (rectangle 10 936 "solid" "white")
      i2
      (rectangle 10 936 "solid" "white")
      i3)
     (rectangle 2550 936 "solid" "white")))

  ;Generates flyer background
  (above
   header
   middle
   white-divider
   image-row
   white-divider
   bottom))

(module+ test
  (make-flier-bg
   (bitmap "resources/template-image.jpg")
   (bitmap "resources/template-image.jpg")
   (bitmap "resources/template-image.jpg")))