#lang racket
(require ts-racket
         2htdp/image)
(set-env! DEV)


(make-course-with-meetings-from-bundle! (36-pokemon-camp-bundle "Fleet Science Center")
                                        fleet
                                        215
                                        180
                                        ""
 
                                        (date-strings->dates "9:00am"
                                                             "7/22, 7/23, 7/24, 7/25, 7/26")
                                        )