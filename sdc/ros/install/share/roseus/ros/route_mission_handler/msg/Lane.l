;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::Lane)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'Lane (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::LANE")
  (make-package "ROUTE_MISSION_HANDLER::LANE"))

(in-package "ROS")
;;//! \htmlinclude Lane.msg.html


(intern "*NORMAL*" (find-package "ROUTE_MISSION_HANDLER::LANE"))
(shadow '*NORMAL* (find-package "ROUTE_MISSION_HANDLER::LANE"))
(defconstant route_mission_handler::Lane::*NORMAL* 0)
(intern "*SPLIT_LEFT*" (find-package "ROUTE_MISSION_HANDLER::LANE"))
(shadow '*SPLIT_LEFT* (find-package "ROUTE_MISSION_HANDLER::LANE"))
(defconstant route_mission_handler::Lane::*SPLIT_LEFT* 1)
(intern "*SPLIT_RIGHT*" (find-package "ROUTE_MISSION_HANDLER::LANE"))
(shadow '*SPLIT_RIGHT* (find-package "ROUTE_MISSION_HANDLER::LANE"))
(defconstant route_mission_handler::Lane::*SPLIT_RIGHT* 2)
(intern "*MERGE_TO_RIGHT*" (find-package "ROUTE_MISSION_HANDLER::LANE"))
(shadow '*MERGE_TO_RIGHT* (find-package "ROUTE_MISSION_HANDLER::LANE"))
(defconstant route_mission_handler::Lane::*MERGE_TO_RIGHT* 3)
(intern "*MERGE_TO_LEFT*" (find-package "ROUTE_MISSION_HANDLER::LANE"))
(shadow '*MERGE_TO_LEFT* (find-package "ROUTE_MISSION_HANDLER::LANE"))
(defconstant route_mission_handler::Lane::*MERGE_TO_LEFT* 4)
(intern "*TOBE_MERGED*" (find-package "ROUTE_MISSION_HANDLER::LANE"))
(shadow '*TOBE_MERGED* (find-package "ROUTE_MISSION_HANDLER::LANE"))
(defconstant route_mission_handler::Lane::*TOBE_MERGED* 5)
(intern "*SPLIT_STRAIGHT*" (find-package "ROUTE_MISSION_HANDLER::LANE"))
(shadow '*SPLIT_STRAIGHT* (find-package "ROUTE_MISSION_HANDLER::LANE"))
(defconstant route_mission_handler::Lane::*SPLIT_STRAIGHT* 6)
(defclass route_mission_handler::Lane
  :super ros::object
  :slots (_lane_id _nroad_ids _is_intersection _is_positive _waypoints _next_lanes _left_lanes _right_lanes _max_speed_limit _order _roadType _type ))

(defmethod route_mission_handler::Lane
  (:init
   (&key
    ((:lane_id __lane_id) 0)
    ((:nroad_ids __nroad_ids) (make-array 0 :initial-element 0 :element-type :integer))
    ((:is_intersection __is_intersection) nil)
    ((:is_positive __is_positive) nil)
    ((:waypoints __waypoints) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Waypoint :init) r)) r))
    ((:next_lanes __next_lanes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:left_lanes __left_lanes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:right_lanes __right_lanes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:max_speed_limit __max_speed_limit) 0)
    ((:order __order) 0)
    ((:roadType __roadType) 0)
    ((:type __type) 0)
    )
   (send-super :init)
   (setq _lane_id (round __lane_id))
   (setq _nroad_ids __nroad_ids)
   (setq _is_intersection __is_intersection)
   (setq _is_positive __is_positive)
   (setq _waypoints __waypoints)
   (setq _next_lanes __next_lanes)
   (setq _left_lanes __left_lanes)
   (setq _right_lanes __right_lanes)
   (setq _max_speed_limit (round __max_speed_limit))
   (setq _order (round __order))
   (setq _roadType (round __roadType))
   (setq _type (round __type))
   self)
  (:lane_id
   (&optional __lane_id)
   (if __lane_id (setq _lane_id __lane_id)) _lane_id)
  (:nroad_ids
   (&optional __nroad_ids)
   (if __nroad_ids (setq _nroad_ids __nroad_ids)) _nroad_ids)
  (:is_intersection
   (&optional __is_intersection)
   (if __is_intersection (setq _is_intersection __is_intersection)) _is_intersection)
  (:is_positive
   (&optional __is_positive)
   (if __is_positive (setq _is_positive __is_positive)) _is_positive)
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:next_lanes
   (&optional __next_lanes)
   (if __next_lanes (setq _next_lanes __next_lanes)) _next_lanes)
  (:left_lanes
   (&optional __left_lanes)
   (if __left_lanes (setq _left_lanes __left_lanes)) _left_lanes)
  (:right_lanes
   (&optional __right_lanes)
   (if __right_lanes (setq _right_lanes __right_lanes)) _right_lanes)
  (:max_speed_limit
   (&optional __max_speed_limit)
   (if __max_speed_limit (setq _max_speed_limit __max_speed_limit)) _max_speed_limit)
  (:order
   (&optional __order)
   (if __order (setq _order __order)) _order)
  (:roadType
   (&optional __roadType)
   (if __roadType (setq _roadType __roadType)) _roadType)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:serialization-length
   ()
   (+
    ;; int32 _lane_id
    4
    ;; int32[] _nroad_ids
    (* 4    (length _nroad_ids)) 4
    ;; bool _is_intersection
    1
    ;; bool _is_positive
    1
    ;; route_mission_handler/Waypoint[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ;; int32[] _next_lanes
    (* 4    (length _next_lanes)) 4
    ;; int32[] _left_lanes
    (* 4    (length _left_lanes)) 4
    ;; int32[] _right_lanes
    (* 4    (length _right_lanes)) 4
    ;; int32 _max_speed_limit
    4
    ;; uint32 _order
    4
    ;; int32 _roadType
    4
    ;; int32 _type
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _lane_id
       (write-long _lane_id s)
     ;; int32[] _nroad_ids
     (write-long (length _nroad_ids) s)
     (dotimes (i (length _nroad_ids))
       (write-long (elt _nroad_ids i) s)
       )
     ;; bool _is_intersection
       (if _is_intersection (write-byte -1 s) (write-byte 0 s))
     ;; bool _is_positive
       (if _is_positive (write-byte -1 s) (write-byte 0 s))
     ;; route_mission_handler/Waypoint[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;; int32[] _next_lanes
     (write-long (length _next_lanes) s)
     (dotimes (i (length _next_lanes))
       (write-long (elt _next_lanes i) s)
       )
     ;; int32[] _left_lanes
     (write-long (length _left_lanes) s)
     (dotimes (i (length _left_lanes))
       (write-long (elt _left_lanes i) s)
       )
     ;; int32[] _right_lanes
     (write-long (length _right_lanes) s)
     (dotimes (i (length _right_lanes))
       (write-long (elt _right_lanes i) s)
       )
     ;; int32 _max_speed_limit
       (write-long _max_speed_limit s)
     ;; uint32 _order
       (write-long _order s)
     ;; int32 _roadType
       (write-long _roadType s)
     ;; int32 _type
       (write-long _type s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _lane_id
     (setq _lane_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _nroad_ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _nroad_ids (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _nroad_ids i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; bool _is_intersection
     (setq _is_intersection (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _is_positive
     (setq _is_positive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; route_mission_handler/Waypoint[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance route_mission_handler::Waypoint :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int32[] _next_lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _next_lanes (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _next_lanes i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _left_lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _left_lanes (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _left_lanes i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _right_lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _right_lanes (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _right_lanes i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32 _max_speed_limit
     (setq _max_speed_limit (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _order
     (setq _order (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _roadType
     (setq _roadType (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get route_mission_handler::Lane :md5sum-) "a85d726fdccc9baacc78994caaac890b")
(setf (get route_mission_handler::Lane :datatype-) "route_mission_handler/Lane")
(setf (get route_mission_handler::Lane :definition-)
      "int32 NORMAL=0
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



(provide :route_mission_handler/Lane "a85d726fdccc9baacc78994caaac890b")


