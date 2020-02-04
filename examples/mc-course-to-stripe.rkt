#lang racket

(require ts-racket
         (prefix-in reno: metacoders-dot-org-reno-site)
         )

; Set to TEST or LIVE
; .stripe-test-key and .stripe-key must exist in home directory
(set-stripe-key! LIVE) 

; ==== CREATE OR UPDATE A CITY PRODUCT ====
;(city->stripe "prod_reno" "reno")

; ==== SET A CUSTOM NAME FOR A PRODUCT ====
;(set-product-name "prod_reno" "Coding Classes in reno")

; ==== CREATE OR UPDATE A COURSE SKU ====
(course->stripe "prod_reno" reno:weekly-class-k-2nd-winter)
(course->stripe "prod_reno" reno:weekly-class-3rd-6th-winter)
(course->stripe "prod_reno" reno:weekly-class-k-2nd-spring)
(course->stripe "prod_reno" reno:weekly-class-3rd-6th-spring)

; ==== SHOW ALL PRODUCTS/CITY ====
;(show-products)

; ==== SHOW ALL SKUS ====
;(show-skus)

; ==== SHOW SKUS LINKED TO A PRODUCT/CITY ====
(show-skus "prod_reno")
(show-skus "prod_temecula")

; ==== DELETE PRODUCT AND SKU ====
;(delete-product "prod_GOdy4dsdmBozDq ")  ;Only works if all link skus are deleted first
;(delete-sku "sku_id")