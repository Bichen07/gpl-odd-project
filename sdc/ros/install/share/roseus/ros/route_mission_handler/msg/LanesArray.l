;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::LanesArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'LanesArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::LANESARRAY")
  (make-package "ROUTE_MISSION_HANDLER::LANESARRAY"))

(in-package "ROS")
;;//! \htmlinclude LanesArray.msg.html


(defclass route_mission_handler::LanesArray
  :super ros::object
  :slots (_lanes ))

(defmethod route_mission_handler::LanesArray
  (:init
   (&key
    ((:lanes __lanes) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Lanes :init) r)) r))
    )
   (send-super :init)
   (setq _lanes __lanes)
   self)
  (:lanes
   (&rest __lanes)
   (if (keywordp (car __lanes))
       (send* _lanes __lanes)
     (progn
       (if __lanes (setq _lanes (car __lanes)))
       _lanes)))
  (:serialization-length
   ()
   (+
    ;; route_mission_handler/Lanes[] _lanes
    (apply #'+ (send-all _lanes :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/Lanes[] _lanes
     (write-long (length _lanes) s)
     (dolist (elem _lanes)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/Lanes[] _lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lanes (let (r) (dotimes (i n) (push (instance route_mission_handler::Lanes :init) r)) r))
     (dolist (elem- _lanes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::LanesArray :md5sum-) "d3abd4115c3fc87ecb0786239ac4161a")
(setf (get route_mission_handler::LanesArray :datatype-) "route_mission_handler/LanesArray")
(setf (get route_mission_handler::LanesArray :definition-)
      "Lanes[] lanes

================================================================================
MSG: route_mission_handler/Lanes
int32 type
int32 NORMAL=0
int32 SPLIT_LEFT=1
int32 SPLIT_RIGHT=2
int32 MERGE_TO_RIGHT=3
int32 MERGE_TO_LEFT=4
int32 TOBE_MERGED=5
int32 SPLIT_STRAIGHT=6

int32 id
bool isTurn
bool direction
int32 laneno
int32[] nexts
int32[] roadLineIds
Waypoints[] points
int32 max_speed_limit
int32 roadType

================================================================================
MSG: route_mission_handler/Waypoints
int32 laneId
int32 pointId
float32 roadWidth
float32 distToRightLine
float32 distToLeftLine
float32 right_road_bound
float32 left_road_bound
float32 curve
float32 slope
float32 bank_angle
geometry_msgs/Pose pose
int32[] markerIds
int32[] markerTypes

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



(provide :route_mission_handler/LanesArray "d3abd4115c3fc87ecb0786239ac4161a")


