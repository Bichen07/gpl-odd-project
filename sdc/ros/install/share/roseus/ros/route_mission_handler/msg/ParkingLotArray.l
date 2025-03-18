;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ParkingLotArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ParkingLotArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PARKINGLOTARRAY")
  (make-package "ROUTE_MISSION_HANDLER::PARKINGLOTARRAY"))

(in-package "ROS")
;;//! \htmlinclude ParkingLotArray.msg.html


(defclass route_mission_handler::ParkingLotArray
  :super ros::object
  :slots (_lots ))

(defmethod route_mission_handler::ParkingLotArray
  (:init
   (&key
    ((:lots __lots) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ParkingLot :init) r)) r))
    )
   (send-super :init)
   (setq _lots __lots)
   self)
  (:lots
   (&rest __lots)
   (if (keywordp (car __lots))
       (send* _lots __lots)
     (progn
       (if __lots (setq _lots (car __lots)))
       _lots)))
  (:serialization-length
   ()
   (+
    ;; route_mission_handler/ParkingLot[] _lots
    (apply #'+ (send-all _lots :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/ParkingLot[] _lots
     (write-long (length _lots) s)
     (dolist (elem _lots)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/ParkingLot[] _lots
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lots (let (r) (dotimes (i n) (push (instance route_mission_handler::ParkingLot :init) r)) r))
     (dolist (elem- _lots)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::ParkingLotArray :md5sum-) "4c437145053afac28f11d22149a5aaf7")
(setf (get route_mission_handler::ParkingLotArray :datatype-) "route_mission_handler/ParkingLotArray")
(setf (get route_mission_handler::ParkingLotArray :definition-)
      "ParkingLot[] lots

================================================================================
MSG: route_mission_handler/ParkingLot
int32 id
string name
bool croad1_positive
bool croad2_positive
int32 nav_croad_id
int32 pointId1
int32 nav_croad_id2
int32 pointId2
ParkingSpaceArray space_list
LaneArray lot_lines
ParkingLane[] lanes
ParkingSpace[] spaces

================================================================================
MSG: route_mission_handler/ParkingSpaceArray
ParkingSpace[] spaces

================================================================================
MSG: route_mission_handler/ParkingSpace
int32 type
int32 VERTICAL=0
int32 PARALLEL=1
int32 OBLIQUE=2

int32 side
int32 RIGHT=0
int32 LEFT=1

int32 id
int32 parkingLotId
int32 laneId
int32 pointId
int32 orderType
geometry_msgs/Point[] points

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: route_mission_handler/LaneArray
Lane[] lanes

================================================================================
MSG: route_mission_handler/Lane
int32 NORMAL=0
int32 SPLIT_LEFT=1
int32 SPLIT_RIGHT=2
int32 MERGE_TO_RIGHT=3
int32 MERGE_TO_LEFT=4
int32 TOBE_MERGED=5
int32 SPLIT_STRAIGHT=6

int32 lane_id
int32[] nroad_ids
bool is_intersection
bool is_positive
Waypoint[] waypoints
int32[] next_lanes
int32[] left_lanes
int32[] right_lanes
int32 max_speed_limit
uint32 order
int32 roadType
int32 type

================================================================================
MSG: route_mission_handler/Waypoint
int32 lane_id
int32 point_id
int32 nroad_id
float32 roadWidth
float32 distToRightLine
float32 distToLeftLine
float32 right_road_bound
float32 left_road_bound
float32 curvature
float32 heading
geometry_msgs/Point point
int32[] markerIds
int32[] markerTypes
int32 parkingLotId
int32 parkingLotLaneId

================================================================================
MSG: route_mission_handler/ParkingLane
int32 id
int32 parkingLotId
ParkingLanePoint[] points
Waypoints[] waypoints

================================================================================
MSG: route_mission_handler/ParkingLanePoint
int32 laneId
int32 pointId

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
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :route_mission_handler/ParkingLotArray "4c437145053afac28f11d22149a5aaf7")


