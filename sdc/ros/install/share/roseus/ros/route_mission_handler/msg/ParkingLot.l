;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ParkingLot)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ParkingLot (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PARKINGLOT")
  (make-package "ROUTE_MISSION_HANDLER::PARKINGLOT"))

(in-package "ROS")
;;//! \htmlinclude ParkingLot.msg.html


(defclass route_mission_handler::ParkingLot
  :super ros::object
  :slots (_id _name _croad1_positive _croad2_positive _nav_croad_id _pointId1 _nav_croad_id2 _pointId2 _space_list _lot_lines _lanes _spaces ))

(defmethod route_mission_handler::ParkingLot
  (:init
   (&key
    ((:id __id) 0)
    ((:name __name) "")
    ((:croad1_positive __croad1_positive) nil)
    ((:croad2_positive __croad2_positive) nil)
    ((:nav_croad_id __nav_croad_id) 0)
    ((:pointId1 __pointId1) 0)
    ((:nav_croad_id2 __nav_croad_id2) 0)
    ((:pointId2 __pointId2) 0)
    ((:space_list __space_list) (instance route_mission_handler::ParkingSpaceArray :init))
    ((:lot_lines __lot_lines) (instance route_mission_handler::LaneArray :init))
    ((:lanes __lanes) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ParkingLane :init) r)) r))
    ((:spaces __spaces) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ParkingSpace :init) r)) r))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _name (string __name))
   (setq _croad1_positive __croad1_positive)
   (setq _croad2_positive __croad2_positive)
   (setq _nav_croad_id (round __nav_croad_id))
   (setq _pointId1 (round __pointId1))
   (setq _nav_croad_id2 (round __nav_croad_id2))
   (setq _pointId2 (round __pointId2))
   (setq _space_list __space_list)
   (setq _lot_lines __lot_lines)
   (setq _lanes __lanes)
   (setq _spaces __spaces)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:croad1_positive
   (&optional __croad1_positive)
   (if __croad1_positive (setq _croad1_positive __croad1_positive)) _croad1_positive)
  (:croad2_positive
   (&optional __croad2_positive)
   (if __croad2_positive (setq _croad2_positive __croad2_positive)) _croad2_positive)
  (:nav_croad_id
   (&optional __nav_croad_id)
   (if __nav_croad_id (setq _nav_croad_id __nav_croad_id)) _nav_croad_id)
  (:pointId1
   (&optional __pointId1)
   (if __pointId1 (setq _pointId1 __pointId1)) _pointId1)
  (:nav_croad_id2
   (&optional __nav_croad_id2)
   (if __nav_croad_id2 (setq _nav_croad_id2 __nav_croad_id2)) _nav_croad_id2)
  (:pointId2
   (&optional __pointId2)
   (if __pointId2 (setq _pointId2 __pointId2)) _pointId2)
  (:space_list
   (&rest __space_list)
   (if (keywordp (car __space_list))
       (send* _space_list __space_list)
     (progn
       (if __space_list (setq _space_list (car __space_list)))
       _space_list)))
  (:lot_lines
   (&rest __lot_lines)
   (if (keywordp (car __lot_lines))
       (send* _lot_lines __lot_lines)
     (progn
       (if __lot_lines (setq _lot_lines (car __lot_lines)))
       _lot_lines)))
  (:lanes
   (&rest __lanes)
   (if (keywordp (car __lanes))
       (send* _lanes __lanes)
     (progn
       (if __lanes (setq _lanes (car __lanes)))
       _lanes)))
  (:spaces
   (&rest __spaces)
   (if (keywordp (car __spaces))
       (send* _spaces __spaces)
     (progn
       (if __spaces (setq _spaces (car __spaces)))
       _spaces)))
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; string _name
    4 (length _name)
    ;; bool _croad1_positive
    1
    ;; bool _croad2_positive
    1
    ;; int32 _nav_croad_id
    4
    ;; int32 _pointId1
    4
    ;; int32 _nav_croad_id2
    4
    ;; int32 _pointId2
    4
    ;; route_mission_handler/ParkingSpaceArray _space_list
    (send _space_list :serialization-length)
    ;; route_mission_handler/LaneArray _lot_lines
    (send _lot_lines :serialization-length)
    ;; route_mission_handler/ParkingLane[] _lanes
    (apply #'+ (send-all _lanes :serialization-length)) 4
    ;; route_mission_handler/ParkingSpace[] _spaces
    (apply #'+ (send-all _spaces :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _croad1_positive
       (if _croad1_positive (write-byte -1 s) (write-byte 0 s))
     ;; bool _croad2_positive
       (if _croad2_positive (write-byte -1 s) (write-byte 0 s))
     ;; int32 _nav_croad_id
       (write-long _nav_croad_id s)
     ;; int32 _pointId1
       (write-long _pointId1 s)
     ;; int32 _nav_croad_id2
       (write-long _nav_croad_id2 s)
     ;; int32 _pointId2
       (write-long _pointId2 s)
     ;; route_mission_handler/ParkingSpaceArray _space_list
       (send _space_list :serialize s)
     ;; route_mission_handler/LaneArray _lot_lines
       (send _lot_lines :serialize s)
     ;; route_mission_handler/ParkingLane[] _lanes
     (write-long (length _lanes) s)
     (dolist (elem _lanes)
       (send elem :serialize s)
       )
     ;; route_mission_handler/ParkingSpace[] _spaces
     (write-long (length _spaces) s)
     (dolist (elem _spaces)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _croad1_positive
     (setq _croad1_positive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _croad2_positive
     (setq _croad2_positive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _nav_croad_id
     (setq _nav_croad_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pointId1
     (setq _pointId1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _nav_croad_id2
     (setq _nav_croad_id2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pointId2
     (setq _pointId2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; route_mission_handler/ParkingSpaceArray _space_list
     (send _space_list :deserialize buf ptr-) (incf ptr- (send _space_list :serialization-length))
   ;; route_mission_handler/LaneArray _lot_lines
     (send _lot_lines :deserialize buf ptr-) (incf ptr- (send _lot_lines :serialization-length))
   ;; route_mission_handler/ParkingLane[] _lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lanes (let (r) (dotimes (i n) (push (instance route_mission_handler::ParkingLane :init) r)) r))
     (dolist (elem- _lanes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; route_mission_handler/ParkingSpace[] _spaces
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _spaces (let (r) (dotimes (i n) (push (instance route_mission_handler::ParkingSpace :init) r)) r))
     (dolist (elem- _spaces)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::ParkingLot :md5sum-) "232125321c146d4640eb356f707cd0da")
(setf (get route_mission_handler::ParkingLot :datatype-) "route_mission_handler/ParkingLot")
(setf (get route_mission_handler::ParkingLot :definition-)
      "int32 id
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



(provide :route_mission_handler/ParkingLot "232125321c146d4640eb356f707cd0da")


