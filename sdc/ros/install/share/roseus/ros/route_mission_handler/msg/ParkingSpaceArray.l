;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ParkingSpaceArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ParkingSpaceArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PARKINGSPACEARRAY")
  (make-package "ROUTE_MISSION_HANDLER::PARKINGSPACEARRAY"))

(in-package "ROS")
;;//! \htmlinclude ParkingSpaceArray.msg.html


(defclass route_mission_handler::ParkingSpaceArray
  :super ros::object
  :slots (_spaces ))

(defmethod route_mission_handler::ParkingSpaceArray
  (:init
   (&key
    ((:spaces __spaces) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ParkingSpace :init) r)) r))
    )
   (send-super :init)
   (setq _spaces __spaces)
   self)
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
    ;; route_mission_handler/ParkingSpace[] _spaces
    (apply #'+ (send-all _spaces :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/ParkingSpace[] _spaces
     (write-long (length _spaces) s)
     (dolist (elem _spaces)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
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

(setf (get route_mission_handler::ParkingSpaceArray :md5sum-) "b8e941ec972f8a9821ad740811fc6845")
(setf (get route_mission_handler::ParkingSpaceArray :datatype-) "route_mission_handler/ParkingSpaceArray")
(setf (get route_mission_handler::ParkingSpaceArray :definition-)
      "ParkingSpace[] spaces

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

")



(provide :route_mission_handler/ParkingSpaceArray "b8e941ec972f8a9821ad740811fc6845")


