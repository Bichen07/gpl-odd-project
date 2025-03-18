;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::Path)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'Path (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PATH")
  (make-package "ROUTE_MISSION_HANDLER::PATH"))

(in-package "ROS")
;;//! \htmlinclude Path.msg.html


(defclass route_mission_handler::Path
  :super ros::object
  :slots (_name _nroads _lanes _opposite_lanes _parkinglots ))

(defmethod route_mission_handler::Path
  (:init
   (&key
    ((:name __name) "")
    ((:nroads __nroads) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Croad :init) r)) r))
    ((:lanes __lanes) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Lane :init) r)) r))
    ((:opposite_lanes __opposite_lanes) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Lane :init) r)) r))
    ((:parkinglots __parkinglots) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ParkingLot :init) r)) r))
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _nroads __nroads)
   (setq _lanes __lanes)
   (setq _opposite_lanes __opposite_lanes)
   (setq _parkinglots __parkinglots)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:nroads
   (&rest __nroads)
   (if (keywordp (car __nroads))
       (send* _nroads __nroads)
     (progn
       (if __nroads (setq _nroads (car __nroads)))
       _nroads)))
  (:lanes
   (&rest __lanes)
   (if (keywordp (car __lanes))
       (send* _lanes __lanes)
     (progn
       (if __lanes (setq _lanes (car __lanes)))
       _lanes)))
  (:opposite_lanes
   (&rest __opposite_lanes)
   (if (keywordp (car __opposite_lanes))
       (send* _opposite_lanes __opposite_lanes)
     (progn
       (if __opposite_lanes (setq _opposite_lanes (car __opposite_lanes)))
       _opposite_lanes)))
  (:parkinglots
   (&rest __parkinglots)
   (if (keywordp (car __parkinglots))
       (send* _parkinglots __parkinglots)
     (progn
       (if __parkinglots (setq _parkinglots (car __parkinglots)))
       _parkinglots)))
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; route_mission_handler/Croad[] _nroads
    (apply #'+ (send-all _nroads :serialization-length)) 4
    ;; route_mission_handler/Lane[] _lanes
    (apply #'+ (send-all _lanes :serialization-length)) 4
    ;; route_mission_handler/Lane[] _opposite_lanes
    (apply #'+ (send-all _opposite_lanes :serialization-length)) 4
    ;; route_mission_handler/ParkingLot[] _parkinglots
    (apply #'+ (send-all _parkinglots :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; route_mission_handler/Croad[] _nroads
     (write-long (length _nroads) s)
     (dolist (elem _nroads)
       (send elem :serialize s)
       )
     ;; route_mission_handler/Lane[] _lanes
     (write-long (length _lanes) s)
     (dolist (elem _lanes)
       (send elem :serialize s)
       )
     ;; route_mission_handler/Lane[] _opposite_lanes
     (write-long (length _opposite_lanes) s)
     (dolist (elem _opposite_lanes)
       (send elem :serialize s)
       )
     ;; route_mission_handler/ParkingLot[] _parkinglots
     (write-long (length _parkinglots) s)
     (dolist (elem _parkinglots)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; route_mission_handler/Croad[] _nroads
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _nroads (let (r) (dotimes (i n) (push (instance route_mission_handler::Croad :init) r)) r))
     (dolist (elem- _nroads)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; route_mission_handler/Lane[] _lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lanes (let (r) (dotimes (i n) (push (instance route_mission_handler::Lane :init) r)) r))
     (dolist (elem- _lanes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; route_mission_handler/Lane[] _opposite_lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _opposite_lanes (let (r) (dotimes (i n) (push (instance route_mission_handler::Lane :init) r)) r))
     (dolist (elem- _opposite_lanes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; route_mission_handler/ParkingLot[] _parkinglots
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _parkinglots (let (r) (dotimes (i n) (push (instance route_mission_handler::ParkingLot :init) r)) r))
     (dolist (elem- _parkinglots)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::Path :md5sum-) "a3e40f12496a914a19bbb6f3f00e47a0")
(setf (get route_mission_handler::Path :datatype-) "route_mission_handler/Path")
(setf (get route_mission_handler::Path :definition-)
      "string name
Croad[] nroads
Lane[] lanes
Lane[] opposite_lanes
ParkingLot[] parkinglots

================================================================================
MSG: route_mission_handler/Croad
int32 nroad_id
bool isPositive
int32 point_id
int32[] lane_ids
geometry_msgs/Point[] points
bool fixed

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

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
MSG: route_mission_handler/LaneArray
Lane[] lanes

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



(provide :route_mission_handler/Path "a3e40f12496a914a19bbb6f3f00e47a0")


