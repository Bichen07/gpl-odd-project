;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::PathsArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'PathsArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PATHSARRAY")
  (make-package "ROUTE_MISSION_HANDLER::PATHSARRAY"))

(in-package "ROS")
;;//! \htmlinclude PathsArray.msg.html


(defclass route_mission_handler::PathsArray
  :super ros::object
  :slots (_paths ))

(defmethod route_mission_handler::PathsArray
  (:init
   (&key
    ((:paths __paths) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Paths :init) r)) r))
    )
   (send-super :init)
   (setq _paths __paths)
   self)
  (:paths
   (&rest __paths)
   (if (keywordp (car __paths))
       (send* _paths __paths)
     (progn
       (if __paths (setq _paths (car __paths)))
       _paths)))
  (:serialization-length
   ()
   (+
    ;; route_mission_handler/Paths[] _paths
    (apply #'+ (send-all _paths :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/Paths[] _paths
     (write-long (length _paths) s)
     (dolist (elem _paths)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/Paths[] _paths
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _paths (let (r) (dotimes (i n) (push (instance route_mission_handler::Paths :init) r)) r))
     (dolist (elem- _paths)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::PathsArray :md5sum-) "41d15ff121904e5150d2e5a68706b573")
(setf (get route_mission_handler::PathsArray :datatype-) "route_mission_handler/PathsArray")
(setf (get route_mission_handler::PathsArray :definition-)
      "Paths[] paths

================================================================================
MSG: route_mission_handler/Paths
string name
string handdrive
Lanes[] lanes
float64[] distances
uint32[] directions
bool isParkingPath

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



(provide :route_mission_handler/PathsArray "41d15ff121904e5150d2e5a68706b573")


