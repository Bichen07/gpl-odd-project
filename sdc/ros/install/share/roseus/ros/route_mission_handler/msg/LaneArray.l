;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::LaneArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'LaneArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::LANEARRAY")
  (make-package "ROUTE_MISSION_HANDLER::LANEARRAY"))

(in-package "ROS")
;;//! \htmlinclude LaneArray.msg.html


(defclass route_mission_handler::LaneArray
  :super ros::object
  :slots (_lanes ))

(defmethod route_mission_handler::LaneArray
  (:init
   (&key
    ((:lanes __lanes) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Lane :init) r)) r))
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
    ;; route_mission_handler/Lane[] _lanes
    (apply #'+ (send-all _lanes :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/Lane[] _lanes
     (write-long (length _lanes) s)
     (dolist (elem _lanes)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/Lane[] _lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lanes (let (r) (dotimes (i n) (push (instance route_mission_handler::Lane :init) r)) r))
     (dolist (elem- _lanes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::LaneArray :md5sum-) "756a828a4cee6fecaec6bb44cdc5507f")
(setf (get route_mission_handler::LaneArray :datatype-) "route_mission_handler/LaneArray")
(setf (get route_mission_handler::LaneArray :definition-)
      "Lane[] lanes

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
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :route_mission_handler/LaneArray "756a828a4cee6fecaec6bb44cdc5507f")


