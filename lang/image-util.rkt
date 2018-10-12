#lang racket

(provide buffer
         logo
         scale-to-fit
         safe-above
         safe-beside
         pad-list
         cards->pages
         quest-cards->pages
         print-image!
         frame

         any->image
         )

(require 2htdp/image)

(require (prefix-in p: pict))


(define (frame i
               #:size (size 1)
               #:color (color 'black))

  (overlay i
           (rectangle (+ size (image-width i))
                      (+ size (image-height i))
                      'outline
                      color)))


(define (any->image i)
  (cond [(image? i) i]
        [(p:pict? i)  (p:pict->bitmap i)]
        [else (error "Not an image")]
        ))


(define logo (scale .6 (bitmap "resources/ts-logo.png")))

(define/contract (buffer n i)
  (-> number? image? image?)
  (overlay
   i
   (rectangle (+ n (image-width i))
              (+ n (image-height i))
              'solid 'transparent )))

(define/contract (scale-to-fit i w)
  (-> image? number? image?)
  (scale (/ w (image-width i)) i))

;creates above and beside that won't break if it's given 0 or 1 image
(define (safe f imgs)
  (cond [(= 0 (length imgs)) empty-image]
        [(= 1 (length imgs)) (first imgs)]
        [else (apply f imgs)]))

(define (safe-above . imgs)
  (safe above imgs))

(define (safe-beside . imgs)
  (safe beside imgs))

(define (safe-overlay . imgs)
  (safe overlay imgs))


;buffers when printing 3x3 cards, to standarize image size
(define/contract (pad-list imgs)
  (-> (listof image?) (listof image?))
  (define height (image-height (first imgs)))
  (define width (image-width (first imgs)))
  (define buffer-img (rectangle width height 'solid 'transparent))
  (cond [(= 0 (remainder (length imgs) 3)) imgs]
        [(= 1 (remainder (length imgs) 3)) (append imgs (list buffer-img buffer-img))]
        [(= 2 (remainder (length imgs) 3)) (append imgs (list buffer-img))]))

;makes a 3x3 page of cards to print
(define/contract (cards->pages cards)
  (-> (listof (or/c image? p:pict?)) (listof image?))

  (define (maybe-convert c)
    (if (image? c)
        c
        (p:pict->bitmap c)))
  
  (define converted-cards
    (map maybe-convert cards))
  
  (map
   (λ(l)
     (apply safe-above
            (map (curry apply safe-beside) l)))
   (map
    (λ(l) (chunks 3 l))
    (chunks 9 (pad-list converted-cards)))))




(define (quest-cards->pages cards)
  (define (shrink i)
    (p:scale i 0.25))
  
  (cards->pages
   (map shrink
        cards)))

(define (width>? s)
  (λ(i)
    (> (image-width i) s)))

(define (height>? s)
  (λ(i)
    (> (image-height i) s)))

(define (rotate-height-max i)
  (if (>= (image-height i)
          (image-width i))
      i
      (rotate 90 i)))


;prints -- on mac only??
(define/contract (print-image! p)
  (-> image? boolean?)
  (define f (make-temporary-file))
  (save-image p f)

  (system (~a "lpr " (path->string f) " -o media=letter")))

(define (chunks n l)
  (if (>= n (length l))
      (list l)
      (cons (take l n)
            (chunks n (drop l n)))))


