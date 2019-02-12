#lang racket
(require ts-racket
         2htdp/image)
(set-env! PROD)


;(make-course-with-meetings-from-bundle! (k2-camp-d-bundle "San Diego Christian College")
 ;                                       san-diego-christian-college
  ;                                      330
   ;                                     240
    ;                                    ""
 
     ;                                   (date-strings->dates "9:00am"
      ;                                                       "7/22, 7/23, 7/24, 7/25, 7/26")
       ;                                 )


(make-course-with-meetings-from-bundle! (superhero-game-spring "Bird Rock Elementary")
                                        bird-rock
                                        205
                                        60
                                        ""
 
                                        (date-strings->dates "3:10pm"
                                                             "4/11, 4/18, 4/25, 5/2, 5/9, 5/16, 5/23, 5/30")
                                        )