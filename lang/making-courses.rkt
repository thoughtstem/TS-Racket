#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


(make-course-with-meetings-from-bundle! (code-your-game-bundle-winter "Jerabek")
                                        jerabek
                                        180
                                        60
                                        ""
 
                                        (date-strings->dates "3:15pm"
                                                             "1/18, 1/25, 2/1, 2/8, 2/22, 3/1, 2/8, 3/15")
                                        )