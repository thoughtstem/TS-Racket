#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


(make-course-with-meetings-from-bundle! (superhero-game-spring "Old Town")
                                        old-town
                                        180
                                        60
                                        ""
 
                                        (date-strings->dates "3:15pm"
                                                             "4/1, 4/8, 4/15, 4/29, 5/6, 5/13, 5/20, 6/3")
                                        )