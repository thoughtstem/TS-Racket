#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)



(make-course-with-meetings-from-bundle! (generic-course-k-2 "Kumeyaay Elementary")

                                        kumeyaay
                                        210
                                        60
                                        ""
 

                                        (date-strings->dates "2:15pm"
                                                             "1/14/2020, 1/21/2020, 1/28/2020, 2/4/2020, 2/11/2020, 2/18/2020, 2/25/2020, 3/3/2020"))

                                        


(make-course-with-meetings-from-bundle! (generic-course-3-5 "Kumeyaay Elementary")

                                        kumeyaay
                                        210
                                        60
                                        ""
 

                                        (date-strings->dates "2:15pm"
                                                             "1/14/2020, 1/21/2020, 1/28/2020, 2/4/2020, 2/11/2020, 2/18/2020, 2/25/2020, 3/3/2020"))


;generic-course-k-2