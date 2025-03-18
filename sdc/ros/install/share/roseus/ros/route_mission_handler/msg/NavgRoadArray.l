;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::NavgRoadArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'NavgRoadArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::NAVGROADARRAY")
  (make-package "ROUTE_MISSION_HANDLER::NAVGROADARRAY"))

(in-package "ROS")
;;//! \htmlinclude NavgRoadArray.msg.html


(defclass route_mission_handler::NavgRoadArray
  :super ros::object
  :slots (_navgroads ))

(defmethod route_mission_handler::NavgRoadArray
  (:init
   (&key
    ((:navgroads __navgroads) (let (r) (dotimes (i 0) (push (instance route_mission_handler::NavgRoad :init) r)) r))
    )
   (send-super :init)
   (setq _navgroads __navgroads)
   self)
  (:navgroads
   (&rest __navgroads)
   (if (keywordp (car __navgroads))
       (send* _navgroads __navgroads)
     (progn
       (if __navgroads (setq _navgroads (car __navgroads)))
       _navgroads)))
  (:serialization-length
   ()
   (+
    ;; route_mission_handler/NavgRoad[] _navgroads
    (apply #'+ (send-all _navgroads :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/NavgRoad[] _navgroads
     (write-long (length _navgroads) s)
     (dolist (elem _navgroads)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/NavgRoad[] _navgroads
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _navgroads (let (r) (dotimes (i n) (push (instance route_mission_handler::NavgRoad :init) r)) r))
     (dolist (elem- _navgroads)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::NavgRoadArray :md5sum-) "f4863e0e051c2896d5fc07e0c9811ff2")
(setf (get route_mission_handler::NavgRoadArray :datatype-) "route_mission_handler/NavgRoadArray")
(setf (get route_mission_handler::NavgRoadArray :definition-)
      "NavgRoad[] navgroads
================================================================================
MSG: route_mission_handler/NavgRoad
int32 ITRI_AREA=5
int32 EXPRESS_WAY=8
int32 EXIT_GATEWAY=20
int32 ENTRY_GATEWAY=21

int32 id
int32 positiveLaneNum
int32 negativeLaneNum
bool twoWay
int32[] positiveLaneIds
int32[] negativeLaneIds
int32 mode
int32 r_class
int32 routing
float32 n_as
float32 n_kph
float32 p_as
float32 p_kph
float32 length
ItriPoint[] points
ConnectedNavgRoad[] heads
ConnectedNavgRoad[] tails
int32 type

================================================================================
MSG: route_mission_handler/ItriPoint
int32 id
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

================================================================================
MSG: route_mission_handler/ConnectedNavgRoad
int32 id
int32 pointId
float32 length

")



(provide :route_mission_handler/NavgRoadArray "f4863e0e051c2896d5fc07e0c9811ff2")


