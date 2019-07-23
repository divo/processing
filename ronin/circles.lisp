; this demo shows how to use the mouse events to draw make a simple drawing tool.
;
(clear)
;
(def prev-pos {:x 0 :y 0})
;
(defn stroke-color 
  (e) 
  (if 
    (of e :is-down) "#ffb545" "#72dec2")) 
;
(defn draw-circle 
  (e) 
  (
    (set prev-pos :x 
      (of e :x) :y 
      (of e :y)) 
    (stroke 
      (circle 
        (of e :x) 
        (of e :y) 30) 4 
      (stroke-color e))))
;
(on "mouse-down" draw-circle)
(on "mouse-up" draw-circle)
(on "mouse-move" draw-circle)