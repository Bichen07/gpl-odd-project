;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::RoadLineArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'RoadLineArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::ROADLINEARRAY")
  (make-package "ROUTE_MISSION_HANDLER::ROADLINEARRAY"))

(in-package "ROS")
;;//! \htmlinclude RoadLineArray.msg.html


(defclass route_mission_handler::RoadLineArray
  :super ros::object
  :slots (_lines ))

(defmethod route_mission_handler::RoadLineArray
  (:init
   (&key
    ((:lines __lines) (let (r) (dotimes (i 0) (push (instance route_mission_handler::RoadLine :init) r)) r))
    )
   (send-super :init)
   (setq _lines __lines)
   self)
  (:lines
   (&rest __lines)
   (if (keywordp (car __lines))
       (send* _lines __lines)
     (progn
       (if __lines (setq _lines (car __lines)))
       _lines)))
  (:serialization-length
   ()
   (+
    ;; route_mission_handler/RoadLine[] _lines
    (apply #'+ (send-all _lines :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/RoadLine[] _lines
     (write-long (length _lines) s)
     (dolist (elem _lines)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/RoadLine[] _lines
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lines (let (r) (dotimes (i n) (push (instance route_mission_handler::RoadLine :init) r)) r))
     (dolist (elem- _lines)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::RoadLineArray :md5sum-) "328e2a15a161447b2069ea6540b246dc")
(setf (get route_mission_handler::RoadLineArray :datatype-) "route_mission_handler/RoadLineArray")
(setf (get route_mission_handler::RoadLineArray :definition-)
      "RoadLine[] lines

================================================================================
MSG: route_mission_handler/RoadLine
int32 id
RoadLinePoint[] points

================================================================================
MSG: route_mission_handler/RoadLinePoint
int32 id
int32 type
geometry_msgs/Point position

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :route_mission_handler/RoadLineArray "328e2a15a161447b2069ea6540b246dc")


