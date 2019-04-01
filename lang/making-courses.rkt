#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


(make-course-with-meetings-from-bundle! (code-your-game-bundle-spring "Doyle Elementary")
                                        doyle
                                        160
                                        60
                                        ""
 
                                        (date-strings->dates "2:05pm"
                                                             "4/8, 4/15, 4/22, 4/29, 5/6, 5/13, 5/20")
                                        )



