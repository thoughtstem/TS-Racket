#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


(make-course-with-meetings-from-bundle! (710-mario-camp-bundle "Cal State San Marcos")
                                        csu-san-marcos
                                        290
                                        180
                                        ""
 
                                        (date-strings->dates "1:00pm"
                                                             "6/24, 6/25, 6/26, 6/27, 6/28")
                                        )