;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ItriPoint)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ItriPoint (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::ITRIPOINT")
  (make-package "ROUTE_MISSION_HANDLER::ITRIPOINT"))

(in-package "ROS")
;;//! \htmlinclude ItriPoint.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass route_mission_handler::ItriPoint
  :super ros::object
  :slots (_id _belongId _pointId _pose ))

(defmethod route_mission_handler::ItriPoint
  (:init
   (&key
    ((:id __id) 0)
    ((:belongId __belongId) 0)
    ((:pointId __pointId) 0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _belongId (round __belongId))
   (setq _pointId (round __pointId))
   (setq _pose __pose)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:belongId
   (&optional __belongId)
   (if __belongId (setq _belongId __belongId)) _belongId)
  (:pointId
   (&optional __pointId)
   (if __pointId (setq _pointId __pointId)) _pointId)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32 _belongId
    4
    ;; int32 _pointId
    4
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32 _belongId
       (write-long _belongId s)
     ;; int32 _pointId
       (write-long _pointId s)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _belongId
     (setq _belongId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pointId
     (setq _pointId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(setf (get route_mission_handler::ItriPoint :md5sum-) "94c2a604eb2c001106c7c24de38072ce")
(setf (get route_mission_handler::ItriPoint :datatype-) "route_mission_handler/ItriPoint")
(setf (get route_mission_handler::ItriPoint :definition-)
      "int32 id
int32 belongId
int32 pointId
geometry_msgs/Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :route_mission_handler/ItriPoint "94c2a604eb2c001106c7c24de38072ce")


