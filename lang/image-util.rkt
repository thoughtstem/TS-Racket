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
         ;frame

         any->image
         code-blank
         code+hints
         hint
         random-choose
         x-out
         inset-frame

         hints-on-top
         hints-on-bottom
         hints-on-right
         hints-on-left
         )  

(require 2htdp/image)

(require (prefix-in p: pict))

(require racket/class)
(require (only-in racket/draw color%))



(struct hint-settings
  (
   ;1 Relationship between hint stack and code
   hint-stack+code->pict
   ;2 Relationship hints in a stack
   hints->hint-stack
   ;3 Anchor point for start of arrow
   arrow-start-anchor
   ;4 Anchor point for end of arrow
   arrow-end-anchor
   ))

(define hints-on-top
  (hint-settings
   ;1 Relationship between hint stack and code
   (lambda (stack code) (p:vc-append 20 stack code))
   ;2 Relationship hints in a stack
   (lambda (h . hints) (apply (curry p:hb-append 10)
                              (cons h hints)))
   ;3 Anchor point for start of arrow
   p:cb-find
   ;4 Anchor point for end of arrow
   p:ct-find))


(define hints-on-bottom
  (hint-settings
   ;1 Relationship between hint stack and code
   (lambda (stack code) (p:vc-append 20 code stack))
   ;2 Relationship hints in a stack
   (lambda (h . hints) (apply (curry p:hb-append 10)
                              (cons h hints)))
   ;3 Anchor point for start of arrow
   p:ct-find
   ;4 Anchor point for end of arrow
   p:cb-find))

(define hints-on-right
  (hint-settings
   ;1 Relationship between hint stack and code
   (lambda (stack code) (p:hc-append 20 code stack))
   ;2 Relationship hints in a stack
   (lambda (h . hints) (apply (curry p:vl-append 10)
                              (cons h hints)))
   ;3 Anchor point for start of arrow
   p:lc-find
   ;4 Anchor point for end of arrow
   p:rc-find))

(define hints-on-left
  (hint-settings
   ;1 Relationship between hint stack and code
   (lambda (stack code) (p:hc-append 20 stack code))
   ;2 Relationship hints in a stack
   (lambda (h . hints) (apply (curry p:vr-append 10)
                              (cons h hints)))
   ;3 Anchor point for start of arrow
   p:rc-find
   ;4 Anchor point for end of arrow
   p:lc-find))



(define (code+hint #:settings (settings hints-on-top)
                   full-code
                   hint-targets+hint-text)

  
  (define hint-targets (take hint-targets+hint-text
                             (sub1 (length hint-targets+hint-text))))
  

  (define hint   (last   hint-targets+hint-text))

  (define (render-arrow target)
   (p:pin-arrow-line 10
                     full-code
                     hint       (hint-settings-arrow-start-anchor settings)  ;3. Anchor point for start of arrow
                     target     (hint-settings-arrow-end-anchor settings)  ;4. Anchor point for end of arrow
                     #:line-width 3
                     #:color (make-object color% 255 0 0 0.5)
                     ))

  (define imgs
    (map render-arrow
         hint-targets))

  (apply p:cc-superimpose imgs))

(define (code+hints #:settings (settings hints-on-top) code . hints)

  (define hint-stack
    (apply ;2. Relationship hints in a stack
     (hint-settings-hints->hint-stack settings)
     (map last hints)))

  (define combined
    ((hint-settings-hint-stack+code->pict settings)
     hint-stack code))

  (define (render h)
    (code+hint #:settings settings combined h))
  
  (apply p:lc-superimpose
    (map render hints)))

(define (code-blank (w 100) (h 20))
  (p:colorize (p:rectangle w h) "red"))


(define (hint . ts)
  (p:frame (p:inset
            (apply p:vl-append (map hint1 ts))
            10)
           #:color "black"))

(define (hint1 t)
  (p:colorize (if (string? t)
                  (p:text t)
                  t) "red"))


;already has a frame function in everything !!!
#;(define (frame i
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


(define (random-choose . l)
  (list-ref l (random (length l))))



(define (x-out img)
  (define img-slash (p:pin-line img
                               img p:lt-find
                               img p:rb-find
                               #:color "red"))
  (p:pin-line img-slash
              img-slash p:lb-find
              img-slash p:rt-find
              #:color "red"))


(define (inset-frame i #:color (color "black") #:amount (amount 10) #:thickness (thickness 1))
  (p:frame #:color color #:line-width thickness
   (p:inset i amount))

  )


