#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


(make-course-with-meetings-from-bundle! (3-5-epic-quest-bundle "Marshall Elementary")
                                        marshall
                                        190
                                        60
                                        ""
 
                                        (date-strings->dates "3:30pm"
                                                             "8/7/2019, 8/14/2019, 8/21/2019, 8/28/2019, 9/4/2019, 9/11/2019")
                                        )



