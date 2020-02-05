#lang racket

(require ts-racket
         (prefix-in dallas: metacoders-dot-org-dallas-site)
         )

; Set to TEST or LIVE
; .stripe-test-key and .stripe-key must exist in home directory
(set-stripe-key! LIVE) 

; ==== CREATE OR UPDATE A CITY PRODUCT ====
;(city->stripe "prod_reno" "reno")

; ==== SET A CUSTOM NAME FOR A PRODUCT ====
;(set-product-name "prod_reno" "Coding Classes in reno")

; ==== CREATE OR UPDATE A COURSE SKU ====
(course->stripe "prod_dallas" dallas:summer-camp-zoo-k-2nd-7/6)
(course->stripe "prod_dallas" dallas:summer-camp-cartoon-k-2nd-7/6)
(course->stripe "prod_dallas" dallas:summer-camp-fortnite-3-6th-7/6)
(course->stripe "prod_dallas" dallas:summer-camp-harry-3-6th-7/6)
(course->stripe "prod_dallas" dallas:summer-camp-farm-k-2nd-7/13)
(course->stripe "prod_dallas" dallas:summer-camp-pokemon-k-2nd-7/13)
(course->stripe "prod_dallas" dallas:summer-camp-minecraft-3rd-6th-7/13)
(course->stripe "prod_dallas" dallas:summer-camp-marvel-3rd-6th-7/13)
(course->stripe "prod_dallas" dallas:summer-camp-cartoon-k-2nd-7/20)
(course->stripe "prod_dallas" dallas:summer-camp-zoo-k-2nd-7/20)
(course->stripe "prod_dallas" dallas:summer-camp-starwars-3rd-6th-7/20)
(course->stripe "prod_dallas" dallas:summer-camp-pokemon-3-6th-7/20)
(course->stripe "prod_dallas" dallas:summer-camp-pokemon-k-2nd-7/27)
(course->stripe "prod_dallas" dallas:summer-camp-farm-k-2nd-7/27)
(course->stripe "prod_dallas" dallas:summer-camp-mario-3-6th-7/27)
(course->stripe "prod_dallas" dallas:summer-camp-fortnite-3-6th-7/27)
(course->stripe "prod_dallas" dallas:summer-camp-zoo-k-2nd-8/3)
(course->stripe "prod_dallas" dallas:summer-camp-cartoon-k-2nd-8/3)
(course->stripe "prod_dallas" dallas:summer-camp-harrypotter-3-6th-8/3)
(course->stripe "prod_dallas" dallas:summer-camp-minecraft-3-6th-8/3)


; ==== SHOW ALL PRODUCTS/CITY ====
;(show-products)

; ==== SHOW ALL SKUS ====
;(show-skus)

; ==== SHOW SKUS LINKED TO A PRODUCT/CITY ====
;(show-skus "prod_dallas")
;(show-skus "prod_temecula")

; ==== DELETE PRODUCT AND SKU ====
;(delete-product "prod_GOdy4dsdmBozDq ")  ;Only works if all link skus are deleted first
;(delete-sku "sku_id")