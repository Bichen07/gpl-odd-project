;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::CroadLanesArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'CroadLanesArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::CROADLANESARRAY")
  (make-package "ROUTE_MISSION_HANDLER::CROADLANESARRAY"))

(in-package "ROS")
;;//! \htmlinclude CroadLanesArray.msg.html


(defclass route_mission_handler::CroadLanesArray
  :super ros::object
  :slots (_name _clanes ))

(defmethod route_mission_handler::CroadLanesArray
  (:init
   (&key
    ((:name __name) "")
    ((:clanes __clanes) (let (r) (dotimes (i 0) (push (instance route_mission_handler::CroadLanes :init) r)) r))
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _clanes __clanes)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:clanes
   (&rest __clanes)
   (if (keywordp (car __clanes))
       (send* _clanes __clanes)
     (progn
       (if __clanes (setq _clanes (car __clanes)))
       _clanes)))
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; route_mission_handler/CroadLanes[] _clanes
    (apply #'+ (send-all _clanes :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; route_mission_handler/CroadLanes[] _clanes
     (write-long (length _clanes) s)
     (dolist (elem _clanes)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; route_mission_handler/CroadLanes[] _clanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _clanes (let (r) (dotimes (i n) (push (instance route_mission_handler::CroadLanes :init) r)) r))
     (dolist (elem- _clanes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::CroadLanesArray :md5sum-) "498cf78e2ebab6d12896dc763a3009fe")
(setf (get route_mission_handler::CroadLanesArray :datatype-) "route_mission_handler/CroadLanesArray")
(setf (get route_mission_handler::CroadLanesArray :definition-)
      "string name
CroadLanes[] clanes

================================================================================
MSG: route_mission_handler/CroadLanes
Croad cr1
Croad cr2
Lane[] lanes

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

")



(provide :route_mission_handler/CroadLanesArray "498cf78e2ebab6d12896dc763a3009fe")


