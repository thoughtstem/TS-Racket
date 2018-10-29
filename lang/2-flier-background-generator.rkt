#lang racket

(provide make-2-course-flier-bg)

(require 2htdp/image)

(define (make-2-course-flier-bg i1 i2 i3 i4)
  ;Definitions for all composable flyer image pieces. Note: all images should be 792 X 972
  (define header (bitmap "resources/header.png"))
  (define register-today-banner (bitmap "resources/register-today.png"))
  (define blue-section (bitmap "resources/blue-section.png"))
  (define purple-section (bitmap "resources/purple-section.png"))
  (define footer (bitmap "resources/thinner-footer.png"))
  (define sticker (bitmap "resources/sticker.png"))
  ;(define sticker (bitmap "resources/sticker-nov.png"))
  ;(define sticker (circle 10 "outline" "transparent"))
  ;(define course-image-2 (bitmap "resources/superhero-screenshot.png"))
  ;(define course-image-1 (bitmap "resources/survival-screenshot.png"))
  ;(define student-image-1 (bitmap "resources/student-image-1.jpg"))
  ;(define student-image-2 (bitmap "resources/student-image-2.jpg"))
  (define white-divider (rectangle 2550 10 "solid" "white"))

  ;Switch out course images as necessary for row 1; these are cropped to 792 x 895
  (define image-row-1
    (overlay
     (beside
      (crop 0 0 792 895 i1)
      (rectangle 10 895 "solid" "white")
      (crop 0 0 792 895 i3)
      (rectangle 10 895 "solid" "white")
      (crop 0 0 792 895 i2))
     (rectangle 2550 895 "solid" "white")))

  ;Switch out course images as necessary here; these are cropped to 792 x 980
  (define image-row-2
    (overlay
     (beside
      blue-section
      (rectangle 10 980 "solid" "white")
      (crop 0 0 792 980 i4)
      (rectangle 10 980 "solid" "white")
      purple-section)
     (rectangle 2550 980 "solid" "white")))

  (define flier-underneath
    (above
     header
     register-today-banner
     white-divider
     image-row-1
     white-divider
     image-row-2
     white-divider
     footer))
  
  ;Generates flyer background
  (place-image/align
   (scale 0.95 sticker)
   (- (image-width flier-underneath) 80)
   (- (image-height flier-underneath) 80) "right" "bottom"
   flier-underneath))

(module+ test
  (make-2-course-flier-bg
   (bitmap "resources/template_image_2course.jpg")
   (bitmap "resources/template_image_2course.jpg")
   (bitmap "resources/template_image_2course.jpg")
   (bitmap "resources/template_image_2course.jpg")))