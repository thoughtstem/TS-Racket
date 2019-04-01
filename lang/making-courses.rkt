#lang racket
(require ts-racket
         2htdp/image)
(set-env! DEV)


(make-course-with-meetings-from-bundle! (code-your-game-bundle-spring "Doyle Elementary")
                                        doyle
                                        160
                                        60
                                        ""
 
                                        (date-strings->dates "2:05pm"
                                                             "12/8/2019, 12/15/2019, 12/22/2019, 12/29/2019, 1/6/2020, 1/13/2020, 1/20/2020")
                                        )



