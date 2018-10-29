#lang racket

(provide make-flier-bg)

(require 2htdp/image)

(define (make-flier-bg i1 i2 i3)
  ;Definitions for all composable flyer image pieces. Note: course images must be larger than 792 X 936
  (define header (bitmap "resources/header.png"))
  (define middle (bitmap "resources/middle.png"))
  (define bottom (bitmap "resources/bottom.png"))
  (define white-divider (rectangle 2550 10 "solid" "white"))
  ;(define sticker (bitmap "resources/sticker.png"))
  (define sticker (circle 10 "outline" "transparent"))
  
  ;Switch out course images as necessary here:
  (define image-row
    (overlay
     (beside
      (crop 0 0 792 936 i1)
      (rectangle 10 936 "solid" "white")
      (crop 0 0 792 936 i2)
      (rectangle 10 936 "solid" "white")
      (crop 0 0 792 936 i3))
     (rectangle 2550 936 "solid" "white")))

  (define flier-underneath
    (above
     header
     middle
     white-divider
     image-row
     white-divider
     bottom))

;Generates flyer background
  (place-image/align
   (scale 0.95 sticker)
   (- (image-width flier-underneath) 80)
   (- (image-height flier-underneath) 80) "right" "bottom"
   flier-underneath))

(module+ test
  (make-flier-bg
   (bitmap "resources/student-image-2.jpg")
   (bitmap "resources/k-2nd-screenshot.png")
   (bitmap "resources/student-image-1.jpg")))