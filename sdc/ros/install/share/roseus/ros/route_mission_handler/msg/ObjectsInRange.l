;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ObjectsInRange)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ObjectsInRange (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::OBJECTSINRANGE")
  (make-package "ROUTE_MISSION_HANDLER::OBJECTSINRANGE"))

(in-package "ROS")
;;//! \htmlinclude ObjectsInRange.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass route_mission_handler::ObjectsInRange
  :super ros::object
  :slots (_changed _range _lanes _objects ))

(defmethod route_mission_handler::ObjectsInRange
  (:init
   (&key
    ((:changed __changed) nil)
    ((:range __range) (instance geometry_msgs::Polygon :init))
    ((:lanes __lanes) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Lanes :init) r)) r))
    ((:objects __objects) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Polygon :init) r)) r))
    )
   (send-super :init)
   (setq _changed __changed)
   (setq _range __range)
   (setq _lanes __lanes)
   (setq _objects __objects)
   self)
  (:changed
   (&optional __changed)
   (if __changed (setq _changed __changed)) _changed)
  (:range
   (&rest __range)
   (if (keywordp (car __range))
       (send* _range __range)
     (progn
       (if __range (setq _range (car __range)))
       _range)))
  (:lanes
   (&rest __lanes)
   (if (keywordp (car __lanes))
       (send* _lanes __lanes)
     (progn
       (if __lanes (setq _lanes (car __lanes)))
       _lanes)))
  (:objects
   (&rest __objects)
   (if (keywordp (car __objects))
       (send* _objects __objects)
     (progn
       (if __objects (setq _objects (car __objects)))
       _objects)))
  (:serialization-length
   ()
   (+
    ;; bool _changed
    1
    ;; geometry_msgs/Polygon _range
    (send _range :serialization-length)
    ;; route_mission_handler/Lanes[] _lanes
    (apply #'+ (send-all _lanes :serialization-length)) 4
    ;; geometry_msgs/Polygon[] _objects
    (apply #'+ (send-all _objects :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _changed
       (if _changed (write-byte -1 s) (write-byte 0 s))
     ;; geometry_msgs/Polygon _range
       (send _range :serialize s)
     ;; route_mission_handler/Lanes[] _lanes
     (write-long (length _lanes) s)
     (dolist (elem _lanes)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Polygon[] _objects
     (write-long (length _objects) s)
     (dolist (elem _objects)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _changed
     (setq _changed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; geometry_msgs/Polygon _range
     (send _range :deserialize buf ptr-) (incf ptr- (send _range :serialization-length))
   ;; route_mission_handler/Lanes[] _lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lanes (let (r) (dotimes (i n) (push (instance route_mission_handler::Lanes :init) r)) r))
     (dolist (elem- _lanes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Polygon[] _objects
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _objects (let (r) (dotimes (i n) (push (instance geometry_msgs::Polygon :init) r)) r))
     (dolist (elem- _objects)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::ObjectsInRange :md5sum-) "23414e3f925d00431df85f0ca877074c")
(setf (get route_mission_handler::ObjectsInRange :datatype-) "route_mission_handler/ObjectsInRange")
(setf (get route_mission_handler::ObjectsInRange :definition-)
      "bool changed
geometry_msgs/Polygon range
route_mission_handler/Lanes[] lanes
geometry_msgs/Polygon[] objects

================================================================================
MSG: geometry_msgs/Polygon
#A specification of a polygon where the first and last points are assumed to be connected
Point32[] points

================================================================================
MSG: geometry_msgs/Point32
# This contains the position of a point in free space(with 32 bits of precision).
# It is recommeded to use Point wherever possible instead of Point32.  
# 
# This recommendation is to promote interoperability.  
#
# This message is designed to take up less space when sending
# lots of points at once, as in the case of a PointCloud.  

float32 x
float32 y
float32 z
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



(provide :route_mission_handler/ObjectsInRange "23414e3f925d00431df85f0ca877074c")


