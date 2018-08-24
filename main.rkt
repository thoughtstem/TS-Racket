(module ts-racket racket
  (provide
   (all-from-out "./lang/common.rkt")
   #%module-begin)

  (require "./lang/common.rkt"))
