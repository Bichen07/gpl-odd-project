;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ParkingSpace)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ParkingSpace (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE")
  (make-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))

(in-package "ROS")
;;//! \htmlinclude ParkingSpace.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*VERTICAL*" (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(shadow '*VERTICAL* (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(defconstant route_mission_handler::ParkingSpace::*VERTICAL* 0)
(intern "*PARALLEL*" (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(shadow '*PARALLEL* (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(defconstant route_mission_handler::ParkingSpace::*PARALLEL* 1)
(intern "*OBLIQUE*" (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(shadow '*OBLIQUE* (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(defconstant route_mission_handler::ParkingSpace::*OBLIQUE* 2)
(intern "*RIGHT*" (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(shadow '*RIGHT* (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(defconstant route_mission_handler::ParkingSpace::*RIGHT* 0)
(intern "*LEFT*" (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(shadow '*LEFT* (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACE"))
(defconstant route_mission_handler::ParkingSpace::*LEFT* 1)
(defclass route_mission_handler::ParkingSpace
  :super ros::object
  :slots (_type _side _id _parkingLotId _laneId _pointId _orderType _points ))

(defmethod route_mission_handler::ParkingSpace
  (:init
   (&key
    ((:type __type) 0)
    ((:side __side) 0)
    ((:id __id) 0)
    ((:parkingLotId __parkingLotId) 0)
    ((:laneId __laneId) 0)
    ((:pointId __pointId) 0)
    ((:orderType __orderType) 0)
    ((:points __points) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    )
   (send-super :init)
   (setq _type (round __type))
   (setq _side (round __side))
   (setq _id (round __id))
   (setq _parkingLotId (round __parkingLotId))
   (setq _laneId (round __laneId))
   (setq _pointId (round __pointId))
   (setq _orderType (round __orderType))
   (setq _points __points)
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:side
   (&optional __side)
   (if __side (setq _side __side)) _side)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:parkingLotId
   (&optional __parkingLotId)
   (if __parkingLotId (setq _parkingLotId __parkingLotId)) _parkingLotId)
  (:laneId
   (&optional __laneId)
   (if __laneId (setq _laneId __laneId)) _laneId)
  (:pointId
   (&optional __pointId)
   (if __pointId (setq _pointId __pointId)) _pointId)
  (:orderType
   (&optional __orderType)
   (if __orderType (setq _orderType __orderType)) _orderType)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:serialization-length
   ()
   (+
    ;; int32 _type
    4
    ;; int32 _side
    4
    ;; int32 _id
    4
    ;; int32 _parkingLotId
    4
    ;; int32 _laneId
    4
    ;; int32 _pointId
    4
    ;; int32 _orderType
    4
    ;; geometry_msgs/Point[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _type
       (write-long _type s)
     ;; int32 _side
       (write-long _side s)
     ;; int32 _id
       (write-long _id s)
     ;; int32 _parkingLotId
       (write-long _parkingLotId s)
     ;; int32 _laneId
       (write-long _laneId s)
     ;; int32 _pointId
       (write-long _pointId s)
     ;; int32 _orderType
       (write-long _orderType s)
     ;; geometry_msgs/Point[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _side
     (setq _side (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _parkingLotId
     (setq _parkingLotId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _laneId
     (setq _laneId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pointId
     (setq _pointId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _orderType
     (setq _orderType (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::ParkingSpace :md5sum-) "98fbce91faa2b53804e2c7e966c04f2d")
(setf (get route_mission_handler::ParkingSpace :datatype-) "route_mission_handler/ParkingSpace")
(setf (get route_mission_handler::ParkingSpace :definition-)
      "int32 type
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

")



(provide :route_mission_handler/ParkingSpace "98fbce91faa2b53804e2c7e966c04f2d")


