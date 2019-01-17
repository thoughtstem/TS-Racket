#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


(make-course-with-meetings-from-bundle! (code-your-game-bundle-spring "Westwood")
                                        west-wood
                                        190
                                        60
                                        ""
 
                                        (date-strings->dates "2:00pm"
                                                             "3/20, 3/27, 4/3, 4/10, 4/24, 5/1, 5/8, 5/15")
                                        )