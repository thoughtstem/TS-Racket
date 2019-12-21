#lang racket

(require ts-racket
         (prefix-in dallas: metacoders-dot-org-dallas-site))

(set-stripe-key! TEST)

(set-product-name "prod_GKyO5SUplscDn4" "Coding Classes in Space")

;(course->stripe "prod_GKyO5SUplscDn4" (dallas:weekly-class-k-2nd-winter))
;(course->stripe "prod_GKyO5SUplscDn4" (dallas:weekly-class-3rd-6th-winter))
;(course->stripe "prod_GKyO5SUplscDn4" (dallas:weekly-class-k-2nd-spring))
;(course->stripe "prod_GKyO5SUplscDn4" (dallas:weekly-class-3rd-6th-spring))
