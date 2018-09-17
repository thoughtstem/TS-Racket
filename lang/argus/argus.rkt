#lang racket

(provide random-dude
         cards->pages
         print-image
         pad-list)

(require 2htdp/image)

;Argus
;APEye

(define (repeat x n)
  (remove-duplicates
   (map (thunk* (x))
        (range n))))

(define (glint)
  (circle 2 "solid" "white"))

(define (eye . layers)
  (overlay/offset
   (glint)
   4 4
   (apply overlay layers)))

(define (bg c)
  (circle 20 "solid" c))

(define (outline c)
  (circle 16 "solid" c))

(define (cornea c)
  (circle 15 "solid" c))

(define (iris c)
  (circle 10 "solid" c))

(define (pupil c)
  (circle 5 "solid" c))

(define (e bg-color inside-color)
  (scale
   3
   (eye
    (pupil "black")
    (iris inside-color)
    (cornea "white")
    (outline "black")
    (bg bg-color))))

(define (eyes1 bg-color
               (inside-color "brown"))
  (overlay/offset
   (e bg-color inside-color)
   (- (image-width (e bg-color inside-color)) 10) 0
   (e bg-color inside-color)))

(define (eyes2 bg-color
               (inside-color "brown"))
  (define x (e bg-color inside-color))
  (overlay
   (overlay/offset x
                   0 (-
                      (image-width x)
                      20)
                   (eyes1 bg-color
                          inside-color))
   (circle 40
           "solid"
           bg-color)))


(define (half-circle s c)
  (crop 0 0 (* 2 s) s
        (circle s "solid"
                c)))

(define mouth-base
  (half-circle 30 "black"))

(define (mouth1)
  (overlay/align "middle" "bottom"
                 (half-circle 10 "darkred")
                 mouth-base))


(define (dude1 body eye mouth)
  (overlay
   (above
    (scale 0.5 eye)
    mouth)
   body))


(define colors
  '(red
    orange
    green
    blue
    purple
    magenta
    cyan))

(define (pick-random l)
  (list-ref l (random (length l))))

(define (random-color)
  (pick-random colors))

(define (random-eye1)
  (eyes1 (random-color)
         (random-color)))

(define (random-eye2)
  (eyes2 (random-color)
         (random-color)))

(define random-eye-funs
  (list random-eye1
        random-eye2))

(define random-mouth-funs
  (list mouth1
        (thunk (flip-vertical (mouth1)))
        (thunk (circle 10 'solid 'black))
        (thunk (square 20 'solid 'black))
        (thunk (rotate 45
                       (square 20 'solid 'black)))
        #;(thunk (star 15 'solid 'black))))

(define random-body-funs
  (list (thunk (circle 80 "solid" (random-color)))
        (thunk (square 120 "solid" (random-color)))
        (thunk (rotate 45
                       (square 100 "solid" (random-color))))
        (thunk (rotate 180
                       (star 120 "solid" (random-color))))
        (thunk (star 120 "solid" (random-color)))
        (thunk (triangle 160 "solid" (random-color)))))

(define (random-eye)
  ((pick-random random-eye-funs)))

(define (random-mouth)
  ((pick-random random-mouth-funs)))

(define (random-face)
  ((pick-random random-body-funs)))

(define (random-dude)
  (dude1 (random-face)
         (random-eye)
         (random-mouth)))

(define (random-argus f)
  (let ([eye (f)])
    (dude1 (random-face)
           (beside (rotate 15 eye)
                   (rotate -15 eye))
           (random-mouth))))




(define (try-verb)
  (pick-random
   '("try"
     "attempt"
     "toil"
     "code"
     "program"
     "struggle")))

(define (make-verb)
  (pick-random
   '("make"
     "construct"
     "complete"
     "bring to life"
     "materialize"
     "create"
     "manifest")))

(define (cool-adj)
  (pick-random
   '("awesome"
     "cool"
     "neat"
     "bomb"
     "sweet"
     "spectacular")))

(define (thing-noun)
  (pick-random
   '("thing"
     "whatzit"
     "creature"
     "entity"
     "thingy")))

(define (random-quote)
  (~a (string-titlecase (try-verb)) " to " (make-verb) " this\n"
      (cool-adj) " " (thing-noun)))

(define card-bg
  (rectangle 300
             300
             'outline
             'black))

(define (put-on-bg i)
  (overlay
   (above (text (random-quote) 20 'black)
          (square 20 "solid" "transparent")
          i)
   card-bg))



(define (safe f imgs)
  (cond [(= 0 (length imgs)) empty-image]
        [(= 1 (length imgs)) (first imgs)]
        [else (apply f imgs)]))

(define (safe-above . imgs)
  (safe above imgs))

(define (safe-beside . imgs)
  (safe beside imgs))

(define/contract (pad-list imgs)
  (-> (listof image?) (listof image?))
  (define height (image-height (first imgs)))
  (define width (image-width (first imgs)))
  (define buffer-img (rectangle width height 'solid 'transparent))
  (cond [(= 0 (remainder (length imgs) 3)) imgs]
        [(= 1 (remainder (length imgs) 3)) (append imgs (list buffer-img buffer-img))]
        [(= 2 (remainder (length imgs) 3)) (append imgs (list buffer-img))]))

;TODO: Move this to images.rkt
(define (cards->pages cards)
  (map
   (λ(l)
     (apply safe-above
            (map (curry apply safe-beside) l)))
   (map
    (λ(l) (chunks 3 l))
    (chunks 9 (pad-list cards)))))


(define (print-image p)
  (define f (make-temporary-file))
  (save-image p f)

  (system (~a "lpr " (path->string f) " -o media=letter")))

 (define (chunks n l)
    (if (>= n (length l))
        (list l)
        (cons (take l n)
              (chunks n (drop l n)))))




(define (argus-sheet)
  (define cards
    (map
     put-on-bg
     (append
   
      ;Eye cards
      (repeat random-eye 40)

      ;Face cards
      (repeat random-dude 40)

      ;Argus cards
      (repeat (thunk (random-argus random-dude)) 40)

      ;Argus2 cards
      (repeat (thunk
               (random-argus
                (thunk (random-argus random-dude)))) 40))))



 
  (define pages (cards->pages cards))

  #;(print-image (first pages))
  pages
  )

;Print all?
;(map print-image pages)


