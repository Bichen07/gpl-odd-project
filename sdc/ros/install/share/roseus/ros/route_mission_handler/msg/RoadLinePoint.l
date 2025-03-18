;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::RoadLinePoint)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'RoadLinePoint (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::ROADLINEPOINT")
  (make-package "ROUTE_MISSION_HANDLER::ROADLINEPOINT"))

(in-package "ROS")
;;//! \htmlinclude RoadLinePoint.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass route_mission_handler::RoadLinePoint
  :super ros::object
  :slots (_id _type _position ))

(defmethod route_mission_handler::RoadLinePoint
  (:init
   (&key
    ((:id __id) 0)
    ((:type __type) 0)
    ((:position __position) (instance geometry_msgs::Point :init))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _type (round __type))
   (setq _position __position)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32 _type
    4
    ;; geometry_msgs/Point _position
    (send _position :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32 _type
       (write-long _type s)
     ;; geometry_msgs/Point _position
       (send _position :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;;
   self)
  )

(setf (get route_mission_handler::RoadLinePoint :md5sum-) "09388098fb16fa8fbcb4f4f1d9b54fc9")
(setf (get route_mission_handler::RoadLinePoint :datatype-) "route_mission_handler/RoadLinePoint")
(setf (get route_mission_handler::RoadLinePoint :definition-)
      "int32 id
int32 type
geometry_msgs/Point position

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :route_mission_handler/RoadLinePoint "09388098fb16fa8fbcb4f4f1d9b54fc9")


