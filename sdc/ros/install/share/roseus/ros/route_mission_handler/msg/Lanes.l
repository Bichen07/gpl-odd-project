;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::Lanes)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'Lanes (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::LANES")
  (make-package "ROUTE_MISSION_HANDLER::LANES"))

(in-package "ROS")
;;//! \htmlinclude Lanes.msg.html


(intern "*NORMAL*" (find-package "ROUTE_MISSION_HANDLER::LANES"))
(shadow '*NORMAL* (find-package "ROUTE_MISSION_HANDLER::LANES"))
(defconstant route_mission_handler::Lanes::*NORMAL* 0)
(intern "*SPLIT_LEFT*" (find-package "ROUTE_MISSION_HANDLER::LANES"))
(shadow '*SPLIT_LEFT* (find-package "ROUTE_MISSION_HANDLER::LANES"))
(defconstant route_mission_handler::Lanes::*SPLIT_LEFT* 1)
(intern "*SPLIT_RIGHT*" (find-package "ROUTE_MISSION_HANDLER::LANES"))
(shadow '*SPLIT_RIGHT* (find-package "ROUTE_MISSION_HANDLER::LANES"))
(defconstant route_mission_handler::Lanes::*SPLIT_RIGHT* 2)
(intern "*MERGE_TO_RIGHT*" (find-package "ROUTE_MISSION_HANDLER::LANES"))
(shadow '*MERGE_TO_RIGHT* (find-package "ROUTE_MISSION_HANDLER::LANES"))
(defconstant route_mission_handler::Lanes::*MERGE_TO_RIGHT* 3)
(intern "*MERGE_TO_LEFT*" (find-package "ROUTE_MISSION_HANDLER::LANES"))
(shadow '*MERGE_TO_LEFT* (find-package "ROUTE_MISSION_HANDLER::LANES"))
(defconstant route_mission_handler::Lanes::*MERGE_TO_LEFT* 4)
(intern "*TOBE_MERGED*" (find-package "ROUTE_MISSION_HANDLER::LANES"))
(shadow '*TOBE_MERGED* (find-package "ROUTE_MISSION_HANDLER::LANES"))
(defconstant route_mission_handler::Lanes::*TOBE_MERGED* 5)
(intern "*SPLIT_STRAIGHT*" (find-package "ROUTE_MISSION_HANDLER::LANES"))
(shadow '*SPLIT_STRAIGHT* (find-package "ROUTE_MISSION_HANDLER::LANES"))
(defconstant route_mission_handler::Lanes::*SPLIT_STRAIGHT* 6)
(defclass route_mission_handler::Lanes
  :super ros::object
  :slots (_type _id _isTurn _direction _laneno _nexts _roadLineIds _points _max_speed_limit _roadType ))

(defmethod route_mission_handler::Lanes
  (:init
   (&key
    ((:type __type) 0)
    ((:id __id) 0)
    ((:isTurn __isTurn) nil)
    ((:direction __direction) nil)
    ((:laneno __laneno) 0)
    ((:nexts __nexts) (make-array 0 :initial-element 0 :element-type :integer))
    ((:roadLineIds __roadLineIds) (make-array 0 :initial-element 0 :element-type :integer))
    ((:points __points) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Waypoints :init) r)) r))
    ((:max_speed_limit __max_speed_limit) 0)
    ((:roadType __roadType) 0)
    )
   (send-super :init)
   (setq _type (round __type))
   (setq _id (round __id))
   (setq _isTurn __isTurn)
   (setq _direction __direction)
   (setq _laneno (round __laneno))
   (setq _nexts __nexts)
   (setq _roadLineIds __roadLineIds)
   (setq _points __points)
   (setq _max_speed_limit (round __max_speed_limit))
   (setq _roadType (round __roadType))
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:isTurn
   (&optional __isTurn)
   (if __isTurn (setq _isTurn __isTurn)) _isTurn)
  (:direction
   (&optional __direction)
   (if __direction (setq _direction __direction)) _direction)
  (:laneno
   (&optional __laneno)
   (if __laneno (setq _laneno __laneno)) _laneno)
  (:nexts
   (&optional __nexts)
   (if __nexts (setq _nexts __nexts)) _nexts)
  (:roadLineIds
   (&optional __roadLineIds)
   (if __roadLineIds (setq _roadLineIds __roadLineIds)) _roadLineIds)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:max_speed_limit
   (&optional __max_speed_limit)
   (if __max_speed_limit (setq _max_speed_limit __max_speed_limit)) _max_speed_limit)
  (:roadType
   (&optional __roadType)
   (if __roadType (setq _roadType __roadType)) _roadType)
  (:serialization-length
   ()
   (+
    ;; int32 _type
    4
    ;; int32 _id
    4
    ;; bool _isTurn
    1
    ;; bool _direction
    1
    ;; int32 _laneno
    4
    ;; int32[] _nexts
    (* 4    (length _nexts)) 4
    ;; int32[] _roadLineIds
    (* 4    (length _roadLineIds)) 4
    ;; route_mission_handler/Waypoints[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ;; int32 _max_speed_limit
    4
    ;; int32 _roadType
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _type
       (write-long _type s)
     ;; int32 _id
       (write-long _id s)
     ;; bool _isTurn
       (if _isTurn (write-byte -1 s) (write-byte 0 s))
     ;; bool _direction
       (if _direction (write-byte -1 s) (write-byte 0 s))
     ;; int32 _laneno
       (write-long _laneno s)
     ;; int32[] _nexts
     (write-long (length _nexts) s)
     (dotimes (i (length _nexts))
       (write-long (elt _nexts i) s)
       )
     ;; int32[] _roadLineIds
     (write-long (length _roadLineIds) s)
     (dotimes (i (length _roadLineIds))
       (write-long (elt _roadLineIds i) s)
       )
     ;; route_mission_handler/Waypoints[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;; int32 _max_speed_limit
       (write-long _max_speed_limit s)
     ;; int32 _roadType
       (write-long _roadType s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _isTurn
     (setq _isTurn (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _direction
     (setq _direction (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _laneno
     (setq _laneno (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _nexts
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _nexts (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _nexts i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _roadLineIds
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _roadLineIds (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _roadLineIds i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; route_mission_handler/Waypoints[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance route_mission_handler::Waypoints :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int32 _max_speed_limit
     (setq _max_speed_limit (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _roadType
     (setq _roadType (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get route_mission_handler::Lanes :md5sum-) "ae56afad30bb76720a91ad99b362bf2c")
(setf (get route_mission_handler::Lanes :datatype-) "route_mission_handler/Lanes")
(setf (get route_mission_handler::Lanes :definition-)
      "int32 type
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



(provide :route_mission_handler/Lanes "ae56afad30bb76720a91ad99b362bf2c")


