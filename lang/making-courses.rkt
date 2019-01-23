#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


(make-course-with-meetings-from-bundle! (710-harry-potter-camp-bundle "UCSD")
                                        ucsd-summer-camp
                                        370
                                        240
                                        ""
 
                                        (date-strings->dates "9:00am"
                                                             "7/1, 7/2, 7/3, 7/5")
                                        )