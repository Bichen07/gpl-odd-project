;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::RoadLine)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'RoadLine (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::ROADLINE")
  (make-package "ROUTE_MISSION_HANDLER::ROADLINE"))

(in-package "ROS")
;;//! \htmlinclude RoadLine.msg.html


(defclass route_mission_handler::RoadLine
  :super ros::object
  :slots (_id _points ))

(defmethod route_mission_handler::RoadLine
  (:init
   (&key
    ((:id __id) 0)
    ((:points __points) (let (r) (dotimes (i 0) (push (instance route_mission_handler::RoadLinePoint :init) r)) r))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _points __points)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; route_mission_handler/RoadLinePoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; route_mission_handler/RoadLinePoint[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; route_mission_handler/RoadLinePoint[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance route_mission_handler::RoadLinePoint :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::RoadLine :md5sum-) "b3a7ceb558b583abe36490972467f60e")
(setf (get route_mission_handler::RoadLine :datatype-) "route_mission_handler/RoadLine")
(setf (get route_mission_handler::RoadLine :definition-)
      "int32 id
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



(provide :route_mission_handler/RoadLine "b3a7ceb558b583abe36490972467f60e")


