#lang racket

(provide buffer
         logo
         scale-to-fit
         safe-above
         safe-beside
         pad-list
         cards->pages
         print-image!
         )

(require 2htdp/image)

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
  (-> (listof image?) (listof image?))
  (map
   (λ(l)
     (apply safe-above
            (map (curry apply safe-beside) l)))
   (map
    (λ(l) (chunks 3 l))
    (chunks 9 (pad-list cards)))))

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


