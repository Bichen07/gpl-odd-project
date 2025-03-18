;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ParkingLane)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ParkingLane (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PARKINGLANE")
  (make-package "ROUTE_MISSION_HANDLER::PARKINGLANE"))

(in-package "ROS")
;;//! \htmlinclude ParkingLane.msg.html


(defclass route_mission_handler::ParkingLane
  :super ros::object
  :slots (_id _parkingLotId _points _waypoints ))

(defmethod route_mission_handler::ParkingLane
  (:init
   (&key
    ((:id __id) 0)
    ((:parkingLotId __parkingLotId) 0)
    ((:points __points) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ParkingLanePoint :init) r)) r))
    ((:waypoints __waypoints) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Waypoints :init) r)) r))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _parkingLotId (round __parkingLotId))
   (setq _points __points)
   (setq _waypoints __waypoints)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:parkingLotId
   (&optional __parkingLotId)
   (if __parkingLotId (setq _parkingLotId __parkingLotId)) _parkingLotId)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32 _parkingLotId
    4
    ;; route_mission_handler/ParkingLanePoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ;; route_mission_handler/Waypoints[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32 _parkingLotId
       (write-long _parkingLotId s)
     ;; route_mission_handler/ParkingLanePoint[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;; route_mission_handler/Waypoints[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _parkingLotId
     (setq _parkingLotId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; route_mission_handler/ParkingLanePoint[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance route_mission_handler::ParkingLanePoint :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; route_mission_handler/Waypoints[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance route_mission_handler::Waypoints :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::ParkingLane :md5sum-) "0e1aa0913f8aac2613da9735cb478990")
(setf (get route_mission_handler::ParkingLane :datatype-) "route_mission_handler/ParkingLane")
(setf (get route_mission_handler::ParkingLane :definition-)
      "int32 id
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



(provide :route_mission_handler/ParkingLane "0e1aa0913f8aac2613da9735cb478990")


