#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


(make-course-with-meetings-from-bundle! (code-your-game-bundle-spring "Urban Discovery Academy")
                                        urban-discovery
                                        260
                                        125
                                        ""
 
                                        (date-strings->dates "11:55am"
                                                             "3/13, 3/20, 4/3, 4/10, 4/17, 4/24, 5/1, 5/8, 5/15, 5/22, 5/29, 6/5")
                                        )



