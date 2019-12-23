#lang racket

(require ts-racket
         (prefix-in dallas: metacoders-dot-org-dallas-site)
         (prefix-in reno:   metacoders-dot-org-reno-site))

; Set to TEST or LIVE
; .stripe-test-key and .stripe-key must exist in home directory
(set-stripe-key! TEST) 

; ==== SET A CUSTOM NAME FOR A PRODUCT ====
(set-product-name "prod_GKyO5SUplscDn4" "Coding Classes in Dallas")

; ==== CREATE OR UPDATE A CITY PRODUCT ====
(city->stripe "prod_GKyO5SUplscDn4" "Dallas")

; ==== CREATE OR UPDATE A COURSE SKU ====
(course->stripe "prod_GKyO5SUplscDn4" (dallas:weekly-class-k-2nd-winter))
(course->stripe "prod_GKyO5SUplscDn4" (dallas:weekly-class-3rd-6th-winter))
(course->stripe "prod_GKyO5SUplscDn4" (dallas:weekly-class-k-2nd-spring))
(course->stripe "prod_GKyO5SUplscDn4" (dallas:weekly-class-3rd-6th-spring))

(city->stripe "prod_reno" "Reno")

(course->stripe "prod_reno" (reno:weekly-class-k-2nd-winter))
(course->stripe "prod_reno" (reno:weekly-class-3rd-6th-winter))
(course->stripe "prod_reno" (reno:weekly-class-k-2nd-spring))
(course->stripe "prod_reno" (reno:weekly-class-3rd-6th-spring))

; ==== SHOW ALL PRODUCTS/CITY ====
(show-products)

; ==== SHOW ALL SKUS ====
(show-skus)

; ==== SHOW SKUS LINKED TO A PRODUCT/CITY ====
(show-skus "prod_reno")

; ==== DELETE PRODUCT AND SKU ====
#;(delete-product "prod_id")  ;Only works if all link skus are deleted first
#;(delete-sku "sku_id")