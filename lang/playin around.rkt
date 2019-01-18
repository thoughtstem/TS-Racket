#lang racket

(require 2htdp/image)


(overlay/offset
   (overlay/offset (circle 30 'solid (color 0 150 0 127))
                   26 0
                   (circle 30 'solid (color 0 0 255 127)))
   0 26
   (circle 30 'solid (color 200 0 0 127)))