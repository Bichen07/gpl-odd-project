;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ParkingLanePoint)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ParkingLanePoint (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PARKINGLANEPOINT")
  (make-package "ROUTE_MISSION_HANDLER::PARKINGLANEPOINT"))

(in-package "ROS")
;;//! \htmlinclude ParkingLanePoint.msg.html


(defclass route_mission_handler::ParkingLanePoint
  :super ros::object
  :slots (_laneId _pointId ))

(defmethod route_mission_handler::ParkingLanePoint
  (:init
   (&key
    ((:laneId __laneId) 0)
    ((:pointId __pointId) 0)
    )
   (send-super :init)
   (setq _laneId (round __laneId))
   (setq _pointId (round __pointId))
   self)
  (:laneId
   (&optional __laneId)
   (if __laneId (setq _laneId __laneId)) _laneId)
  (:pointId
   (&optional __pointId)
   (if __pointId (setq _pointId __pointId)) _pointId)
  (:serialization-length
   ()
   (+
    ;; int32 _laneId
    4
    ;; int32 _pointId
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _laneId
       (write-long _laneId s)
     ;; int32 _pointId
       (write-long _pointId s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _laneId
     (setq _laneId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pointId
     (setq _pointId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get route_mission_handler::ParkingLanePoint :md5sum-) "6691fee89f0c6fc6322a781cc640418b")
(setf (get route_mission_handler::ParkingLanePoint :datatype-) "route_mission_handler/ParkingLanePoint")
(setf (get route_mission_handler::ParkingLanePoint :definition-)
      "int32 laneId
int32 pointId

")



(provide :route_mission_handler/ParkingLanePoint "6691fee89f0c6fc6322a781cc640418b")


