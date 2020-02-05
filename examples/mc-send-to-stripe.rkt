#lang racket

(require ts-racket/lang/stripe-util
         metacoders-dot-org-reno-site ;use prefix-in if updating multiple cities
         )

; Set to TEST or LIVE
; .stripe-test-key and .stripe-key must exist in home directory
(set-stripe-key! TEST) 

; ==== CREATE OR UPDATE A CITY PRODUCT ====
#;(city->stripe "prod_reno" "reno")

; ==== SET A CUSTOM NAME FOR A PRODUCT ====
#;(set-product-name "prod_reno" "Coding Classes in reno")

; ==== CREATE OR UPDATE A COURSE SKU ====
#;(course->stripe "prod_reno" weekly-class-k-2nd-winter)
#;(course->stripe "prod_reno" weekly-class-3rd-6th-winter)

; ==== CREATE OR UPDATE A CAMP SKU ====
#;(course->stripe "prod_reno" summer-camp-zoo-k-2nd-7/6)
#;(course->stripe "prod_reno" summer-camp-cartoon-k-2nd-7/6)

; ==== CREATE OR UPDATE MULTIPLE COURSE SKUS ====  
(courses->stripe "prod_reno"
                 weekly-class-k-2nd-winter
                 weekly-class-3rd-6th-winter
                 weekly-class-k-2nd-spring
                 weekly-class-3rd-6th-spring)

; ==== CREATE OR UPDATE MULTIPLE CAMP SKUS ====
(camps->stripe "prod_reno"
               summer-camp-zoo-k-2nd-7/6
               summer-camp-cartoon-k-2nd-7/6
               summer-camp-minecraft-3rd-6th-7/13
               summer-camp-marvel-3rd-6th-7/13)

; ==== SHOW ALL PRODUCTS/CITY ====
(show-products)

; ==== SHOW ALL SKUS ====
#;(show-skus)

; ==== SHOW SKUS LINKED TO A PRODUCT/CITY ====
(show-skus "prod_reno")

; ==== DELETE PRODUCT AND SKU ====
#;(delete-product "prod_GOdy4dsdmBozDq ")  ;Only works if all linked skus are deleted first
#;(delete-sku "sku_id")